import 'package:hive_flutter/hive_flutter.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int age;
  @HiveField(3)
  final int rollNo;
  @HiveField(4)
  final int parentNumber;
  @HiveField(5)
  final String image;
  StudentModel(
      {this.id,
      required this.name,
      required this.age,
      required this.rollNo,
      required this.parentNumber,
      required this.image});
}
