import 'package:flutter/material.dart';

class FavoriteSentFavoriteRecieved extends StatefulWidget {
  const FavoriteSentFavoriteRecieved({super.key});

  @override
  State<FavoriteSentFavoriteRecieved> createState() =>
      FavoriteSentFavoriteRecievedState();
}

class FavoriteSentFavoriteRecievedState
    extends State<FavoriteSentFavoriteRecieved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Favorite Sent Favorite Recieved',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
