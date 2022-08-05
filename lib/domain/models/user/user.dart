part of '../models.dart';

class UserModel {
  final int id;
  final String name;
  final int? bankCardId;
  final String? avatar;

  const UserModel({
    required this.id,
    required this.name,
    this.bankCardId,
    this.avatar,
  });

  static UserModel fromJson(dynamic source) {
    return UserModel(
      id: source['id'],
      name: source['name'],
      avatar: source['avatar'],
    );
  }
}
