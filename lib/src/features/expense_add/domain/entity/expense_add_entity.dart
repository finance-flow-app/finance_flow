import 'package:equatable/equatable.dart';

class ExpenseAddEntity extends Equatable {
  const ExpenseAddEntity({
    required this.amount,
    this.category,
    this.description,
    required this.createdAt,
  });

  final double amount;
  final String? category;
  final String? description;
  final DateTime createdAt;

  @override
  List<Object?> get props => [amount, category, description, createdAt];

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'category': category,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ExpenseAddEntity.fromJson(Map<String, dynamic> json) {
    return ExpenseAddEntity(
      amount: json['amount'],
      category: json['category'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
