enum BookStatus {
  unknown,
  read,
  currentlyReading,
  toRead,
}

BookStatus bookStatusFromName(String name) {
  return BookStatus.values.firstWhere(
    (e) => e.name == name,
    orElse: () => BookStatus.unknown,
  );
}
