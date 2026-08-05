import '../errors/failure.dart';

abstract class ApiResult<T> {
  const ApiResult();

  R fold<R>(
    R Function(T data) onSuccess,
    R Function(Failure failure) onFailure,
  );
}

class SuccessResult<T> extends ApiResult<T> {
  final T data;

  const SuccessResult(this.data);

  @override
  R fold<R>(
    R Function(T data) onSuccess,
    R Function(Failure failure) onFailure,
  ) {
    return onSuccess(data);
  }
}

class FailureResult<T> extends ApiResult<T> {
  final Failure failure;

  const FailureResult(this.failure);

  @override
  R fold<R>(
    R Function(T data) onSuccess,
    R Function(Failure failure) onFailure,
  ) {
    return onFailure(failure);
  }
}
