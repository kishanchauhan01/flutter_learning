import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExpandedFlexiblePage extends StatefulWidget {
  const ExpandedFlexiblePage({super.key});

  @override
  State<ExpandedFlexiblePage> createState() => _ExpandedFlexiblePageState();
}

class _ExpandedFlexiblePageState extends State<ExpandedFlexiblePage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    print("inside getData");
    var url = Uri.http('localhost:8000', '/hello', {'q': '{http}'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['activity'];

      print(itemCount);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(child: Container(color: Colors.teal)),
          Expanded(child: Container(color: Colors.orange, height: 70.0)),
        ],
      ),
    );
  }
}
