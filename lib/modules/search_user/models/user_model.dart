class UserModel {
  final String id;
  final String name;
  final String img;

  UserModel({required this.id, required this.name, required this.img});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'].toString(),
      name: map['login'] as String,
      img: map['avatar_url'] as String,
    );
  }
}
