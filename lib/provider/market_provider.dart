import 'dart:async';

import 'package:cryptocurrency_tracker/storage/local_storage.dart';
import 'package:flutter/cupertino.dart';

import '../models/cryptocurrency.dart';
import '../services/api.dart';

class MarketProvider with ChangeNotifier {
  MarketProvider() {
    fetchData();
  }
  bool isLoading = true;
  List<Cryptocurrency> markets = [];
  Future<void> fetchData() async {
    List<dynamic> results = await Api.getMarkets();
    List<String>favourites = await LocalStorage.getFavourites();
    List<Cryptocurrency> temp = [];
    for (var _markets in results) {
      Cryptocurrency currCrypto = Cryptocurrency.fromJSON(_markets);

      if(favourites.contains(currCrypto.id!)){
        currCrypto.isFavourite = true;
      }

      temp.add(currCrypto);
    }

    isLoading = false;
    markets = temp;
    notifyListeners();
  }

  Cryptocurrency fetchCryptoById(String id) {
    Cryptocurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addFavourites(Cryptocurrency crypto)async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavourite = true;
    await LocalStorage.saveFavourites(crypto.id!);
    notifyListeners();
  }

  void removeFavourites(Cryptocurrency crypto)async{
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavourite = false;
    await LocalStorage.unSaveFavourites(crypto.id!);
    notifyListeners();
  }

}
