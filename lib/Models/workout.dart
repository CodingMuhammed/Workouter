class Workout {
  String name;
  double time;
  String? id;

  Workout(this.name, this.time);

  Workout.fromJson(Map<String, Object?> workout)
      : name = workout['name']! as String,
        time = workout['time']! as double;

  Map<String, dynamic> toJson() => {'workout_name': name, 'time': time};
}
