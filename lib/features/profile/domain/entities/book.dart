class Book {
  const Book({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.authors,
    required this.description,
    this.averageRating,
    this.ratingCount,
  });

  final String id;
  final String imagePath;
  final String title;
  final List<String> authors;
  final String description;

  final double? averageRating;
  final int? ratingCount;
}
