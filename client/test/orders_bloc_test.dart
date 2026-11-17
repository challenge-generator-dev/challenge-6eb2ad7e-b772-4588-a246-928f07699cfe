import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:reto/domain/repositories/orders_repository.dart';
import 'package:reto/presentation/blocs/orders_bloc.dart';

class MockOrdersRepository extends Mock implements OrdersRepository {}

class FakeOrdersEvent extends Fake implements OrdersEvent {}

void main() {
  late MockOrdersRepository mockRepository;
  late OrdersBloc ordersBloc;

  setUpAll(() {
    registerFallbackValue(FakeOrdersEvent());
  });

  setUp(() {
    mockRepository = MockOrdersRepository();
    ordersBloc = OrdersBloc(ordersRepository: mockRepository);
  });

  tearDown(() {
    ordersBloc.close();
  });

  group('OrdersBloc - Carga de pedidos', () {
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

    test('estado inicial es OrdersInitial', () {
      expect(ordersBloc.state, const OrdersInitial());
    });

    blocTest<OrdersBloc, OrdersState>(
      'emite [OrdersLoading, OrdersLoaded] cuando LoadOrders tiene éxito',
      build: () {
        when(() => mockRepository.getOrders())
            .thenAnswer((_) async => testOrders);
        return OrdersBloc(ordersRepository: mockRepository);
      },
      act: (bloc) => bloc.add(const LoadOrders()),
      expect: () => [
        const OrdersLoading(),
        OrdersLoaded(orders: testOrders),
      ],
      verify: (_) {
        verify(() => mockRepository.getOrders()).called(1);
      },
    );

    blocTest<OrdersBloc, OrdersState>(
      'emite [OrdersLoading, OrdersError] cuando LoadOrders falla',
      build: () {
        when(() => mockRepository.getOrders())
            .thenThrow(OrdersRepositoryException('Error de red'));
        return OrdersBloc(ordersRepository: mockRepository);
      },
      act: (bloc) => bloc.add(const LoadOrders()),
      expect: () => [
        const OrdersLoading(),
        isA<OrdersError>(),
      ],
    );
  });

  group('OrdersBloc - Pull-to-refresh', () {
    final refreshedOrders = [
      OrderDto(
        id: 'order-refreshed',
        status: 'shipped',
        items: [
          OrderItemDto(productId: 'prod-new', quantity: 3, price: 15.0),
        ],
      ),
    ];

    blocTest<OrdersBloc, OrdersState>(
      'emite [OrdersLoading, OrdersLoaded] cuando RefreshOrdersEvent tiene éxito',
      build: () {
        when(() => mockRepository.refreshOrders())
            .thenAnswer((_) async => refreshedOrders);
        return OrdersBloc(ordersRepository: mockRepository);
      },
      act: (bloc) => bloc.add(const RefreshOrdersEvent()),
      expect: () => [
        const OrdersLoading(),
        OrdersLoaded(orders: refreshedOrders),
      ],
      verify: (_) {
        verify(() => mockRepository.refreshOrders()).called(1);
      },
    );

    blocTest<OrdersBloc, OrdersState>(
      'emite [OrdersLoading, OrdersError] cuando RefreshOrdersEvent falla',
      build: () {
        when(() => mockRepository.refreshOrders())
            .thenThrow(OrdersRepositoryException('Timeout'));
        return OrdersBloc(ordersRepository: mockRepository);
      },
      act: (bloc) => bloc.add(const RefreshOrdersEvent()),
      expect: () => [
        const OrdersLoading(),
        isA<OrdersError>(),
      ],
    );

    test('refreshOrders() método público dispara RefreshOrdersEvent', () async {
      when(() => mockRepository.refreshOrders())
          .thenAnswer((_) async => refreshedOrders);
      
      final bloc = OrdersBloc(ordersRepository: mockRepository);
      
      await bloc.refreshOrders();
      
      verify(() => mockRepository.refreshOrders()).called(1);
      await bloc.close();
    });
  });
}