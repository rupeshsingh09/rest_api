// ✅ UserModel class to represent a user from the /users API
class UserModel {
  // ✅ User's name
  String? name;

  // ✅ User's username
  String? username;

  // ✅ User's email
  String? email;

  // ✅ Constructor with optional named parameters
  UserModel({this.name, this.username, this.email});

  // ✅ Factory constructor to create a UserModel instance from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // ✅ Assign name from JSON, nullable
      name: json['name'],
      // ✅ Assign username from JSON, nullable
      username: json['username'],
      // ✅ Assign email from JSON, nullable
      email: json['email'],
    );
  }
}
