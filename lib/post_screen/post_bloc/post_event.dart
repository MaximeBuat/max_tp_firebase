part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class LoadPosts extends PostEvent {}

class AddPost extends PostEvent {
  final Post post;

  AddPost(this.post);
}

class UpdatePost extends PostEvent {
  final Post post;

  UpdatePost(this.post);
}

class PostsUpdated extends PostEvent {
  final List<Post> posts;

  PostsUpdated(this.posts);
}
