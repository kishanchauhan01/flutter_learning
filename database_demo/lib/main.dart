import 'package:database_demo/db_helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Contact info")),

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hint: Text("Name"),
                    label: Text("Enter your name"),
                  ),
                ),

                SizedBox(height: 10),

                TextFormField(

                  decoration: InputDecoration(
                    hint: Text("Mobile number"),
                    label: Text("Enter your mobile number"),
                  ),
                ),

                SizedBox(height: 10),

                ElevatedButton(onPressed: () {
                  String name = nameController.text;
                  String mobile = mobileController.text;

                  DbHelper dbHelper = DbHelper();

                  dbHelper.insertRecord(name, mobile);
                  print("okkkkkkkk inserted");

                }, child: Text("Save")),

                ListView(
                  
                )
              ],
            ),

            
          ),
        ),
      ),
    );
  }
}
