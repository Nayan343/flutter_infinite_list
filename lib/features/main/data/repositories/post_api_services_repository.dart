import 'package:dio/dio.dart';

abstract class PostApiServicesRepository{
  Future<Response> fetchPost([int startIndex]);
}