import 'package:buspassfinal/MODEL/viewhostler.dart';
import 'package:buspassfinal/SERVICE/viewhostler.dart';
import 'package:flutter/material.dart';

class Hostlerview extends StatefulWidget {
  const Hostlerview({Key? key}) : super(key: key);

  @override
  State<Hostlerview> createState() => _HostlerviewState();
}

class _HostlerviewState extends State<Hostlerview> {
  late Future<List<PassDetails>> _passDetailsFuture;

  @override
  void initState() {
    super.initState();
    _passDetailsFuture = PassDetailsService.fetchPassDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search action here
            },
          ),
        ],
      ),
      backgroundColor: Colors.black, // Set background color to black
      body: FutureBuilder<List<PassDetails>>(
        future: _passDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white))); // Set text color to white
          } else {
            final passDetails = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'PASS DETAILS',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: passDetails.length,
                    itemBuilder: (context, index) {
                      final detail = passDetails[index];
                      return ListTile(
                        title: Text(detail.name, style: TextStyle(color: Colors.white)), // Set text color to white
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Admission No: ${detail.admissionNo}', style: TextStyle(color: Colors.white)), // Set text color to white
                            Text('From: ${detail.from}', style: TextStyle(color: Colors.white)), // Set text color to white
                            Text('To: ${detail.to}', style: TextStyle(color: Colors.white)), // Set text color to white
                            Text('Number of Passes: ${detail.numberOfPasses}', style: TextStyle(color: Colors.white)), // Set text color to white
                            Text('Date: ${detail.date}', style: TextStyle(color: Colors.white)), // Set text color to white
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
