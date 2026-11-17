import 'package:flutter/foundation.dart';

abstract class OrdersRepository {
  Future<List<OrderDto>> getOrders();
  Future<List<OrderDto>> refreshOrders();
}

@immutable
class OrderDto {
  final String id;
  final String status;
  final List<OrderItemDto> items;

  const OrderDto({
    required this.id,
    required this.status,
    required this.items,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderDto &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          status == other.status &&
          listEquals(items, other.items);

  @override
  int get hashCode => id.hashCode ^ status.hashCode ^ items.hashCode;
}

@immutable
class OrderItemDto {
  final String productId;
  final int quantity;
  final double price;

  const OrderItemDto({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItemDto &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          quantity == other.quantity &&
          price == other.price;

  @override
  int get hashCode =>
      productId.hashCode ^ quantity.hashCode ^ price.hashCode;
}

class OrdersRepositoryException implements Exception {
  final String message;
  final Exception? cause;

  OrdersRepositoryException(this.message, [this.cause]);

  @override
  String toString() => 'OrdersRepositoryException: $message${cause != null ? ' (Causa: $cause)' : ''}';
}