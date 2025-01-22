import 'package:flutter/material.dart';
import 'package:student_hive1/screens/widgets/tilewidget.dart';

class StudentDetails extends StatelessWidget {
  String name;
  String age;
  String divition;
  StudentDetails(
      {super.key,
      required this.name,
      required this.age,
      required this.divition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Students Details',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 150,
          ),
          const Center(
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.amber,
            ),
          ),
          TileWidget(itemname: 'StudentName', itemvalue: name),
          TileWidget(itemname: 'Age', itemvalue: age),
          TileWidget(itemname: 'Division', itemvalue: divition),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
