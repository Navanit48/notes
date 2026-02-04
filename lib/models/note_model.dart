class Note {
  final String id;
  String title; // made mutable
  String body;  // changed to mutable (was final)
  

  Note({
    required this.id,
    required this.title,
    required this.body,
  });
}