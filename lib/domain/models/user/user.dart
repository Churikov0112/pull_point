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

  @HiveField(3)
  final bool? isArtist;

  @HiveField(4)
  final String? accessToken;

  const UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.accessToken,
    this.isArtist,
  });

  static UserModel fromJson({
    dynamic user,
    dynamic jwt,
  }) {
    return UserModel(
      id: user['id'],
      username: user['username'],
      email: user['phone'],
      accessToken: jwt,
      isArtist: user['isArtist'],
    );
  }
}
