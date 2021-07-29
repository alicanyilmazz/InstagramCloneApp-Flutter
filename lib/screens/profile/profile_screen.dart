import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../comments/comments_screen.dart';
import '../../core/constant/enums/app_theme_enum.dart';
import '../../core/init/notifier/theme_notifier.dart';
import '../../cubits/cubits.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../core/components/dialog/error_dialog.dart';
import '../../core/components/image/user_profile_image.dart';
import '../../core/components/views/post_view.dart';
import '../../repositories/post/post_repository.dart';
import '../../repositories/user/user_repository.dart';
import 'bloc/profile_bloc.dart';
import 'widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreenArgs {
  final String userId;

  const ProfileScreenArgs({required this.userId});
}

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  static Route route({required ProfileScreenArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(
          userRepository: context.read<UserRepository>(),
          authBloc: context.read<AuthBloc>(),
          postRepository: context.read<PostRepository>(),
          likedPostsCubit: context.read<LikedPostsCubit>(),
        )..add(ProfileLoadUser(userId: args.userId)),
        child: ProfileScreen(),
      ),
    );
  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
 late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.error) {
          showDialog(
            context: context,
            barrierColor: Colors.black45,
            builder: (context) => ErrorDialog(
              content: state.failure.message,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.user.username,
            ),
            actions: [
              if (state.isCurrentUser)
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                    context.read<LikedPostsCubit>().clearAllLikedPosts();
                  },
                ),
              IconButton(
                  icon: context.watch<ThemeNotifier>().currentThemeEnum ==
                          AppThemes.LIGHT
                      ? Icon(Icons.nightlight_round)
                      : Icon(Icons.wb_sunny),
                  onPressed: () {
                    context.read<ThemeNotifier>().changeTheme();
                  })
            ],
          ),
          body: _buildBody(state, context),
        );
      },
    );
  }

  Widget _buildBody(ProfileState state, BuildContext context) {
    switch (state.status) {
      case ProfileStatus.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      default:
        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<ProfileBloc>()
                .add(ProfileLoadUser(userId: state.user.id));
            
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 0),
                      child: Row(
                        children: [
                          UserProfileImage(
                            radius: 40.0,
                            profileImageUrl: state.user.profileImageUrl,
                          ),
                          ProfileStats(
                            isCurrentUser: state.isCurrentUser,
                            isFollowing: state.isFollowing,
                            posts: state.posts.length,
                            followers: state.user.followers,
                            following: state.user.following,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: ProfileInfo(
                        username: state.user.username,
                        bio: state.user.bio,
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.amber.shade700,
                  unselectedLabelColor: Colors.black45,
                  indicatorColor: Colors.pink.shade900,
                  tabs: [
                    Tab(icon: Icon(Icons.grid_on, size: 28.0)),
                    Tab(icon: Icon(Icons.list, size: 28.0)),
                  ],
                  indicatorWeight: 3.0,
                  onTap: (i) => context
                      .read<ProfileBloc>()
                      .add(ProfileToggleGridView(isGridView: i == 0)),
                ),
              ),
              state.isGridView
                  ? SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final post = state.posts[index];
                          return GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(
                              CommentsScreen.routeName,
                              arguments: CommentsScreenArgs(post: post!),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: post!.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        childCount: state.posts.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 3.0,
                      ))
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final post = state.posts[index];
                          final likedPostsState =
                              context.watch<LikedPostsCubit>().state;
                          final isLiked =
                              likedPostsState.likedPostIds.contains(post!.id);
                          return PostView(
                            post: post,
                            isLiked: isLiked,
                            onlike: () {
                              if (isLiked) {
                                context
                                    .read<LikedPostsCubit>()
                                    .unlikePost(post: post);
                              } else {
                                context
                                    .read<LikedPostsCubit>()
                                    .likePost(post: post);
                              }
                            },
                          );
                        },
                        childCount: state.posts.length,
                      ),
                    ),
            ],
          ),
        );
    }
  }
}
