class User {
  String? id;
  final String name;
  final String email;
  final String pid;

  User({required this.pid, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      pid: json['pid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': pid,
      'name': name,
      'email': email,
    };
  }
}
