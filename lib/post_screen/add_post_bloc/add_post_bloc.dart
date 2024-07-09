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
  }

  void _onAddPost(AddPost event, Emitter<AddPostState> emit) async {
    emit(state.copyWith(status: AddPostStatus.loading));
    try {
      await postRepository.addPost(event.post);
      emit(state.copyWith(status: AddPostStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: AddPostStatus.error, error: 'Failed to add post'));
    }
  }
}
