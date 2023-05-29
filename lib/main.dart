import 'package:cryptocurrency_tracker/provider/chart_provider.dart';
import 'package:cryptocurrency_tracker/storage/local_storage.dart';
import 'package:cryptocurrency_tracker/provider/market_provider.dart';
import 'package:cryptocurrency_tracker/provider/theme_provider.dart';
import 'package:cryptocurrency_tracker/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String theme = await LocalStorage.getTheme() ?? 'light';
  runApp(MyApp(
    theme: theme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;
  const MyApp({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MarketProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(theme),
          ),
          ChangeNotifierProvider(create: (context) => ChartProvider(),)
        ],
        child: Builder(
          builder: (context) {
            //final themeProvider = Provider.of<ThemeProvider>(context,listen: false);
            return Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  themeMode: themeProvider.themeMode,
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  home: HomePage(),
                );
              },
            );
          },
        ));
  }
}
