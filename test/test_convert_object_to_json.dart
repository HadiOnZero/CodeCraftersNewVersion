import 'dart:convert';

class Test {
  String target;
  String payload;

  Test({required this.target, required this.payload});

  Map<String, dynamic> toJson() {
    return {'target': target, payload: 'payload'};
  }
}

void main() {
  List<Test> data = [Test(target: "google.com", payload: "sqli")];
  List<Map<String, dynamic>> listData = data.map((e) => e.toJson()).toList();
  final result = jsonEncode(listData);
  print(result);
}
