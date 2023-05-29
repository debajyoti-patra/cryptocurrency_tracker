import 'package:cryptocurrency_tracker/models/cryptocurrency.dart';
import 'package:cryptocurrency_tracker/provider/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../views/details_page.dart';


class CryptoListTile extends StatelessWidget {
  final Cryptocurrency currCrypto;
  const CryptoListTile({Key? key,required this.currCrypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _marketProvider = Provider.of<MarketProvider>(context);
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DetailsPage(id: currCrypto.id!),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(currCrypto.image!)),
      title: Row(
        children: [
          Flexible(
            child: Text(
              currCrypto.name!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          (currCrypto.isFavourite == false) ? GestureDetector(
            onTap: (){
              _marketProvider.addFavourites(currCrypto);
            },
            child: const Icon(
              CupertinoIcons.heart,
              size: 18,
            ),
          ) : GestureDetector(
            onTap: (){
              _marketProvider.removeFavourites(currCrypto);
            },
            child: const Icon(
              CupertinoIcons.heart_fill,
              color: Colors.red,
              size: 18,
            ),
          )
        ],
      ),
      subtitle: Text(currCrypto.symbol!.toUpperCase()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '₹ ${currCrypto.currentPrice!.toStringAsFixed(4)}',
            style: const TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.bold),
          ),
          Builder(
            builder: (context) {
              double priceChange = currCrypto.priceChange24!;
              double priceChangePercentage =
              currCrypto.priceChangePercentage24!;
              if (priceChange < 0) {
                return Text(
                  '${priceChangePercentage.toStringAsFixed(2)}%(${priceChange.toStringAsFixed(4)})',
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return Text(
                  '+${priceChangePercentage.toStringAsFixed(2)}%(+${priceChange.toStringAsFixed(4)})',
                  style: TextStyle(color: Colors.green),
                );
              }
            },
          )
        ],
      ),
    );;
  }
}
