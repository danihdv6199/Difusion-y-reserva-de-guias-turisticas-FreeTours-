class UserModel {
  String? email;
  String? rol;
  String? userk;
  String? name;

// receiving data: Mejor dicho tarduce lo que llega
  UserModel({this.userk, this.email, this.rol, this.name});

  factory UserModel.fromMap(map) {
    return UserModel(
      userk: map['uid'],
      email: map['email'],
      rol: map['wrool'],
      name: map['name'],
    );
  }
// sending data: traduce lo que se va
  Map<String, dynamic> toMap() {
    return {
      'uid': userk,
      'email': email,
      'wrool': rol,
      'name': name,
    };
  }
}
