import '../../errors/base_error.dart';

class Result<Error extends BaseError, Data> {
  Data? data;
  Error? error;

  Result({this.data, this.error}) : assert(data != null || error != null);

  bool get hasDataOnly => data != null && error == null;

  bool get hasErrorOnly => data == null && error != null;

  bool get hasDataAndError => data != null && error != null;
}

class TwoModelsResult<FailureData, Data> {
  final Data dataSucceed;
  final FailureData dataFailure;

  TwoModelsResult({required this.dataSucceed, required this.dataFailure})
      : assert(dataSucceed != null || dataFailure != null);

  bool get hasSuccessOnly => dataSucceed != null && dataFailure == null;

  bool get hasFailureOnly => dataSucceed == null && dataFailure != null;

  bool get hasSuccessAndFailure => dataSucceed != null && dataFailure != null;
}
