import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  String id;
  final String title;
  final String description;
  bool isPinned;

  TodoEntity(this.id, this.title, this.description, this.isPinned);

  factory TodoEntity.fromJson(Map<String, dynamic> json) => TodoEntity(
        json['id'] as String,
        json['title'] as String,
        json['description'] as String,
        json['isPinned'] as bool,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'description': description,
        'isPinned': isPinned,
      };

  @override
  String toString() {
    return 'TodoEntity{id: $id, title: $title, description: $description, isPinned: $isPinned}';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, description, isPinned];
}
