import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String? username;

  @HiveField(2)
  final String email;

  const UserModel({
    required this.id,
    required this.username,
    required this.email,
  });

  static UserModel fromJson(dynamic source) {
    return UserModel(
      id: source['id'],
      username: source['username'],
      email: source['phone'],
    );
  }
}
