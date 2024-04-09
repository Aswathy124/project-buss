import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';



class ViewDayscholar extends StatelessWidget {
  final String name;
  final String department;
  final String admissionNo;
  final String place;
  final String busNo;

  const ViewDayscholar({
    Key? key,
    required this.name,
    required this.department,
    required this.admissionNo,
    required this.place,
    required this.busNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('assets/fisats.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Federal Institute of Science and Technology',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'CONCESSION CARD',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Name: $name'),
              Text('Department: $department'),
              Text('Admission No: $admissionNo'),
              Text('Place: $place'),
              Text('Bus No: $busNo'),
              SizedBox(height: 20),
              Spacer(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await downloadPdf();
        },
        child: Icon(Icons.file_download),
        backgroundColor: Colors.blue,
      ),
      extendBodyBehindAppBar: true,
    );
  }

  Future<void> downloadPdf() async {
    final url = 'http://localhost:3006/api/download/download';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'name': name,
        'department': department,
        'admissionNo': admissionNo,
        'place': place,
        'busNo': busNo,
      },
    );

    if (response.statusCode == 200) {
      final pdfBytes = response.bodyBytes;
      final output = await getTemporaryDirectory();
      final file = File('${output.path}/example.pdf');
      await file.writeAsBytes(pdfBytes);
      await OpenFile.open(file.path);
    } else {
      throw Exception('Failed to load PDF: ${response.statusCode}');
    }
  }
}

