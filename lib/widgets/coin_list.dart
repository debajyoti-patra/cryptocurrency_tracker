import 'package:cryptocurrency_tracker/widgets/cryptoListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cryptocurrency.dart';
import '../provider/market_provider.dart';

class CoinList extends StatefulWidget {
  const CoinList({Key? key}) : super(key: key);

  @override
  State<CoinList> createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> {
  @override
  Widget build(BuildContext context) {
    final marketProvider = Provider.of<MarketProvider>(context);
    return marketProvider.isLoading == true
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () async {
              await marketProvider.fetchData();
            },
            child: marketProvider.markets.isEmpty
                ? const Text('Data Not Found')
                : ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: marketProvider.markets.length,
                    itemBuilder: (context, index) {
                      Cryptocurrency currCrypto =
                          marketProvider.markets[index];
                      return CryptoListTile(currCrypto: currCrypto);
                    },
                  ),
          );
  }
}
