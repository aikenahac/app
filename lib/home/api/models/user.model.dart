class UserModel {
  const UserModel({
    required this.name,
    required this.balance,
    required this.email,
  });

  final String name;
  final int balance;
  final String email;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'] as String,
        balance: json['balance'] as int,
        email: json['email'] as String,
      );
}
