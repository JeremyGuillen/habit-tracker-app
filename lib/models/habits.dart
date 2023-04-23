class Habit {
  late String idUser;
  late String idHabit;
  late String description;
  late String name;

  Habit(this.idHabit, this.idUser, this.name, this.description);

  Habit.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'];
    idHabit = json['id_habit'];
    description = json['description'];
    name = json['name'];
  }
}
