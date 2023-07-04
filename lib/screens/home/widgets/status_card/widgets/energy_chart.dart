import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:grid_mobile/helpers/colors_custom.dart';
import 'package:grid_mobile/widgets/custom_text.dart';

import '../../../../../localization/app_translations.dart';

class EnergyChart extends StatefulWidget {
  const EnergyChart({
    super.key,
    required this.isShow,
    required this.statusBgColor,
  });

  final bool isShow;
  final Color statusBgColor;

  @override
  State<EnergyChart> createState() => _EnergyChartState();
}

class _EnergyChartState extends State<EnergyChart> {
  List<Color> gradientColors = [
    ColorsCustom.primary,
    ColorsCustom.blue,
    ColorsCustom.green,
  ];

  List<FlSpot> spotData = const [
    FlSpot(0, 35),
    FlSpot(10, 30),
    FlSpot(20, 27),
    FlSpot(30, 25),
    FlSpot(40, 20),
    FlSpot(50, 11),
    FlSpot(60, 0),
  ];

  // Y Axis = KWh
  // X Axis = Time

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: widget.isShow ? 1 : 0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: widget.isShow ? 200 : 0,
          margin: const EdgeInsets.only(top: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorsCustom.black,
                border:
                    Border.all(color: widget.statusBgColor.withOpacity(0.3))),
            child: LineChart(
              mainData(),
            ),
          ),
        ));
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: CustomText(
        value.toInt().toString(),
        color: ColorsCustom.white,
        fontWeight: FontWeight.w500,
        fontSize: 8,
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    String kwh = AppTranslations.of(context)!.text("kwh");
    switch (value.toInt()) {
      case 0:
        text = '0 $kwh';
        break;
      case 25:
        text = '25 $kwh';
        break;
      case 50:
        text = '50 $kwh';
        break;
      default:
        return Container();
    }

    return CustomText(
      text,
      color: ColorsCustom.white,
      textAlign: TextAlign.left,
      fontWeight: FontWeight.w500,
      fontSize: 8,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 10,
        verticalInterval: 10,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: ColorsCustom.primary.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: ColorsCustom.primary.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            interval: 10,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 120,
      minY: 0,
      maxY: 50,
      lineBarsData: [
        LineChartBarData(
          spots: spotData,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
