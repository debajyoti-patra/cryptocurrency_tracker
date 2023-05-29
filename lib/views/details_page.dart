import 'package:cryptocurrency_tracker/models/cryptocurrency.dart';
import 'package:cryptocurrency_tracker/widgets/tile_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/chartModel.dart';
import '../provider/chart_provider.dart';
import '../provider/market_provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    ChartProvider().getChatData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _marketProvider = Provider.of<MarketProvider>(context);
    final chartProvider = Provider.of<ChartProvider>(context);
    Cryptocurrency currCrypto = _marketProvider.fetchCryptoById(widget.id);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: RefreshIndicator(
          onRefresh: () async {
            await _marketProvider.fetchData();
          },
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(currCrypto.image!),
                ),
                title: Text(
                  '${currCrypto.name!} (${currCrypto.symbol!.toUpperCase()})',
                  style: const TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  '₹ ${currCrypto.currentPrice!.toStringAsFixed(4)}',
                  style: const TextStyle(fontSize: 25, color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Price Change (24h)',
                    style: TextStyle(fontSize: 23),
                  ),
                  Builder(
                    builder: (context) {
                      double priceChange = currCrypto.priceChange24!;
                      double priceChangePercentage =
                          currCrypto.priceChangePercentage24!;
                      if (priceChange < 0) {
                        return Text(
                          '${priceChangePercentage.toStringAsFixed(2)}%(${priceChange.toStringAsFixed(4)})',
                          style:
                              const TextStyle(color: Colors.red, fontSize: 22),
                        );
                      } else {
                        return Text(
                          '+${priceChangePercentage.toStringAsFixed(2)}%(+${priceChange.toStringAsFixed(4)})',
                          style: const TextStyle(
                              color: Colors.green, fontSize: 22),
                        );
                      }
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TileDetail(
                    header: 'Market Cap',
                    detail: currCrypto.marketCap!.toStringAsFixed(4),
                    alignment: CrossAxisAlignment.start,
                  ),
                  TileDetail(
                    header: 'Market Cap Rank',
                    detail: '#${currCrypto.rank!}',
                    alignment: CrossAxisAlignment.end,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TileDetail(
                    header: 'Low 24h',
                    detail: currCrypto.low24!.toStringAsFixed(4),
                    alignment: CrossAxisAlignment.start,
                  ),
                  TileDetail(
                    header: 'High 24h',
                    detail: currCrypto.high24!.toStringAsFixed(4),
                    alignment: CrossAxisAlignment.end,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TileDetail(
                    header: 'Circulating Supply',
                    detail: currCrypto.circulatingSupply!.toString(),
                    alignment: CrossAxisAlignment.start,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TileDetail(
                    header: 'All Time Low',
                    detail: currCrypto.atl!.toStringAsFixed(4),
                    alignment: CrossAxisAlignment.start,
                  ),
                  TileDetail(
                    header: 'All Time High',
                    detail: currCrypto.ath!.toStringAsFixed(4),
                    alignment: CrossAxisAlignment.end,
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Center(
                child: ElevatedButton(
                  child: const Text('Refresh Price Chart'),
                  onPressed: () {
                    chartProvider.getChatData(widget.id);
                  },
                ),
              ),
              const SizedBox(height: 10,),
              (chartProvider.chartData.isNotEmpty)
                  ? SfCartesianChart(
                      primaryXAxis: DateTimeAxis(),
                      series: <ChartSeries>[
                        // Renders line chart
                        LineSeries<ChartData, DateTime>(
                            dataSource: chartProvider.chartData,
                            xValueMapper: (ChartData sales, _) =>
                                sales.dateTime,
                            yValueMapper: (ChartData sales, _) => sales.price)
                      ],
                    )
                  :Container()
            ],
          ),
        ),
      ),
    );
  }
}
