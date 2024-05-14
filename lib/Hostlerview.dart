import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PassDetailsPage extends StatefulWidget {
  @override
  _PassDetailsPageState createState() => _PassDetailsPageState();
}

class _PassDetailsPageState extends State<PassDetailsPage> {
  List passDetails = [];
  String fromLocation = "";
  String toLocation = "";

  Future<void> fetchPassDetails() async {
    final response = await http.get(Uri.parse('http://localhost:3006/api/viewAll/viewAll'));
    if (response.statusCode == 200) {
      setState(() {
        passDetails = json.decode(response.body)["passDetails"];
      });
    } else {
      throw Exception('Failed to load pass details');
    }
  }

  Future<void> searchPassDetails() async {
    final response = await http.get(Uri.parse('http://localhost:3006/api/search/search?from=$fromLocation&to=$toLocation'));
    if (response.statusCode == 200) {
      setState(() {
        passDetails = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to search pass details');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPassDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pass Details'),
      ),
      backgroundColor: Colors.black, // Set background color to black
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      fromLocation = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'From',
                      labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                    ),
                    style: TextStyle(color: Colors.white), // Set input text color to white
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      toLocation = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'To',
                      labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                    ),
                    style: TextStyle(color: Colors.white), // Set input text color to white
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  searchPassDetails();
                },
                child: Text('Search'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.black, // Set button foreground color to white
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: passDetails.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white, // Set background color to white
                    ),
                    child: Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        _buildTableRow('Name', passDetails[index]["name"]),
                        _buildTableRow('Department', passDetails[index]["department"]),
                        _buildTableRow('Admission No', passDetails[index]["admissionNo"]),
                        _buildTableRow('From', passDetails[index]["from"]),
                        _buildTableRow('To', passDetails[index]["to"]),
                        _buildTableRow('Number of Passes', passDetails[index]["numberOfPasses"].toString()),
                        _buildTableRow('Date', passDetails[index]["date"]),
                        // Add more fields here
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Set text color to black
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              value,
              style: TextStyle(color: Colors.black), // Set text color to black
            ),
          ),
        ),
      ],
    );
  }
}
