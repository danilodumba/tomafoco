class Pomodore {
  int timer = 0;
  int timeLeft = 0;
  int dayOfPomodore;
  int countPomodoreDay = 0;
  bool inPause = false;
  bool working = false;

  Pomodore(this.timer, this.timeLeft, this.dayOfPomodore);

  double getPercent() {
    return ((timeLeft * 100) / timer) / 100;
  }

  String getFormatedTime() {
    String getParsedTime(String time) {
      if (time.length <= 1) return "0$time";
      return time;
    }

    int min = timeLeft ~/ 60;
    int sec = timeLeft % 60;

    String parsedTime =
        getParsedTime(min.toString()) + ":" + getParsedTime(sec.toString());

    return parsedTime;
  }

  String getTotalMinutes() {
    double total = this.timer / 60;

    return total.toInt().toString() + " min.";
  }

  void init() {
    working = true;
    inPause = false;
  }

  void pause() {
    working = true;
    inPause = true;
  }

  void stop() {
    working = false;
    inPause = false;
  }

  bool isWorking() {
    return working;
  }

  bool isInPause() {
    return working == true && inPause == true;
  }

  Map<String, dynamic> toJson() => {
        'timer': timer,
        'timerLeft': timeLeft,
        'dayOfPomodore': dayOfPomodore,
        'countPomodoreDay': countPomodoreDay,
        'inPause': inPause,
        'working': working,
      };

  Pomodore.fromJson(Map<String, dynamic> json)
      : timer = json['timer'],
        timeLeft = json['timeLeft'],
        dayOfPomodore = json['dayOfPomodore'],
        countPomodoreDay = json['countPomodoreDay'],
        inPause = json['inPause'],
        working = json['working'];

  String toString() {
    var json = this.toJson();
    return json.toString();
  }
}
