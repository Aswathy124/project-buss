import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class DayscholarView extends StatefulWidget {
  const DayscholarView({Key? key}) : super(key: key);

  @override
  State<DayscholarView> createState() => _DayscholarViewState();
}

class _DayscholarViewState extends State<DayscholarView> {
  List<dynamic> dayDetails = [];

  @override
  void initState() {
    super.initState();
    // Call the function to fetch data when the widget is initialized
    fetchData();
  }

  Future<void> fetchData() async {
    // Replace 'your_backend_url' with the actual URL of your backend server
    final url = Uri.parse(
        'http://localhost:3006/api/viewDayscholar/viewDayscholar');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        setState(() {
          dayDetails = json.decode(response.body)['dayDetails'];
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
          'Dayscholar Details',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Colors.black, // Set background color to black
        iconTheme: IconThemeData(
            color: Colors.white), // Set back icon color to white
      ),
      body: Container(
        color: Colors.black, // Set background color to black
        child: ListView.builder(
          itemCount: dayDetails.length,
          itemBuilder: (context, index) {
            final detail = dayDetails[index];
            return Card(
              color: Colors.black, // Set background color of ListTile to black
              child: ListTile(
                title: Text(
                  detail['name'],
                  style: TextStyle(
                      color: Colors.white), // Set text color to white
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Department: ${detail['department']}',
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                    Text(
                      'Admission No: ${detail['admissionNo']}',
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                    Text(
                      'Place: ${detail['place']}',
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                    Text(
                      'Bus No: ${detail['busNo']}',
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.white), // Delete icon
                  onPressed: () async {
                    // Replace 'your_backend_url' with the actual URL of your backend server
                    final deleteUrl = Uri.parse(
                        'http://localhost:3006/api/delete/dayscholar/${detail['_id']}');
                    try {
                      final response = await http.delete(deleteUrl);
                      if (response.statusCode == 200) {
                        // If the server returns a 200 OK response, remove the deleted detail from the list
                        setState(() {
                          dayDetails.removeAt(index);
                        });
                        // Show a snackbar to confirm deletion
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Student detail deleted successfully'),
                          ),
                        );
                      } else {
                        // If the server returns an error response, show an error message
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Failed to delete student detail'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } catch (error) {
                      // Handle any errors that occur during the HTTP request
                      print('Error: $error');
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
