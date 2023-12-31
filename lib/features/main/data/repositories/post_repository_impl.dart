import 'dart:io';

import 'package:flutter_infinite_list/core/resources/data_state/data_state.dart';
import 'package:flutter_infinite_list/core/resources/exception/app_exception.dart';
import 'package:flutter_infinite_list/features/main/data/data_sources/post_api_services.dart';
import 'package:flutter_infinite_list/features/main/data/models/post_model.dart';
import 'package:flutter_infinite_list/features/main/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository{
  final PostApiServices _postApiServices;
  const PostRepositoryImpl(this._postApiServices);
  @override
  Future<DataState<List<PostModel>>> fetchPost([int? startIndex]) async{
    try{
      final response = await _postApiServices.fetchPost(startIndex);
      if(response.statusCode == HttpStatus.ok){
        List<PostModel> postModelList = [];
        for (var item in response.data) {
          postModelList.add(PostModel.fromJson(item));
        }
        return DataSuccess(postModelList);
      }else{
        return DataFailure(AppException(response));
      }
    }catch(e){
      return DataFailure(AppException(e));
    }
  }
}