class UserModel {
  String? name;
  String? email;
  String? password;
  String? uid;
  String? date;
  String? phone;
  String? user;

  UserModel(
      {this.name, this.email, this.uid,this.password,this.date,this.phone,this.user});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map["uid"],
      name: map["name"],
      email: map["email"],
      password: map["password"],

      date: map["date"],
      phone: map["phone"],
      user: map["user"],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "password": password,
      "date": date,
      "phone": phone,
      "user": user,

    };
  }
}
