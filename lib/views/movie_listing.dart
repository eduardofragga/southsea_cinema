import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int _ticketQuantity = 1;
  String _orderMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: Container(
        child: Column(
          children: [
          Row(
            children: [
        const Text('The Intern'),
        const Text('(12A)'),
            ],
          ),
          const Text('A seventy-year-old Ben Whittaker realises that retirement isn\'t an enjoyable experience. As a result, he decides to work as an intern at an online fashion store managed by an extremely sceptical boss.'),
          const Text('Runtime: 1h 55min'),
            
            DropdownMenu<int>(
        initialSelection: _ticketQuantity,
        dropdownMenuEntries: const [
          DropdownMenuEntry(value: 1, label: '1 ticket'),
          DropdownMenuEntry(value: 2, label: '2 tickets'),
          DropdownMenuEntry(value: 3, label: '3 tickets'),
          DropdownMenuEntry(value: 4, label: '4 tickets'),
          DropdownMenuEntry(value: 5, label: '5 tickets'),
        ],
        onSelected: (value) {
          setState(() {
            _ticketQuantity = value!;
          });
        },
            ),
            ElevatedButton(
        onPressed: () {
          setState(() {
            _orderMessage = 'Added $_ticketQuantity ticket(s) to order.';
          });
        },
        child: const Text('Add to Order'),
            ),
            Text(_orderMessage),
          ],
        ),
      ),
    );
  }
}