import 'package:clean_architecture_demo/domain/entity/todo_entity.dart';

extension SortTodoListByPinned on List<TodoEntity> {
  List<TodoEntity> sortByPinned() {
    return [...this]
      ..sort((a, b) => (b.isPinned ? 1 : 0) - (a.isPinned ? 1 : 0));
  }
}
