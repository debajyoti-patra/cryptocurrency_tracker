import 'package:flutter/material.dart';

import '../models/chartModel.dart';
import '../services/api.dart';

class ChartProvider with ChangeNotifier{
  void takeId(String id){
   getChatData(id);
   notifyListeners();
  }
  List<ChartData>chartData = [];
  void getChatData(String id)async{
    List<dynamic> tempChartData = await Api.getChartData(id);
    List<ChartData>temp = [];
    for(var data in tempChartData){
      ChartData curr = ChartData(dateTime:DateTime.fromMillisecondsSinceEpoch(data[0]), price: data[1]);
      temp.add(curr);
    }
    chartData = temp;
    notifyListeners();
  }
}