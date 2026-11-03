
import 'package:flutter/material.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

class BasketView extends StatelessWidget {
  final BasketRepository basketRepository;

  const BasketView({
    super.key,
    required this.basketRepository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Basket'),
      ),
      body: const Center(
        child: Text('My Basket'),
      ),
    );
  }
}
