
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
    final tickets = basketRepository.getTickets();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Basket'),
      ),
      body: tickets.isEmpty
          ? const Center(
              child: Text('Your basket is empty'),
            )
          : ListView(
              children: [
                for (final entry in tickets.entries)
                  ListTile(
                    title: Text(entry.key.title),
                    subtitle: Text(
                      '${entry.value} ticket(s) × ${entry.key.formattedPrice}',
                    ),
                    trailing: Text(
                      '£${(entry.key.ticketPrice * entry.value).toStringAsFixed(2)}',
                    ),
                  ),
                ListTile(
                  title: const Text('Total'),
                  trailing: Text(
                    '£${basketRepository.getTotal().toStringAsFixed(2)}',
                  ),
                ),
              ],
            ),
    );
  }
}
