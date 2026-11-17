part of 'orders_bloc.dart';

/// Clase base abstracta para los estados del OrdersBloc.
abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial cuando el BLoC se acaba de crear.
class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

/// Estado mientras se están cargando los pedidos.
class OrdersLoading extends OrdersState {
  const OrdersLoading();
}

/// Estado cuando los pedidos se han cargado correctamente.
class OrdersLoaded extends OrdersState {
  final List<OrderDto> orders;

  const OrdersLoaded({required this.orders});

  @override
  List<Object?> get props => [orders];
}

/// Estado mientras se están refrescando los pedidos (pull-to-refresh en progreso).
class OrdersRefreshing extends OrdersState {
  final List<OrderDto> orders;

  const OrdersRefreshing({required this.orders});

  @override
  List<Object?> get props => [orders];
}

/// Estado cuando ocurre un error al cargar o refrescar los pedidos.
class OrdersError extends OrdersState {
  final String message;
  final List<OrderDto>? orders;

  const OrdersError({
    required this.message,
    this.orders,
  });

  @override
  List<Object?> get props => [message, orders];
}