import 'package:hive_flutter/hive_flutter.dart';

part 'student_model.g.dart';

@ HiveType(typeId: 0)
class Student{
  @ HiveField(0)
  late String name;
  @HiveField(1)
  late String age;
  @ HiveField(2)
  late String divition;

Student({
required this.name,required this.age,required this.divition,
});

}