import 'package:clean_architecture_demo/data/network/failure.dart';
import 'package:clean_architecture_demo/domain/entity/todo_entity.dart';
import 'package:either_dart/either.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoEntity>>> getTodoList();

  Future<Either<Failure, bool>> createTodo(TodoEntity todo);

  Future<Either<Failure, bool>> deleteTodo(TodoEntity todoModel);

  Future<Either<Failure, bool>> updateTodo(TodoEntity todoModel);

  Future<Either<Failure, bool>> pinTodo(String id, bool isPinned);
}
