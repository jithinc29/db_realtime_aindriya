class UserModel {
  final String id;
  final String name;
  final String age;

  UserModel({required this.id, required this.name, required this.age});

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(name: json['name'], age: json['age'], id: json["id"]);
  }
}
