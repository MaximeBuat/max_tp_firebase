import 'package:bloc/bloc.dart';
import 'package:max_tp_firebase/models/post.dart';
import 'package:max_tp_firebase/models/post_repository.dart';
import 'package:meta/meta.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final PostRepository postRepository;

  AddPostBloc(this.postRepository) : super(const AddPostState()) {
    on<AddPost>(_onAddPost);
    on<UpdatePost>(_onUpdatePost);
  }

  void _onAddPost(AddPost event, Emitter<AddPostState> emit) async {
    emit(state.copyWith(status: AddPostStatus.loading));
    try {
      await postRepository.addPost(event.post);
      emit(state.copyWith(status: AddPostStatus.success));
      emit(state.copyWith(status: AddPostStatus.initial));
    } catch (e) {
      emit(state.copyWith(
          status: AddPostStatus.error, error: 'Failed to add post'));
    }
  }

  void _onUpdatePost(UpdatePost event, Emitter<AddPostState> emit) async {
    emit(state.copyWith(status: AddPostStatus.loading));
    try {
      await postRepository.updatePost(event.post);
      emit(state.copyWith(status: AddPostStatus.success));
      emit(state.copyWith(status: AddPostStatus.initial));
    } catch (e) {
      emit(state.copyWith(
          status: AddPostStatus.error, error: 'Failed to update post'));
    }
  }
}
