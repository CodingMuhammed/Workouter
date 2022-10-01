class Exercise {
  String name;
  String type;
  int? caloriesBurnt;
  double? time;
  int? reps;
  int? sets;
  double? weight;
  double? rest;
  String? id;

  Exercise(this.reps, this.sets, this.weight, this.name, this.rest, this.type);

  Exercise.fromJson(Map<String, Object?> exercise)
      : name = exercise['name']! as String,
        type = exercise['type']! as String,
        caloriesBurnt = exercise['calories_burnt']! as int,
        time = exercise['type']! as double,
        reps = exercise['reps']! as int,
        sets = exercise['sets']! as int,
        weight = exercise['weight']! as double,
        rest = exercise['rest']! as double;

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'calories_burnt': caloriesBurnt,
        'time': time,
        'reps': reps,
        'sets': sets,
        'weight': weight,
        'rest': rest
      };
}
