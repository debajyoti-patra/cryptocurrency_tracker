
import 'chartModel.dart';

class Cryptocurrency {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  int? rank;
  double? high24;
  double? low24;
  double? priceChange24;
  double? priceChangePercentage24;
  double? circulatingSupply;
  double? ath;
  double? atl;
  bool isFavourite = false;
  List<ChartData>chartData = [];
  Cryptocurrency(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.image,
      required this.currentPrice,
      required this.marketCap,
      required this.rank,
      required this.high24,
      required this.low24,
      required this.priceChange24,
      required this.priceChangePercentage24,
      required this.circulatingSupply,
      required this.ath,
      required this.atl});
  factory Cryptocurrency.fromJSON(Map<String, dynamic> map) {
    return Cryptocurrency(
        id: map['id'],
        symbol: map['symbol'],
        name: map['name'],
        image: map['image'],
        currentPrice: map['current_price'].toDouble(),
        marketCap: map['market_cap'].toDouble(),
        rank: map['market_cap_rank'],
        high24: map['high_24h'].toDouble(),
        low24: map['low_24h'].toDouble(),
        priceChange24: map['price_change_24h'].toDouble(),
        priceChangePercentage24: map['price_change_percentage_24h'].toDouble(),
        circulatingSupply: map['circulating_supply'].toDouble(),
        ath: map['ath'].toDouble(),
        atl: map['atl'].toDouble());
  }
}
