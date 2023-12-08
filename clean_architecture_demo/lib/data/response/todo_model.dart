class TodoModel {
  final String id;
  final String title;
  final String description;
  final bool? isPinned;

  TodoModel(this.id, this.title, this.description, {this.isPinned = false});

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        json['id'] as String,
        json['title'] as String,
        json['description'] as String,
        isPinned: json['isPinned'] as bool?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'description': description,
        'isPinned': isPinned,
      };

  @override
  String toString() {
    return 'TodoModel{id: $id, title: $title, description: $description, isPinned: $isPinned}';
  }
}
