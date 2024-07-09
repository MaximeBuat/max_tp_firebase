part of 'add_post_bloc.dart';

@immutable
abstract class AddPostEvent {}

class AddPost extends AddPostEvent {
  final Post post;

  AddPost(this.post);
}

class UpdatePost extends AddPostEvent {
  final Post post;

  UpdatePost(this.post);
}
