class Workout {
  String name;
  List exercises;
  double time;
  String? id;

  Workout(this.name, this.time, this.exercises);

  Workout.fromJson(Map<String, Object?> workout)
      : name = workout['name']! as String,
        time = workout['time']! as double,
        exercises = workout['exercises'] as List;

  Map<String, dynamic> toJson() => {'workout_name': name, 'time': time, 'exercises': exercises};
}
