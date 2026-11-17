import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/repositories/orders_repository_impl.dart';
import 'presentation/blocs/orders_bloc.dart';
import 'presentation/screens/orders_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orders App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => OrdersBloc(
          ordersRepository: OrdersRepositoryImpl(
            httpClient: http.Client(),
          ),
        )..add(const LoadOrders()),
        child: const OrdersScreen(),
      ),
    );
  }
}