import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:reto/domain/repositories/orders_repository.dart';
import 'package:reto/presentation/blocs/orders_bloc.dart';

class MockOrdersRepository extends Mock implements OrdersRepository {}

class FakeOrdersEvent extends Fake implements OrdersEvent {}

void main() {
  late MockOrdersRepository mockOrdersRepository;

  setUpAll(() {
    registerFallbackValue(FakeOrdersEvent());
  });

  setUp(() {
    mockOrdersRepository = MockOrdersRepository();
  });

  group('OrdersBloc - Pull-to-Refresh (f3)', () {
    final testOrders = [
      OrderDto(
        id: 'order-1',
        status: 'pending',
        items: [
          OrderItemDto(productId: 'prod-1', quantity: 2, price: 10.0),
        ],
      ),
      OrderDto(
        id: 'order-2',
        status: 'completed',
        items: [
          OrderItemDto(productId: 'prod-2', quantity: 1, price: 25.0),
        ],
      ),
    ];

    final refreshedOrders = [
      OrderDto(
        id: 'order-1',
        status: 'completed',
        items: [
          OrderItemDto(productId: 'prod-1', quantity: 2, price: 10.0),
        ],
      ),
      OrderDto(
        id: 'order-2',
        status: 'shipped',
        items: [
          OrderItemDto(productId: 'prod-2', quantity: 1, price: 25.0),
        ],
      ),
      OrderDto(
        id: 'order-3',
        status: 'pending',
        items: [
          OrderItemDto(productId: 'prod-3', quantity: 3, price: 15.0),
        ],
      ),
    ];

    blocTest<OrdersBloc, OrdersState>(
      'should_refresh_orders_on_pull_to_refresh',
      build: () {
        when(() => mockOrdersRepository.refreshOrders())
            .thenAnswer((_) async => refreshedOrders);
        return OrdersBloc(ordersRepository: mockOrdersRepository);
      },
      seed: () => OrdersLoaded(orders: testOrders),
      act: (bloc) => bloc.add(const RefreshOrdersEvent()),
      expect: () => [
        isA<OrdersRefreshing>().having(
          (s) => s.orders,
          'orders',
          testOrders,
        ),
        isA<OrdersLoaded>().having(
          (s) => s.orders,
          'orders',
          refreshedOrders,
        ),
      ],
      verify: (_) {
        verify(() => mockOrdersRepository.refreshOrders()).called(1);
      },
    );

    blocTest<OrdersBloc, OrdersState>(
      'should_handle_error_on_refresh_failure',
      build: () {
        when(() => mockOrdersRepository.refreshOrders())
            .thenThrow(OrdersRepositoryException('Error de red'));
        return OrdersBloc(ordersRepository: mockOrdersRepository);
      },
      seed: () => OrdersLoaded(orders: testOrders),
      act: (bloc) => bloc.add(const RefreshOrdersEvent()),
      expect: () => [
        isA<OrdersRefreshing>().having(
          (s) => s.orders,
          'orders',
          testOrders,
        ),
        isA<OrdersError>()
            .having((s) => s.message, 'message', 'Error de red')
            .having((s) => s.orders, 'orders', testOrders),
      ],
      verify: (_) {
        verify(() => mockOrdersRepository.refreshOrders()).called(1);
      },
    );

    blocTest<OrdersBloc, OrdersState>(
      'should_show_loading_when_refresh_fails_without_previous_data',
      build: () {
        when(() => mockOrdersRepository.refreshOrders())
            .thenThrow(OrdersRepositoryException('Timeout'));
        return OrdersBloc(ordersRepository: mockOrdersRepository);
      },
      act: (bloc) => bloc.add(const RefreshOrdersEvent()),
      expect: () => [
        const OrdersLoading(),
        isA<OrdersError>().having(
          (s) => s.message,
          'message',
          'Timeout',
        ),
      ],
    );
  });
}