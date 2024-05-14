import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


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
      appBar: AppBar(

      ),
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
        onPressed: () {
          downloadPdf();
        },
        child: Icon(Icons.file_download),
        backgroundColor: Colors.blue,
      ),
      extendBodyBehindAppBar: true,
    );
  }

  void downloadPdf() async {
    final url = 'http://localhost:3006/api/download/download?' // Add '?' here
        'name=$name&department=$department&admissionNo=$admissionNo&place=$place&busNo=$busNo';

    // Launch the download URL in the browser
    await launch(url);
  }

}
