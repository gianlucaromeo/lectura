import 'package:lectura/core/enums.dart';

class UserBookDto {
  const UserBookDto(
    this.bookId,
    this.status,
  );

  UserBookDto.fromJson(Map<String, dynamic> json)
      : bookId = json["bookId"],
        status = bookStatusFromName(json["status"]);

  final String bookId;
  final BookStatus status;
}
