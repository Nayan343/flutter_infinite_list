import 'package:dio/dio.dart';
import 'package:flutter_infinite_list/core/resources/network/dio_client.dart';
import 'package:flutter_infinite_list/core/resources/network/endpoints.dart';
import 'package:flutter_infinite_list/features/main/data/repositories/post_api_services_repository.dart';

class PostApiServices implements PostApiServicesRepository{
  final DioClient _dioClient;
  const PostApiServices(this._dioClient);
  @override
  Future<Response> fetchPost([int? startIndex]) {
   return _dioClient.get(Endpoints.posts, queryParameters: {
     "_start":startIndex,
     "_limit":10,
   });
  }
}