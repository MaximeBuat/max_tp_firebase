import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:max_tp_firebase/models/post.dart';
import 'package:max_tp_firebase/models/post_repository.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  StreamSubscription<List<Post>>? _postsSubscription;

  PostBloc(this.postRepository) : super(const PostState()) {
    on<LoadPosts>(_onLoadPosts);
    on<UpdatePost>(_onUpdatePost);
    on<PostsUpdated>(_onPostsUpdated);
  }

  void _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));

    await _postsSubscription?.cancel();
    _postsSubscription = postRepository.getPostsStream().listen((posts) {
        add(PostsUpdated(posts));
    }, onError: (error) {
      emit(state.copyWith(
          status: PostStatus.error, error: 'Failed to load posts'));
    });
  }

  void _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      await postRepository.updatePost(event.post);
      emit(state.copyWith(status: PostStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: PostStatus.error, error: 'Failed to update post'));
    }
  }

  void _onPostsUpdated(PostsUpdated event, Emitter<PostState> emit) {
    if (event.posts.isEmpty) {
      emit(state.copyWith(status: PostStatus.empty));
    } else {
      emit(state.copyWith(status: PostStatus.success, posts: event.posts));
    }

  }

  @override
  Future<void> close() {
    _postsSubscription?.cancel();
    return super.close();
  }
}
