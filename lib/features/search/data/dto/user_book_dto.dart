import 'package:lectura/core/enums.dart';

class UserBookDto {
  const UserBookDto(
    this.bookId,
    this.status,
  );

  final String bookId;
  final BookStatus status;
}
