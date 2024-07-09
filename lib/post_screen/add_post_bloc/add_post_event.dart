part of 'add_post_bloc.dart';

@immutable
abstract class AddPostEvent {}

class AddPost extends AddPostEvent {
  final Post post;

  AddPost(this.post);
}