import 'package:flutter_infinite_list/features/main/domain/entities/post_entity.dart';

class PostModel extends PostEntity{
  PostModel.fromJson(dynamic json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
}