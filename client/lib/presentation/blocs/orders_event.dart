part of 'orders_bloc.dart';

/// Clase base abstracta para los eventos del OrdersBloc.
abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

/// Evento para cargar la lista de pedidos.
class LoadOrders extends OrdersEvent {
  const LoadOrders();
}

/// Evento para refrescar la lista de pedidos (pull-to-refresh).
/// Este evento es el que se dispara cuando el usuario hace pull-to-refresh
/// en el listado de pedidos.
class RefreshOrdersEvent extends OrdersEvent {
  const RefreshOrdersEvent();
}