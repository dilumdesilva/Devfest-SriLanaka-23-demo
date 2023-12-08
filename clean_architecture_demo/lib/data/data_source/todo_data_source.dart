import 'package:clean_architecture_demo/data/response/todo_model.dart';
import 'package:clean_architecture_demo/domain/entity/todo_entity.dart';

abstract class TodoDataSource {
  Future<List<TodoModel>?> getTodoList();

  Future<bool> createTodo(TodoEntity todoEntity);

  Future<bool> deleteTodo(TodoEntity todoEntity);

  Future<bool> updateTodo(TodoEntity todoEntity);

  Future<bool> pinTodo(String id, bool isPinned);
}
