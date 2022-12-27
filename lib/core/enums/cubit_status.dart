enum CubitStatus {
  initial,
  loading,
  success,
  failure;

bool get isSubmissionInitial => this == CubitStatus.initial;
bool get isSubmissionLoading => this == CubitStatus.loading;
bool get isSubmissionSuccess => this == CubitStatus.success;
bool get isSubmissionFailure => this == CubitStatus.failure;
}