import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ViewAllHodsScreen extends StatefulWidget {
  const ViewAllHodsScreen({Key? key}) : super(key: key);

  @override
  State<ViewAllHodsScreen> createState() => _ViewAllHodsScreenState();
}

class _ViewAllHodsScreenState extends State<ViewAllHodsScreen> {
  List<dynamic> hodDetails = [];

  @override
  void initState() {
    super.initState();
    // Call the function to fetch data when the widget is initialized
    fetchData();
  }

  Future<void> fetchData() async {
    // Replace 'your_backend_url' with the actual URL of your backend server
    final url = Uri.parse('http://localhost:3006/api/viewHod/viewHod');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        setState(() {
          hodDetails = json.decode(response.body)['hodDetails'];
        });
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load data');
      }
    } catch (error) {
      // Handle any errors that occur during the HTTP request
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HOD Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: hodDetails.length,
          itemBuilder: (context, index) {
            final detail = hodDetails[index];
            return Card(
              color: Colors.black,
              child: ListTile(
                title: Text(
                  detail['name'],
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Department: ${detail['department']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Reason: ${detail['reason']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Bus: ${detail['bus']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Student Email: ${detail['studentEmail']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'HOD Name: ${detail['hodName']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'HOD Mail: ${detail['hodMail']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Tutor Name: ${detail['tutorName']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Tutor Mail: ${detail['tutorMail']}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
