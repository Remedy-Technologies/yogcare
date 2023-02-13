import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:yoga_app/utils/date_time.dart';
import 'package:velocity_x/velocity_x.dart';

class MonthlySummary extends StatelessWidget {
  

  const MonthlySummary({
    super.key,
    required this.datasets,
     required this.startDate,
  });
  final Map<DateTime, int>? datasets;
  final String startDate;
  

  @override
  Widget build(BuildContext context) {
    
    return Container(
      
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Color.fromARGB(216, 241, 218, 221),
        textColor: context.primaryColor,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color.fromARGB(20, 2, 179, 8),
          2: Color.fromARGB(40, 2, 179, 8),
          3: Color.fromARGB(60, 2, 179, 8),
          4: Color.fromARGB(80, 2, 179, 8),
          5: Color.fromARGB(100, 2, 179, 8),
          6: Color.fromARGB(120, 2, 179, 8),
          7: Color.fromARGB(150, 2, 179, 8),
          8: Color.fromARGB(180, 2, 179, 8),
          9: Color.fromARGB(220, 2, 179, 8),
          10: Color.fromARGB(255, 2, 179, 8),
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}