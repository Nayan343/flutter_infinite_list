import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/features/main/domain/entities/post_entity.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, this.postEntity});

  final PostEntity? postEntity;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: Text("${postEntity?.id}",
            style: Theme.of(context).textTheme.bodySmall),
        title: Text("${postEntity?.title}"),
        subtitle: Text("${postEntity?.body}"),
        dense: true,
        isThreeLine: true,
      ),
    );
  }
}
