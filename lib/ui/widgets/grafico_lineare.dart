import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:software_analista/domain/models/linechartpoint.dart';
class LineChartWidget extends StatelessWidget {
  final List<LineChartPoint> data;
  final String title;
  final String xAxisTitle;
  final String yAxisTitle;
  final double? maxY;

  const LineChartWidget({
    super.key,
    required this.data,
    required this.title,
    required this.xAxisTitle,
    required this.yAxisTitle,
    this.maxY,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Colors.black,
          width: 2,
        ),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SfCartesianChart(
          title: ChartTitle(text: title),

          /// ASSE X
          primaryXAxis: CategoryAxis(
            title: AxisTitle(text: xAxisTitle),
            labelRotation: -45,
          ),

          /// ASSE Y
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: yAxisTitle),
            minimum: 0,
            maximum: maxY,
          ),

          series: <LineSeries<LineChartPoint, String>>[
            LineSeries<LineChartPoint, String>(
              dataSource: data,

              xValueMapper: (point, _) => point.label,
              yValueMapper: (point, _) => point.value,

              color: Colors.blue,
              width: 3,
              markerSettings: const MarkerSettings(
                isVisible: true,
                height: 8,
                width: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}