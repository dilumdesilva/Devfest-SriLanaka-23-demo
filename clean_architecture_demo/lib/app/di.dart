import 'package:clean_architecture_demo/data/data_source/firebase_data_source.dart';
import 'package:clean_architecture_demo/data/data_source/todo_data_source.dart';
import 'package:clean_architecture_demo/data/network/network_info.dart';
import 'package:clean_architecture_demo/data/repository_impl/todo_repository_impl.dart';
import 'package:clean_architecture_demo/domain/repository/todo_repository.dart';
import 'package:clean_architecture_demo/domain/usecase/create_todo_usecase.dart';
import 'package:clean_architecture_demo/domain/usecase/delete_todo_usecase.dart';
import 'package:clean_architecture_demo/domain/usecase/get_todos_usecase.dart';
import 'package:clean_architecture_demo/domain/usecase/pin_todo_usecase.dart';
import 'package:clean_architecture_demo/domain/usecase/update_todo_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getItInstance = GetIt.instance;

Future<void> initAppModule() async {
  // network info instance
  getItInstance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // remote data source instance
  // MockDataSourceImpl
  getItInstance
      .registerLazySingleton<TodoDataSource>(() => FirebaseDataSource());

  // repository instance
  getItInstance.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<GetTodosUseCase>(
      () => GetTodosUseCase(getItInstance()));

  getItInstance.registerLazySingleton<CreateTodoUseCase>(
      () => CreateTodoUseCase(getItInstance()));

  getItInstance.registerLazySingleton<DeleteTodoUseCase>(
      () => DeleteTodoUseCase(getItInstance()));

  getItInstance.registerLazySingleton<UpdateTodoUseCase>(
      () => UpdateTodoUseCase(getItInstance()));

  getItInstance.registerLazySingleton<PinTodoUseCase>(
      () => PinTodoUseCase(getItInstance()));
}
