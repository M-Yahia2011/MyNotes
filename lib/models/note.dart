import 'dart:convert';

class Note {
  Note(
      {required this.id,
      required this.title,
      required this.note,
      required this.date,
      required this.favorite});

  String? id;
  String? title;
  String? note;
  String? date;
  int favorite;

  factory Note.fromRawJson(String str) => Note.fromMap(json.decode(str));

  String toRawMap() => json.encode(toMap());

  factory Note.fromMap(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        note: json["note"],
        date: json["date"],
        favorite: json["favorite"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "note": note,
        "date": date,
        "favorite": favorite
      };

  @override
  String toString() {
    return [
      id,
      title,
      note,
      date,
    ].toString();
  }
}
