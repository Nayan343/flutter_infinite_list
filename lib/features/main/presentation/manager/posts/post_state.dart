part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

final class PostState extends Equatable {
  const PostState({this.postStatus, this.posts, this.hasReachedMax});

  final PostStatus? postStatus;
  final List<PostEntity>? posts;
  final bool? hasReachedMax;

  PostState copyWith({
    PostStatus? postStatus,
    List<PostEntity>? posts,
    bool? hasReachedMax,
  }) {
    return PostState(
      postStatus: postStatus ?? this.postStatus,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { postStatus: $postStatus, hasReachedMax: $hasReachedMax, posts: ${posts?.length} }''';
  }

  @override
  List<Object> get props =>
      [postStatus ?? PostStatus.initial, posts ?? [], hasReachedMax ?? false];
}
