class Note {
  int? id;
  String? title;
  String? text;
  DateTime? creationDate = DateTime.now();
  Note(this.id, this.text, this.title);
}
