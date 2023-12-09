import '../constants/utils.dart';

class Todo {
  String id;
  DateTime date = DateTime.now();
  String title;
  String? content;
  late bool isDone;

  Todo({
    required this.id,
    required this.date,
    required this.title,
    this.content,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': Utils.fromDateTimeToJson(date),
        'title': title,
        'content': content,
        'isDone': isDone,
      };

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'],
        date: Utils.toDateTime(json['date'])!,
        title: json['title'],
        content: json['content'],
        isDone: json['isDone'],
      );
}
