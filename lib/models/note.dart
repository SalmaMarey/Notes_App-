import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormat = DateFormat.yMd().add_jm();

class Note {
  final String id;
  late final String title;
  late final String content;
  final DateTime date;

  String get formattedDate {
    return dateFormat.format(date);
  }

  Note(
      {required this.content,
      required this.title,
      required this.date,
      required String id})
      : id = uuid.v4();

  void addNewNote(
    String tilteText,
    String contentText,
    DateTime date,
  ) {}
  void deleteNote(
    String id,
  ) {}
  void editNote(
    String id,
    String tilteText,
    String contentText,
    DateTime date,
  ) {}
}
