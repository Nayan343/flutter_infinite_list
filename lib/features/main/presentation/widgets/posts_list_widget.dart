import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/features/main/presentation/manager/posts/post_bloc.dart';
import 'package:flutter_infinite_list/features/main/presentation/widgets/bottom_loader.dart';
import 'package:flutter_infinite_list/features/main/presentation/widgets/post_list_item.dart';

class PostsListWidget extends StatefulWidget {
  const PostsListWidget({super.key});

  @override
  State<PostsListWidget> createState() => _PostsListWidgetState();
}

class _PostsListWidgetState extends State<PostsListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            switch (state.postStatus) {
              case PostStatus.initial:
                return const Center(child: CircularProgressIndicator());
              case PostStatus.failure:
                return const Center(
                  child: Text("Failed to Fetch Post"),
                );
              case PostStatus.success:
                if (state.posts?.isEmpty == true) {
                  return const Center(child: Text('no posts'));
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return index >= state.posts!.length
                        ? const BottomLoader()
                        : PostListItem(
                            postEntity: state.posts?[index],
                          );
                  },
                  itemCount: state.hasReachedMax == true
                      ? state.posts?.length ?? 0
                      : state.posts!.length + 1,
                  controller: _scrollController,
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll * 0.9);
  }
}
