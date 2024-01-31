class UserModel {
  String? uid;
  String name;
  String email;
  int number;
  String bio;

  UserModel(
      {required this.bio,
      required this.email,
      required this.name,
      required this.number,
       this.uid});

  Map<String, dynamic> toJson(uid) => {
        "uid": uid,
        "name": name,
        "email": email,
        "number": number,
        "bio": bio,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      bio: json["bio"],
      email: json["email"],
      name: json["name"],
      number: json["number"],
      uid: json["uid"]);
}
