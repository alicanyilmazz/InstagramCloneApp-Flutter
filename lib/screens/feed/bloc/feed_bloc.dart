import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/blocs/auth/auth_bloc.dart';
import 'package:flutter_sample/cubits/liked_posts/liked_posts_cubit.dart';
import 'package:flutter_sample/models/failure_model.dart';
import 'package:flutter_sample/models/models.dart';
import 'package:flutter_sample/repositories/repositories.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostRepository _postRepository;
  final AuthBloc _authBloc;
  final LikedPostsCubit _likedPostsCubit;

  FeedBloc(
      {@required PostRepository postRepository,
      @required AuthBloc authBloc,
      @required LikedPostsCubit likedPostsCubit})
      : _postRepository = postRepository,
        _authBloc = authBloc,
        _likedPostsCubit = likedPostsCubit,
        super(FeedState.initial());

  @override
  Stream<FeedState> mapEventToState(FeedEvent event) async* {
    if (event is FeedFetchPosts) {
      yield* _mapFeedFetchPostToState();
    } else if (event is FeedPaginatePosts) {
      yield* _mapFeedPaginatePostsToState();
    }
  }

  Stream<FeedState> _mapFeedFetchPostToState() async* {
    yield state.copyWith(posts: [], status: FeedStatus.loading);
    try {
      final posts =
          await _postRepository.getUserFeed(userId: _authBloc.state.user.uid);
      _likedPostsCubit.clearAllLikedPosts();
      final likedPostIds = await _postRepository.getLikedPostIds(
          userId: _authBloc.state.user.uid, posts: posts);
      _likedPostsCubit.updateLikedPosts(postIds: likedPostIds);
      yield state.copyWith(posts: posts, status: FeedStatus.loaded);
    } catch (error) {
      yield state.copyWith(
          status: FeedStatus.error,
          failure: const Failure(message: 'We were unable to load your feed!'));
    }
  }

  Stream<FeedState> _mapFeedPaginatePostsToState() async* {
    yield state.copyWith(status: FeedStatus.paginating);
    try {
      final lastPostId = state.posts.isNotEmpty ? state.posts.last.id : null;

      final posts = await _postRepository.getUserFeed(
        userId: _authBloc.state.user.uid,
        lastPostId: lastPostId,
      );

      final updatedPosts = List<Post>.from(state.posts)..addAll(posts);

      final likedPostIds = await _postRepository.getLikedPostIds(
          userId: _authBloc.state.user.uid, posts: posts);
      _likedPostsCubit.updateLikedPosts(postIds: likedPostIds);

      yield state.copyWith(posts: updatedPosts, status: FeedStatus.loaded);
    } catch (error) {
      yield state.copyWith(
          status: FeedStatus.error,
          failure: const Failure(message: 'We were unable to load your feed!'));
    }
  }
}
