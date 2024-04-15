class Book {
  const Book({
    required this.title,
    required this.authors,
    required this.description,
  });

  final String? title;
  final List<String>? authors;
  final String? description;
}
