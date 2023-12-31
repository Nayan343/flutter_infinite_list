import 'package:equatable/equatable.dart';

class PostEntity extends Equatable{
  PostEntity({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  num? userId;
  num? id;
  String? title;
  String? body;

  PostEntity copyWith({
    num? userId,
    num? id,
    String? title,
    String? body,
  }) =>
      PostEntity(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['id'] = id;
    map['title'] = title;
    map['body'] = body;
    return map;
  }

  @override
  List<Object?> get props => [userId, id, title, body];
}
