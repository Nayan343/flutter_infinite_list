import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/features/main/presentation/manager/posts/post_bloc.dart';
import 'package:flutter_infinite_list/features/main/presentation/widgets/posts_list_widget.dart';
import 'package:flutter_infinite_list/injection_container.dart';

class PostsPage extends StatelessWidget {
  static const route = "/";
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PostBloc>()..add(PostFetched()),
      child: const PostsListWidget(),
    );
  }
}
