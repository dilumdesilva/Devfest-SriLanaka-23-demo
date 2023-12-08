import 'dart:async';

import 'package:clean_architecture_demo/data/data_source/todo_data_source.dart';
import 'package:clean_architecture_demo/data/response/todo_model.dart';
import 'package:clean_architecture_demo/domain/entity/todo_entity.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDataSource implements TodoDataSource {
  @override
  Future<bool> createTodo(TodoEntity todoEntity) async {
    String key =
        FirebaseDatabase.instance.ref(FirebasePath.todoNode).push().key!;
    todoEntity.id = key;
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('${FirebasePath.todoNode}/$key');
    bool result = false;
    await ref.set(todoEntity.toJson()).then((_) {
      result = true;
    }).catchError((error) {
      result = false;
    });

    return result;
  }

  @override
  Future<bool> deleteTodo(TodoEntity todoEntity) async {
    String todoID = todoEntity.id;
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('${FirebasePath.todoNode}/$todoID');
    bool result = false;
    await ref.remove().then((_) {
      result = true;
    }).catchError((error) {
      result = false;
    });

    return result;
  }

  @override
  Future<List<TodoModel>?> getTodoList() async {
    final StreamController<List<TodoModel>> controller = StreamController();
    final ref = FirebaseDatabase.instance.ref(FirebasePath.todoNode);

    ref.get().then((value) {
      if (value.exists) {
        return controller.add(value.children
            .map((e) => TodoModel.fromJson(
                  Map<String, dynamic>.from(e.value as Map<Object?, Object?>),
                ))
            .toList());
      } else {
        controller.add(List.empty());
      }
    });
    return controller.stream.first;
  }

  @override
  Future<bool> updateTodo(TodoEntity todoEntity) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }

  @override
  Future<bool> pinTodo(String todoID, bool isPinned) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref('${FirebasePath.todoNode}/$todoID${FirebasePath.isPinnedNode}');

    bool result = false;
    await ref.set(isPinned).then((_) {
      result = true;
    }).catchError((error) {
      result = false;
    });

    return result;
  }
}

/// Add firebase node paths here
class FirebasePath {
  static const String todoNode = '/todo/cards';
  static const String isPinnedNode = '/isPinned';
}
