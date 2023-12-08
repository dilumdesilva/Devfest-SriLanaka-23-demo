import 'package:clean_architecture_demo/data/response/todo_model.dart';
import 'package:clean_architecture_demo/domain/entity/todo_entity.dart';

extension TodoModelMapper on TodoModel {
  TodoEntity toDomain() {
    return TodoEntity(id, title, description, isPinned ?? false);
  }
}
