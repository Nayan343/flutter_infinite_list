import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/core/resources/data_state/data_state.dart';
import 'package:flutter_infinite_list/core/resources/exception/app_exception.dart';
import 'package:flutter_infinite_list/features/main/domain/entities/post_entity.dart';
import 'package:flutter_infinite_list/features/main/domain/use_cases/fetch_post_use_case.dart';
import 'package:flutter_infinite_list/injection_container.dart';
import 'package:stream_transform/stream_transform.dart';

part 'post_event.dart';

part 'post_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState(postStatus: PostStatus.initial)) {
    on<PostFetched>(_onPostFetched,
        transformer: throttleDroppable(const Duration(milliseconds: 100)));
  }

  Future<void> _onPostFetched(
      PostFetched event, Emitter<PostState> emit) async {
    try {
      if (state.hasReachedMax == true) return;
      if (state.postStatus == PostStatus.initial) {
        final posts = await sl<FetchPostUseCase>()();
        if (posts is DataSuccess) {
          return emit(state.copyWith(
              postStatus: PostStatus.success,
              posts: posts.data,
              hasReachedMax: false));
        } else {
          throw posts.error ?? AppException("");
        }
      }
      final posts =
          await sl<FetchPostUseCase>().call(params: state.posts?.length);
      if (posts is DataSuccess) {
        posts.data?.isEmpty == true
            ? emit(state.copyWith(hasReachedMax: true))
            : emit(state.copyWith(
                postStatus: PostStatus.success,
                posts: List.of(state.posts?.toList() ?? [])
                  ..addAll(posts.data?.toList() ?? []),
                hasReachedMax: false));
      } else {
        throw posts.error ?? AppException("");
      }
    } catch (e) {
      emit(state.copyWith(postStatus: PostStatus.failure));
    }
  }
}
