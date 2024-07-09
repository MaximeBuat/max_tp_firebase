part of 'add_post_bloc.dart';

enum AddPostStatus {
  initial,
  loading,
  success,
  error,
}

class AddPostState {
  final AddPostStatus status;
  final String? error;

  const AddPostState({
    this.status = AddPostStatus.initial,
    this.error,
  });

  AddPostState copyWith({
    AddPostStatus? status,
    String? error,
  }) {
    return AddPostState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
