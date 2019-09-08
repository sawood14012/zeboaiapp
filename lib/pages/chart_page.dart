import 'package:flutter/material.dart';
import 'package:zebo/pages/simplechart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart extends StatefulWidget {
  Chart({Key key, this.title, this.data}) : super(key: key);

  final String title;
  var data;

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  var data;
  static double var1, var2, var3, var4, var5, var6, var7, var0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  /// Create one series with pass in data.
  List<charts.Series<QuarterSales, String>> mapChartData(
      List<QuarterSales> data) {
    return [
      charts.Series<QuarterSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (QuarterSales sales, _) => sales.quarter,
        measureFn: (QuarterSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    data = widget.data;
    var0 = data['var0'].toDouble();
    var1 = data['var1'].toDouble();
    var2 = data['var2'].toDouble();
    var3 = data['var3'].toDouble();
    var4 = data['var4'].toDouble();
    var5 = data['var5'].toDouble();
    var6 = data['var6'].toDouble();
    var7 = data['var7'].toDouble();
    final mockedData = [
      QuarterSales('var0', var0),
      QuarterSales('var1', var1),
      QuarterSales('var2', var2),
      QuarterSales('var3', var3),
      QuarterSales('var4', var4),
      QuarterSales('var5', var5),
      QuarterSales('var6', var6),
      QuarterSales('var7', var7),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Result's"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SimpleBarChart(mapChartData(mockedData)),
      ),
    );
  }
}
