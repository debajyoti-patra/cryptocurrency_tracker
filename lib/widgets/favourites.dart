import 'package:cryptocurrency_tracker/models/cryptocurrency.dart';
import 'package:cryptocurrency_tracker/provider/market_provider.dart';
import 'package:cryptocurrency_tracker/widgets/cryptoListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    final marketProvider = Provider.of<MarketProvider>(context);
    List<Cryptocurrency> favourites = marketProvider.markets
        .where((element) => element.isFavourite == true)
        .toList();
    if (favourites.isNotEmpty) {
      return ListView.builder(
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          Cryptocurrency currentCrypto = favourites[index];
          return CryptoListTile(currCrypto: currentCrypto);
        },
      );
    } else {
      return const Center(
        child: Text(
          'No Favourites yet',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      );
    }
  }
}
