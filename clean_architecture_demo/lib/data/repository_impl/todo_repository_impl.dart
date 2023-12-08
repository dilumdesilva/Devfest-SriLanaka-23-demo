import 'package:clean_architecture_demo/data/data_source/todo_data_source.dart';
import 'package:clean_architecture_demo/data/mapper.dart';
import 'package:clean_architecture_demo/data/network/failure.dart';
import 'package:clean_architecture_demo/data/network/network_info.dart';
import 'package:clean_architecture_demo/data/response/todo_model.dart';
import 'package:clean_architecture_demo/domain/entity/todo_entity.dart';
import 'package:clean_architecture_demo/domain/repository/todo_repository.dart';
import 'package:either_dart/either.dart';

class TodoRepositoryImpl implements TodoRepository {
  final NetworkInfo _networkInfo;
  final TodoDataSource _todoDataSource;

  TodoRepositoryImpl(this._networkInfo, this._todoDataSource);

  @override
  Future<Either<Failure, bool>> deleteTodo(TodoEntity todoEntity) async {
    if (await _networkInfo.isConnected) {
      final result = await _todoDataSource.deleteTodo(todoEntity);

      if (result) {
        return const Right(true);
      } else {
        return Left(DefaultFailure());
      }
    }
    return Left(DefaultFailure());
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getTodoList() async {
    if (await _networkInfo.isConnected) {
      final List<TodoModel>? result = await _todoDataSource.getTodoList();

      if (result != null) {
        return Right(result.map((e) => e.toDomain()).toList());
      } else {
        return Left(DefaultFailure());
      }
    }
    return Left(DefaultFailure());
  }

  @override
  Future<Either<Failure, bool>> createTodo(TodoEntity todoEntity) async {
    if (await _networkInfo.isConnected) {
      final result = await _todoDataSource.createTodo(todoEntity);

      if (result) {
        return const Right(true);
      } else {
        return Left(DefaultFailure());
      }
    }
    return Left(DefaultFailure());
  }

  @override
  Future<Either<Failure, bool>> updateTodo(TodoEntity todoEntity) async {
    if (await _networkInfo.isConnected) {
      final result = await _todoDataSource.updateTodo(todoEntity);

      if (result) {
        return const Right(true);
      } else {
        return Left(DefaultFailure());
      }
    }
    return Left(DefaultFailure());
  }

  @override
  Future<Either<Failure, bool>> pinTodo(String id, bool isPinned) async {
    if (await _networkInfo.isConnected) {
      final result = await _todoDataSource.pinTodo(id, isPinned);

      if (result) {
        return const Right(true);
      } else {
        return Left(DefaultFailure());
      }
    }
    return Left(DefaultFailure());
  }
}
