import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  final Movie movie;

  const MovieListing({super.key, required this.movie});

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(widget.movie.title),
                const SizedBox(width: 8),
                Text(widget.movie.ageRating),
              ],
            ),
            Text(widget.movie.synopsis),
            const SizedBox(height: 8),
            Text('Runtime: ${widget.movie.runtime}'),
            
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