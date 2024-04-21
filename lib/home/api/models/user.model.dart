class UserModel {
  UserModel({
    required this.name,
    required this.balance,
  });

  late String name;
  late int balance;
  late String email;

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    balance = json['balance'] as int;
    email = json['email'] as String;
  }
}
