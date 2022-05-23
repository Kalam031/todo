class ToDoModel {
  ToDoModel({
    required this.id,
    required this.title,
    required this.description,
  });

  final int? id;
  final String? title;
  final String? description;

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        description: json["description"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title!,
        "description": description!,
      };
}
