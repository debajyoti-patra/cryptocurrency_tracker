import 'package:cryptocurrency_tracker/provider/market_provider.dart';
import 'package:cryptocurrency_tracker/widgets/coin_list.dart';
import 'package:cryptocurrency_tracker/widgets/favourites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    MarketProvider();
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome Back',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Crypto Today',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                IconButton(
                  onPressed: () {
                    themeProvider.changeTheme();
                  },
                  icon: themeProvider.themeMode == ThemeMode.light
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TabBar(
              controller: controller,
              tabs: [
                Tab(
                  child: Text(
                    'Markets',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Tab(
                  child: Text(
                    'Favorites',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: TabBarView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                controller: controller,
                children: const [
                  CoinList(),
                  Favourites(),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
