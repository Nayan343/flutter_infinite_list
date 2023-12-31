import 'package:flutter_infinite_list/core/resources/data_state/data_state.dart';
import 'package:flutter_infinite_list/core/usecases/use_case.dart';
import 'package:flutter_infinite_list/features/main/domain/entities/post_entity.dart';
import 'package:flutter_infinite_list/features/main/domain/repositories/post_repository.dart';

class FetchPostUseCase implements UseCase<DataState<List<PostEntity>>, int>{
  final PostRepository _postRepository;
  const FetchPostUseCase(this._postRepository);

  @override
  Future<DataState<List<PostEntity>>> call({int? params}) async{
    return await _postRepository.fetchPost(params ?? 0);
  }
}