import 'package:flutter/material.dart';
import 'package:tomafoco/controllers/home_controller.dart';
import 'package:tomafoco/pages/widgets/buttons_circular_widget.dart';
import 'package:tomafoco/pages/widgets/timer_widget.dart';
import 'package:tomafoco/themes/colors.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({Key? key}) : super(key: key);

  @override
  _PomodoroPageState createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  final _controller = HomeController.instance;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, chield) {
          return Scaffold(
            backgroundColor: _controller.getColor(),
            appBar: AppBar(
              title: const Text(
                'Pomodoro',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  TimerWidget(
                    cardColor: _controller.getColor(),
                    title: _controller.getFormatedTime(),
                    description: _controller.getDescription(),
                    percent: _controller.getPercent(),
                    observation: _controller.getTotalMinutes(),
                  ),
                  buttons(),
                ],
              ),
            ),
          );
        });
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (_controller.isPaused || _controller.isStoped)
            ? ButtonCircularWidget(
                backgroundColor: LightColors.kLightYellow,
                icon: Icons.play_arrow_outlined,
                buttonColor: LightColors.kGreen,
                onPress: () {
                  _controller.initTimer();
                },
              )
            : const SizedBox(
                width: 5,
              ),
        (!_controller.isStoped && !_controller.isPaused)
            ? ButtonCircularWidget(
                backgroundColor: LightColors.kLightYellow,
                icon: Icons.pause_circle,
                buttonColor: LightColors.ligthRed,
                onPress: () {
                  _controller.pauseTimer();
                },
              )
            : const SizedBox(
                width: 5,
              ),
        (_controller.isStoped || _controller.isPaused)
            ? ButtonCircularWidget(
                backgroundColor: LightColors.kLightYellow,
                icon: Icons.cancel_rounded,
                buttonColor: LightColors.ligthRed,
                onPress: () {
                  _controller.cancelTimer();
                },
              )
            : Container()
      ],
    );
  }
}
