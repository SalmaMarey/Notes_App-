import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormat = DateFormat.yMd().add_jm();

class Note {
  final String id;
  String title;
  String content;
  final DateTime date;
  bool deleted;
  bool isExpanded;

  String get formattedDate {
    return dateFormat.format(date);
  }

  Note(
      {required this.content,
      this.deleted = false,
      this.isExpanded = false,
      required this.title,
      required this.date,
      required String? id})
      : id = id ?? uuid.v4();

  void addNewNote(
    String tilteText,
    String contentText,
    DateTime date,
  ) {}
  void deleteNote(
    String id,
  ) {}
  void editNote(
    String tilteText,
    String contentText,
    DateTime date,
  ) {}
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'id': id,
    };
  }

  factory Note.fromJson(Map<String, dynamic> parsedJson) {
    return Note(
      title: parsedJson['title'] ?? "",
      content: parsedJson['content'] ?? "",
      date: DateTime.parse(parsedJson['date'] ?? ""),
      id: parsedJson['id'] ?? "",
    );
  }
}
