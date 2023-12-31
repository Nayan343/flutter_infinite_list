import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

enum AppExceptionType {
  requestCancelled,
  badCertificate,
  unauthorisedRequest,
  connectionError,
  badRequest,
  notFound,
  requestTimeout,
  sendTimeout,
  receiveTimeout,
  conflict,
  internalServerError,
  notImplemented,
  serviceUnavailable,
  socketException,
  formatException,
  unableToProcess,
  defaultError,
  unexpectedError,
}

class AppException extends Equatable implements Exception {
  final String name, message;
  final int? statusCode;
  final AppExceptionType exceptionType;

  AppException._({
    required this.message,
    this.exceptionType = AppExceptionType.unexpectedError,
    int? statusCode,
  })  : statusCode = statusCode ?? 500,
        name = exceptionType.name;

  factory AppException(dynamic error) {
    late AppException serverException;
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            serverException = AppException._(
                exceptionType: AppExceptionType.requestCancelled,
                statusCode: error.response?.statusCode,
                message: 'Request to the server has been canceled');
            break;

          case DioExceptionType.connectionTimeout:
            serverException = AppException._(
                exceptionType: AppExceptionType.requestTimeout,
                statusCode: error.response?.statusCode,
                message: 'Connection timeout');
            break;

          case DioExceptionType.receiveTimeout:
            serverException = AppException._(
                exceptionType: AppExceptionType.receiveTimeout,
                statusCode: error.response?.statusCode,
                message: 'Receive timeout');
            break;

          case DioExceptionType.sendTimeout:
            serverException = AppException._(
                exceptionType: AppExceptionType.sendTimeout,
                statusCode: error.response?.statusCode,
                message: 'Send timeout');
            break;

          case DioExceptionType.connectionError:
            serverException = AppException._(
                exceptionType: AppExceptionType.connectionError,
                message: 'Connection error');
            break;
          case DioExceptionType.badCertificate:
            serverException = AppException._(
                exceptionType: AppExceptionType.badCertificate,
                message: 'Bad certificate');
            break;
          case DioExceptionType.unknown:
            if (error.error
                .toString()
                .contains(AppExceptionType.socketException.name)) {
              serverException = AppException._(
                  statusCode: error.response?.statusCode,
                  message: 'Verify your internet connection');
            } else {
              serverException = AppException._(
                  exceptionType: AppExceptionType.unexpectedError,
                  statusCode: error.response?.statusCode,
                  message: 'Unexpected error');
            }
            break;

          case DioExceptionType.badResponse:
            switch (error.response?.statusCode) {
              case 400:
                serverException = AppException._(
                    exceptionType: AppExceptionType.badRequest,
                    message: 'Bad request.');
                break;
              case 401:
                serverException = AppException._(
                    exceptionType: AppExceptionType.unauthorisedRequest,
                    message: 'Authentication failure');
                break;
              case 403:
                serverException = AppException._(
                    exceptionType: AppExceptionType.unauthorisedRequest,
                    message: 'User is not authorized to access API');
                break;
              case 404:
                serverException = AppException._(
                    exceptionType: AppExceptionType.notFound,
                    message: 'Request resource does not exist');
                break;
              case 405:
                serverException = AppException._(
                    exceptionType: AppExceptionType.unauthorisedRequest,
                    message: 'Operation not allowed');
                break;
              case 415:
                serverException = AppException._(
                    exceptionType: AppExceptionType.notImplemented,
                    message: 'Media type unsupported');
                break;
              case 422:
                serverException = AppException._(
                    exceptionType: AppExceptionType.unableToProcess,
                    message: 'validation data failure');
                break;
              case 429:
                serverException = AppException._(
                    exceptionType: AppExceptionType.conflict,
                    message: 'too much requests');
                break;
              case 500:
                serverException = AppException._(
                    exceptionType: AppExceptionType.internalServerError,
                    message: 'Internal server error');
                break;
              case 503:
                serverException = AppException._(
                    exceptionType: AppExceptionType.serviceUnavailable,
                    message: 'Service unavailable');
                break;
              default:
                serverException = AppException._(
                    exceptionType: AppExceptionType.unexpectedError,
                    message: 'Unexpected error');
            }
            break;
        }
      } else if(error is FormatException){
        serverException = AppException._(
            exceptionType: AppExceptionType.formatException,
            message: error.message);
      }else {
        serverException = AppException._(
            exceptionType: AppExceptionType.unexpectedError,
            message: 'Unexpected error ${error.toString()}');
      }
    } on FormatException catch (e) {
      serverException = AppException._(
          exceptionType: AppExceptionType.formatException,
          message: e.message);
    } on Exception catch (_) {
      serverException = AppException._(
          exceptionType: AppExceptionType.unexpectedError,
          message: 'Unexpected error ${_.toString()}');
    }
    return serverException;
  }

  @override
  List<Object?> get props => [name, message, statusCode, exceptionType];
}
