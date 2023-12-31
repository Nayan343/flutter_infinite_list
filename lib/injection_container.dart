import 'package:flutter_infinite_list/core/resources/network/dio_client.dart';
import 'package:flutter_infinite_list/features/main/data/data_sources/post_api_services.dart';
import 'package:flutter_infinite_list/features/main/data/repositories/post_repository_impl.dart';
import 'package:flutter_infinite_list/features/main/domain/repositories/post_repository.dart';
import 'package:flutter_infinite_list/features/main/domain/use_cases/fetch_post_use_case.dart';
import 'package:flutter_infinite_list/features/main/presentation/manager/posts/post_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> injectDependencies() async{
  // Dio Client
  sl.registerSingleton<DioClient>(DioClient());

  // Api Services
  sl.registerSingleton<PostApiServices>(PostApiServices(sl<DioClient>()));

  // Repositories Impl
  sl.registerSingleton<PostRepository>(PostRepositoryImpl(sl<PostApiServices>()));

  // Use Cases
  sl.registerSingleton<FetchPostUseCase>(FetchPostUseCase(sl<PostRepository>()));

  // Bloc
  sl.registerSingleton<PostBloc>(PostBloc());
}