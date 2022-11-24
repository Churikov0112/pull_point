part of '../models.dart';

class ShopItemModel {
  final int id;
  final double costRub;
  final int sum;

  const ShopItemModel({
    required this.id,
    required this.sum,
    required this.costRub,
  });

  static ShopItemModel fromJson(dynamic source) {
    return ShopItemModel(
      id: source['id'],
      sum: source['sum'],
      costRub: source['costRub'],
    );
  }
}
