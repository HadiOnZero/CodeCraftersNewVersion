import 'dart:convert';

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  // Convert dari JSON ke Object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], email: json['email']);
  }
}

void main() {
  // CONVERT JSON STRING KE LIST
  List<User> convertJsonStringToList(String jsonString) {
    // Decode JSON string ke list dynamic
    List<dynamic> jsonList = jsonDecode(jsonString);

    // Convert list dynamic ke list User objects
    List<User> users = jsonList.map((json) => User.fromJson(json)).toList();

    print('\nConverted ${users.length} users');
    return users;
  }
}
