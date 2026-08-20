
enum AddQuestionStatus {
  initial,
  loading,
  success,
  error,
}

class AddQuestionState {
  final AddQuestionStatus status;
  final String? errorMessage;

  const AddQuestionState({
    this.status = AddQuestionStatus.initial,
    this.errorMessage,
  });

  AddQuestionState copyWith({
    AddQuestionStatus? status,
    String? errorMessage,
  }) {
    return AddQuestionState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
