import 'package:flutter_infinite_list/core/resources/data_state/data_state.dart';
import 'package:flutter_infinite_list/features/main/domain/entities/post_entity.dart';

abstract class PostRepository{
  Future<DataState<List<PostEntity>>> fetchPost([int startIndex]);
}