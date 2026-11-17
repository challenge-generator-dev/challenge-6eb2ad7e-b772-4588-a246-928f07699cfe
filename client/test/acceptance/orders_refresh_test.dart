import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../lib/domain/repositories/orders_repository.dart';
import '../../lib/presentation/blocs/orders_bloc.dart';
import '../../lib/presentation/screens/orders_screen.dart';

class MockOrdersRepository extends Mock implements OrdersRepository {}

class FakeOrdersEvent extends Fake implements OrdersEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeOrdersEvent());
  });

  group('Acceptance: Pull-to-refresh en OrdersScreen', () {
    late MockOrdersRepository mockRepository;
    late OrdersBloc ordersBloc;

    final initialOrders = [
      OrderDto(
        id: 'order-1',
        status: 'pending',
        items: [
          OrderItemDto(productId: 'prod-1', quantity: 1, price: 10.0),
        ],
      ),
    ];

    final refreshedOrders = [
      OrderDto(
        id: 'order-1',
        status: 'completed',
        items: [
          OrderItemDto(productId: 'prod-1', quantity: 1, price: 10.0),
        ],
      ),
      OrderDto(
        id: 'order-2',
        status: 'shipped',
        items: [
          OrderItemDto(productId: 'prod-2', quantity: 2, price: 20.0),
        ],
      ),
    ];

    setUp(() {
      mockRepository = MockOrdersRepository();
      when(() => mockRepository.getOrders())
          .thenAnswer((_) async => initialOrders);
      when(() => mockRepository.refreshOrders())
          .thenAnswer((_) async => refreshedOrders);
      ordersBloc = OrdersBloc(ordersRepository: mockRepository);
    });

    tearDown(() {
      ordersBloc.close();
    });

    testWidgets(
      'pull-to-refresh actualiza la lista de pedidos correctamente',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<OrdersBloc>.value(
              value: ordersBloc,
              child: const OrdersScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('order-1'), findsOneWidget);
        expect(find.text('pending'), findsOneWidget);

        await tester.pump();

        ordersBloc.add(const RefreshOrdersEvent());
        
        await tester.pumpAndSettle();

        expect(find.text('completed'), findsOneWidget);
        expect(find.text('order-2'), findsOneWidget);
        expect(find.text('shipped'), findsOneWidget);

        verify(() => mockRepository.refreshOrders()).called(1);
      },
    );

    testWidgets(
      'el estado se maneja con Bloc y no con GetX',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<OrdersBloc>.value(
              value: ordersBloc,
              child: const OrdersScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(ordersBloc.state, isA<OrdersLoaded>());

        final state = ordersBloc.state as OrdersLoaded;
        expect(state.orders, equals(initialOrders));
      },
    );

    testWidgets(
      'RefreshIndicator está presente en la UI',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<OrdersBloc>.value(
              value: ordersBloc,
              child: const OrdersScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(RefreshIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'mostrar indicador de carga durante el refresh',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<OrdersBloc>.value(
              value: ordersBloc,
              child: const OrdersScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        ordersBloc.add(const RefreshOrdersEvent());
        await tester.pump();

        expect(ordersBloc.state, const OrdersLoading());

        await tester.pumpAndSettle();

        expect(ordersBloc.state, isA<OrdersLoaded>());
      },
    );
  });
}