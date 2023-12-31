import 'package:flutter_infinite_list/core/resources/exception/app_exception.dart';

abstract class DataState<T>{
  T? data;
  AppException? error;
  DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T>{
  DataSuccess(T data) : super(data: data);
}

class DataFailure<T> extends DataState<T>{
  DataFailure(AppException error) : super(error: error);
}