class CardiovascularExercise {
  String name;
  String type;
  int caloriesBurnt;
  double time;
  String? id;

  CardiovascularExercise(this.name, this.type, this.caloriesBurnt, this.time);

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'calories_burnt': caloriesBurnt,
        'time': time
      };

  CardiovascularExercise.fromJson(Map<String, Object?> exercise)
      : name = exercise['name']! as String,
        type = exercise['type']! as String,
        caloriesBurnt = exercise['calories_burnt']! as int,
        time = exercise['time']! as double;
}
