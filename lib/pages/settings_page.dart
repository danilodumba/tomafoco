import 'package:flutter/material.dart';
import 'package:tomafoco/controllers/settings_controller.dart';
import 'package:tomafoco/pages/widgets/bulet_widget.dart';
import 'package:tomafoco/themes/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final controller = SettingsController.instance;
  int pomodoroTime = 25;
  int sleepTime = 5;
  @override
  initState() {
    controller.get().then((value) {
      setState(() {
        pomodoroTime = value.pomodoroTime;
        sleepTime = value.sleepTime;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.lightGreen,
      appBar: AppBar(
        title: const Text(
          'Ajustes',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, chield) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 23.0,
                    ),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Tempo para o Pomodoro:"),
                        BuletWidget(
                            label: pomodoroTime.toString(),
                            backgroundColor: LightColors.ligthRed,
                            labelColor: LightColors.white)
                      ],
                    ),
                  ),
                  Slider(
                    activeColor: LightColors.ligthRed,
                    value: pomodoroTime.toDouble(),
                    divisions: 9,
                    onChanged: (newValue) async {
                      await controller.setPomodoroTime(newValue);
                      setState(() {
                        pomodoroTime = newValue.toInt();
                      });
                    },
                    label: pomodoroTime.toString(),
                    min: 15,
                    max: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 23.0,
                      top: 40,
                    ),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Tempo para o Descanso:"),
                        BuletWidget(
                            label: sleepTime.toString(),
                            backgroundColor: LightColors.kGreen,
                            labelColor: LightColors.white)
                      ],
                    ),
                  ),
                  Slider(
                    activeColor: LightColors.kGreen,
                    value: sleepTime.toDouble(),
                    divisions: 29,
                    onChanged: (newValue) async {
                      await controller.setSleepTime(newValue);
                      setState(() {
                        sleepTime = newValue.toInt();
                      });
                    },
                    label: sleepTime.toString(),
                    min: 1,
                    max: 30,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(child: Text("v 1.1.1")),
                ],
              ),
            );
          }),
    );
  }
}
