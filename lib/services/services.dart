import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_hive1/model/student_model.dart';

class StudentServices {
  Box<Student>? _studentBox;
//open box
  Future<void> openBox() async {
    _studentBox = await Hive.openBox('students');
  }

//close box
  Future<void> closeBox() async {
    _studentBox!.close();
  }

//add new student
  Future<void> addNew(Student student) async {
    if (_studentBox == null) {
      await openBox();
    }
    await _studentBox!.add(student);
  }

//load student list
  Future<List<Student>> getStudent() async {
    if (_studentBox == null) {
      await openBox();
    }
    return _studentBox!.values.toList();
  }

//edit student
  Future<void> updateStudent(int index, Student student) async {
    if (_studentBox == null) {
      await openBox();
    }
    await _studentBox!.putAt(index, student);
  }

//deleate stdent
  Future<void> deleateStudent(int index) async {
    if (_studentBox == null) {
      await openBox();
    }
    await _studentBox!.deleteAt(index);
  }
}
