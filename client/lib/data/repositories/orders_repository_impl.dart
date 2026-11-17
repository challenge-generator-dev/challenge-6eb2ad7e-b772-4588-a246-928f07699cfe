import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final http.Client _httpClient;
  final String _baseUrl;

  OrdersRepositoryImpl({
    http.Client? httpClient,
    String? baseUrl,
  })  : _httpClient = httpClient ?? http.Client(),
        _baseUrl = baseUrl ?? 'https://api.example.com/prod';

  @override
  Future<List<OrderDto>> getOrders() async {
    try {
      final uri = Uri.parse('$_baseUrl/orders');
      final response = await _httpClient.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
        return jsonList
            .map((item) => _parseOrderDto(item as Map<String, dynamic>))
            .toList();
      } else {
        throw OrdersRepositoryException(
          'Error al obtener pedidos: código de estado ${response.statusCode}',
        );
      }
    } on OrdersRepositoryException {
      rethrow;
    } catch (e) {
      throw OrdersRepositoryException(
        'Error de red al obtener pedidos',
        e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  OrderDto _parseOrderDto(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>;
    final items = itemsList
        .map((item) => _parseOrderItemDto(item as Map<String, dynamic>))
        .toList();

    return OrderDto(
      id: json['id'] as String,
      status: json['status'] as String,
      items: items,
    );
  }

  OrderItemDto _parseOrderItemDto(Map<String, dynamic> json) {
    return OrderItemDto(
      productId: json['productId'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
    );
  }
}