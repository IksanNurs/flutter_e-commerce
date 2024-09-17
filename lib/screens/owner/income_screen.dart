import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:showroom_app/utils/colors_constant.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../component/bar_chart_model.dart';

class IncomeScreen extends StatefulWidget {
  IncomeScreen({super.key});


  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
    final List<BarChartModel> data = [
    BarChartModel(
      month: "Jan",
      financial: 250,
      color: charts.ColorUtil.fromDartColor(ColorsConstant.greenColor),
    ),
    BarChartModel(
      month: "Feb",
      financial: 300,
      color: charts.ColorUtil.fromDartColor(ColorsConstant.greenColor),
    ),
    BarChartModel(
      month: "Mar",
      financial: 100,
      color: charts.ColorUtil.fromDartColor(ColorsConstant.greenColor),
    ),
    BarChartModel(
      month: "Apr",
      financial: 450,
      color: charts.ColorUtil.fromDartColor(ColorsConstant.greenColor),
    ),
    BarChartModel(
      month: "Mei",
      financial: 630,
      color: charts.ColorUtil.fromDartColor(ColorsConstant.greenColor),
    ),
    BarChartModel(
      month: "Jun",
      financial: 950,
      color: charts.ColorUtil.fromDartColor(ColorsConstant.greenColor),
    ),
    BarChartModel(
      month: "Jul",
      financial: 400,
      color: charts.ColorUtil.fromDartColor(ColorsConstant.greenColor),
    ),
  ];

  
  
  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "financial",
        data: data,
        domainFn: (BarChartModel series, _) => series.month,
        measureFn: (BarChartModel series, _) => series.financial,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black87,
              size: 40,
            ),
          ),
        ),
        // automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Penghasilan',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: charts.BarChart(
          
          series,
          animate: true,
        ),
      )
    );
  }

}