import 'failure.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/app_strings.dart';

class ErrorHandler implements Exception {
  final Failure failure;

  ErrorHandler(this.failure);

  factory ErrorHandler.handle(dynamic error) {
    if (error is ErrorHandler) {
      return error;
    }
    if (error is Exception) {
      return ErrorHandler(
        ServerFailure(
          message: error.toString(),
        ),
      );
    } else {
      return ErrorHandler(
        UnknownFailure(
          message: AppStrings.unexpectedError.tr(),
        ),
      );
    }
  }
}
