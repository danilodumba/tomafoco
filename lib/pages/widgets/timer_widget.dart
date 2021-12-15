import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimerWidget extends StatelessWidget {
  final Color cardColor;
  final double percent;
  final String title;
  final String description;
  final String observation;

  const TimerWidget({
    Key? key,
    this.cardColor = Colors.white,
    this.percent = 0,
    this.observation = '',
    this.title = '',
    this.description = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: CircularPercentIndicator(
            //animation: true,
            radius: 280.0,
            percent: percent,
            lineWidth: 6.0,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.white10,
            progressColor: Colors.white,
            center: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  observation,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
