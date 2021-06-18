import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/components/dialog/error_dialog.dart';
import '../../core/components/views/post_view.dart';
import '../../cubits/cubits.dart';
import 'bloc/feed_bloc.dart';

class FeedScreen extends StatefulWidget {
  static const String routeName = '/feed';

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange &&
            context.read<FeedBloc>().state.status != FeedStatus.paginating) {
          context.read<FeedBloc>().add(FeedPaginatePosts());
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state.status == FeedStatus.error) {
          showDialog(
              context: context,
              builder: (context) =>
                  ErrorDialog(content: state.failure.message));
        } else if (state.status == FeedStatus.paginating) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Loading more posts...'),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.blue.shade300,
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Instagram'),
            actions: [
              if (state.posts.isEmpty && state.status == FeedStatus.loaded)
                IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.black,
                  ),
                  onPressed: () =>
                      context.read<FeedBloc>().add(FeedFetchPosts()),
                )
            ],
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(FeedState state) {
    switch (state.status) {
      case FeedStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
        break;
      default:
        return RefreshIndicator(
          onRefresh: () async {
            context.read<FeedBloc>().add(FeedFetchPosts());
            return true;
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.posts.length,
            itemBuilder: (BuildContext context, int index) {
              final post = state.posts[index];
              final likedPostsState = context.watch<LikedPostsCubit>().state;
              final isLiked = likedPostsState.likedPostIds.contains(post.id);
              final recentlyliked =
                  likedPostsState.recentlyLikedPostIds.contains(post.id);
              return PostView(
                post: post,
                isLiked: isLiked,
                recentlyLiked: recentlyliked,
                onlike: () {
                  if (isLiked) {
                    context.read<LikedPostsCubit>().unlikePost(post: post);
                  } else {
                    context.read<LikedPostsCubit>().likePost(post: post);
                  }
                },
              );
            },
          ),
        );
    }
  }
}
