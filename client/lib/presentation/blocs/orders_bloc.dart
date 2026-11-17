// TODO(reto): archivo stubbeado; implementa los cuerpos.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/repositories/orders_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

/// BLoC para manejar el estado del listado de pedidos.
/// Implementa el patrón BLoC para gestión de estado en Flutter,
/// siguiendo las convenciones del proyecto (no usar GetX).
class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository _ordersRepository;

  OrdersBloc({required OrdersRepository ordersRepository})
      : _ordersRepository = ordersRepository,
        super(const OrdersInitial()) {
    on<LoadOrders>(_onLoadOrders);
    on<RefreshOrdersEvent>(_onRefreshOrders);
  }

  /// Maneja el evento de carga inicial de pedidos.
  Future<void> _onLoadOrders(
    LoadOrders event,
    Emitter<OrdersState> emit,
  ) async {
    emit(const OrdersLoading());
    try {
      final orders = await _ordersRepository.getOrders();
      emit(OrdersLoaded(orders: orders));
    } on OrdersRepositoryException catch (e) {
      emit(OrdersError(message: e.message));
    } catch (e) {
      emit(OrdersError(message: 'Error al cargar los pedidos: $e'));
    }
  }

  /// Maneja el evento de pull-to-refresh para actualizar la lista de pedidos.
  /// Este método es el símbolo exclusivo de la pieza p4.
  Future<void> _onRefreshOrders(
    RefreshOrdersEvent event,
    Emitter<OrdersState> emit,
  ) async {
    final currentState = state;
    
    // Mantener los datos actuales mientras se refresca
    if (currentState is OrdersLoaded) {
      emit(OrdersRefreshing(orders: currentState.orders));
    } else {
      emit(const OrdersLoading());
    }

    try {
      final orders = await _ordersRepository.refreshOrders();
      emit(OrdersLoaded(orders: orders));
    } on OrdersRepositoryException catch (e) {
      // En caso de error, mantener los datos anteriores si existen
      if (currentState is OrdersLoaded) {
        emit(OrdersError(
          message: e.message,
          orders: currentState.orders,
        ));
      } else {
        emit(OrdersError(message: e.message));
      }
    } catch (e) {
      if (currentState is OrdersLoaded) {
        emit(OrdersError(
          message: 'Error al refrescar los pedidos: $e',
          orders: currentState.orders,
        ));
      } else {
        emit(OrdersError(message: 'Error al refrescar los pedidos: $e'));
      }
    }
  }

  /// Método público para dispara el refresh de pedidos.
  /// Este es el símbolo público que la UI invoca para pull-to-refresh.
  Future<void> refreshOrders() async {
    throw UnimplementedError('TODO(reto): refreshOrders');
  }

  /// Método interno para obtener pedidos.
  /// Este es un símbolo exclusivo de esta pieza.
  Future<void> _fetchOrders() async {
    throw UnimplementedError('TODO(reto): _fetchOrders');
  }
}