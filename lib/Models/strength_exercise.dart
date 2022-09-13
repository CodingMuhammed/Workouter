class StrengthExercise {
  String name;
  String type;
  int reps;
  int sets;
  double weight;
  double rest;
  String? id;

  StrengthExercise(
      this.reps, this.sets, this.weight, this.name, this.rest, this.type);

  StrengthExercise.fromJson(Map<String, Object?> exercise)
      : name = exercise['name']! as String,
        type = exercise['type']! as String,
        reps = exercise['reps']! as int,
        sets = exercise['sets']! as int,
        weight = exercise['weight']! as double,
        rest = exercise['rest']! as double;

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'reps': reps,
        'sets': sets,
        'weight': weight,
        'rest': rest
      };
}
