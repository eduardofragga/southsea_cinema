
import 'package:flutter/material.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class BasketView extends StatefulWidget {
  final BasketRepository basketRepository;

  const BasketView({
    super.key,
    required this.basketRepository,
  });

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  String _checkoutMessage = '';

  @override
  Widget build(BuildContext context) {
    final tickets = widget.basketRepository.getTickets();

    Widget basketContent;

    // Decide what to display depending on the basket contents.
    if (tickets.isEmpty) {
      String message;

      if (_checkoutMessage.isEmpty) {
        message = 'Your basket is empty';
      } else {
        message = _checkoutMessage;
      }

      basketContent = Center(
        child: Text(message),
      );
    } else {
      basketContent = ListView(
        children: [
          // Display each movie and its ticket quantity.
          for (final entry in tickets.entries)
            ListTile(
              title: Text(entry.key.title),
              subtitle: Text(
                '${entry.value} ticket(s) × ${entry.key.formattedPrice}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '£${(entry.key.ticketPrice * entry.value).toStringAsFixed(2)}',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        widget.basketRepository.removeTickets(entry.key);
                      });
                    },
                  ),
                ],
              ),
            ),

          // Display the total price.
          ListTile(
            title: const Text('Total'),
            trailing: Text(
              '£${widget.basketRepository.getTotal().toStringAsFixed(2)}',
            ),
          ),

          // Checkout button.
          PrimaryButton(
            label: 'Checkout',
            onPressed: () {
              setState(() {
                widget.basketRepository.clearBasket();
                _checkoutMessage = 'Checkout complete!';
              });
            },
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Basket'),
      ),
      body: basketContent,
    );
  }
}
