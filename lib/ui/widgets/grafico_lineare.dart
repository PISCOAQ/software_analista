import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const LineChartWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.black,
        width: 2,
        ),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SfCartesianChart(
          title: ChartTitle(text: 'Andamento punteggi nei test'),

          /// ASSE X → TEST
          primaryXAxis: CategoryAxis(
            title: AxisTitle(text: 'Test'),
            labelRotation: -45, // utile se i nomi sono lunghi
          ),

          /// ASSE Y → PUNTEGGIO
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: 'Punteggio'),
            minimum: 0,
            maximum: 10,
            interval: 1,
          ),

          series: <LineSeries<Map<String, dynamic>, String>>[
            LineSeries<Map<String, dynamic>, String>(
              dataSource: data,

              /// NOME DEL TEST
              xValueMapper: (datum, _) => datum['test'] as String,

              /// PUNTEGGIO OTTENUTO
              yValueMapper: (datum, _) => datum['punteggio'] as num,

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
