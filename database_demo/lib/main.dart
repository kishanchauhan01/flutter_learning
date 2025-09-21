import 'package:database_demo/contact_model.dart';
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

  List<ContactModel> contactList = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    DbHelper dbHelper = DbHelper();
    List<ContactModel> contact = await dbHelper.getData();
    setState(() {
      contactList = contact;
    });
  }

  Future<void> saveData() async {
    String name = nameController.text;
    String mobile = mobileController.text;

    if (name.isEmpty || mobile.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter all fields")));
      return;
    }

    DbHelper dbHelper = DbHelper();

    await dbHelper.insertRecord(name, mobile);

    nameController.clear();
    mobileController.clear();

    _loadContacts();
  }

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
                  controller: nameController,
                  decoration: InputDecoration(
                    hint: Text("Name"),
                    label: Text("Enter your name"),
                  ),
                ),

                SizedBox(height: 10),

                TextFormField(
                  controller: mobileController,
                  decoration: InputDecoration(
                    hint: Text("Mobile number"),
                    label: Text("Enter your mobile number"),
                  ),
                ),

                SizedBox(height: 10),

                ElevatedButton(onPressed: saveData, child: Text("Save")),

                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: contactList.length,
                    itemBuilder: (context, index) {
                      ContactModel model = contactList[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            model.mobile,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Divider(),
                          SizedBox(height: 10,)
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
