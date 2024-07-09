part of 'post_bloc.dart';

enum PostStatus {
  initial,
  loading,
  success,
  error,
  empty,
}

class PostState {
  final PostStatus status;
  final List<Post> posts;
  final String? error;

  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.error,
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    String? error,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
