import 'package:lectura/core/convertible_dto.dart';
import 'package:lectura/features/auth/domain/entities/user.dart';

class UserDto implements ConvertibleDto<User> {
  const UserDto({
    this.id,
    this.email,
  });

  final String? id;
  final String? email;

  UserDto.empty() : this();

  UserDto.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        email = map['email'];

  @override
  User toEntity() {
    return User(
      id: id,
      email: email,
    );
  }
}
