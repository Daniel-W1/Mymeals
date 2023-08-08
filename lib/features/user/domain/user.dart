class User {
  String? id;
  final String name;
  final String email;
  final String pid;
  final int age;
  final String sex;
  final String preference;

  User(
      {required this.pid,
      required this.name,
      required this.email,
      required this.sex,
      required this.age,
      required this.preference, 
      this.id
      });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      pid: json['pid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      sex: json['sex'] as String,
      age: json['age'] as int,
      preference: json['preference'] as String,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pid': pid,
      'name': name,
      'email': email,
      'sex': sex,
      'age': age,
      'preference': preference,
      'id': id
    };
  }
}
