import 'package:clean_architecture_demo/data/data_source/todo_data_source.dart';
import 'package:clean_architecture_demo/data/response/todo_model.dart';
import 'package:clean_architecture_demo/domain/entity/todo_entity.dart';

class MockDataSourceImpl implements TodoDataSource {
  @override
  Future<bool> createTodo(TodoEntity todoEntity) async {
    await Future.delayed(const Duration(seconds: _mockDataDuration));
    return true;
  }

  @override
  Future<bool> deleteTodo(TodoEntity todoEntity) async {
    await Future.delayed(const Duration(seconds: _mockDataDuration));
    return true;
  }

  @override
  Future<List<TodoModel>> getTodoList() async {
    await Future.delayed(const Duration(seconds: _mockDataDuration));
    return _mockTodoList;
  }

  @override
  Future<bool> updateTodo(TodoEntity todoEntity) async {
    await Future.delayed(const Duration(seconds: _mockDataDuration));
    return true;
  }

  @override
  Future<bool> pinTodo(String id, bool isPinned) async {
    await Future.delayed(const Duration(seconds: _mockDataDuration));
    return true;
  }
}

const _mockDataDuration = 2;

List<TodoModel> _mockTodoList = [
  TodoModel('1', 'Task 1', 'This is the description of task 1', isPinned: true),
  TodoModel('2', 'Task 2', 'This is the description of task 2'),
  TodoModel('3', 'Task 3', 'This is the description of task 3'),
  TodoModel('4', 'Task 4', 'This is the description of task 4'),
  TodoModel('5', 'Task 5', 'This is the description of task 5', isPinned: true),
  TodoModel('6', 'Task 6', 'This is the description of task 6'),
  TodoModel('7', 'Task 7', 'This is the description of task 7'),
  TodoModel('8', 'Task 8', 'This is the description of task 8'),
];
