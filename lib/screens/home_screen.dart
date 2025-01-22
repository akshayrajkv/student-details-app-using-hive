import 'package:flutter/material.dart';
import 'package:student_hive1/model/student_model.dart';
import 'package:student_hive1/screens/student_detail.dart';
import 'package:student_hive1/services/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
final  StudentServices _studentServices = StudentServices();
final TextEditingController _namecontroller = TextEditingController();
final TextEditingController _agecontoller = TextEditingController();
final TextEditingController _divisioncontroller = TextEditingController();
FocusNode _focusNode1 =FocusNode();
  FocusNode _focusNode2 =FocusNode();
  FocusNode _focusNode3 =FocusNode();


  List<Student> studentlist = [];
  Future loadStudent() async {
    studentlist = await _studentServices.getStudent();
    setState(() {});
  }

  @override
  void initState(){
    loadStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Students',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialoge();
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
          itemCount: studentlist.length,
          itemBuilder: (context, index) {
            final stud = studentlist[index];
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentDetails(
                          name: stud.name.toString(),
                          age: stud.age.toString(),
                          divition: stud.divition.toString(),
                        ),
                      ));
                },
                leading: CircleAvatar(
                  child: Text("${index + 1}"),
                ),
                title: Text(stud.name.toString()),
                trailing: Container(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _studentServices.deleateStudent(index);
                          loadStudent();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {
                          _editDetails(stud, index);
                          loadStudent();
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showDialoge() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add student'),
          content: Container(
            padding: const EdgeInsets.all(10),
            height: 200,
            child: Column(
              children: [
                TextField(
                  focusNode: _focusNode1,
                  controller: _namecontroller,
                  decoration: const InputDecoration(hintText: 'Name'),
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_focusNode2);
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  focusNode: _focusNode2,
                  controller: _agecontoller,
                  decoration: const InputDecoration(hintText: 'Age'),
                  onSubmitted: (_){
                    FocusScope.of(context).requestFocus(_focusNode3);
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                focusNode:_focusNode3,
                  controller: _divisioncontroller,
                  decoration: const InputDecoration(hintText: 'Division'),
                  
                ),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('close'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    final student = Student(
                        name: _namecontroller.text,
                        age: _agecontoller.text,
                        divition: _divisioncontroller.text);
                    _studentServices.addNew(student);
                    loadStudent();
                    Navigator.pop(context);
                    _namecontroller.clear();
                    _agecontoller.clear();
                    _divisioncontroller.clear();
                  },
                  child: const Text('Save'),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  void _editDetails(Student student, int index) async {
    _namecontroller.text = student.name;
    _agecontoller.text = student.age;
    _divisioncontroller.text = student.divition;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit details'),
          content: Container(
            height: 200,
            child: Column(
              children: [
                TextField(
                  controller: _namecontroller,
                  decoration: InputDecoration(hintText: 'name'),
                ),
                TextField(
                  controller: _agecontoller,
                  decoration: InputDecoration(hintText: 'age'),
                ),
                TextField(
                  controller: _divisioncontroller,
                  decoration: const InputDecoration(hintText: 'division'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _namecontroller.clear();
                _agecontoller.clear();
                _divisioncontroller.clear();
              },
              child: const Text('cancel'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  student.name = _namecontroller.text;
                  student.age = _agecontoller.text;
                  student.divition = _divisioncontroller.text;
                  await _studentServices.updateStudent(index, student);
                  loadStudent();
                  _agecontoller.clear();
                  _namecontroller.clear();
                  _divisioncontroller.clear();
                  Navigator.pop(context);
                },
                child: const Text('save')),
          ],
        );
      },
    );
  }
}
