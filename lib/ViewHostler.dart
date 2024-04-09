import 'package:flutter/material.dart';
import 'MODEL/buspass.dart';

class ViewHostler extends StatelessWidget {
  final BusPassModel busPass;
  final DateTime currentDate; // Add a DateTime parameter

  const ViewHostler({Key? key, required this.busPass, required this.currentDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Set background color of Scaffold to transparent
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Set background color of AppBar to transparent
        elevation: 0, // Remove the shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back when the back icon is pressed
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 5), // Add border
              borderRadius: BorderRadius.circular(20), // Add border radius
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/fisats.jpg'), // Provide the path to the image
                        radius: 30, // Set the radius of the avatar
                      ),
                      SizedBox(width: 10), // Add space between avatar and text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Federal Institute',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Set text color to black
                            ),
                          ),
                          Text(
                            'of',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Set text color to black
                            ),
                          ),
                          Text(
                            'Science and Technology',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Set text color to black
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BUS PASS',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Set text color to black
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Name: ${busPass.name}', style: TextStyle(color: Colors.black)), // Set text color to black
                      Text('Department: ${busPass.department}', style: TextStyle(color: Colors.black)), // Set text color to black
                      Text('Admission No: ${busPass.admissionNo}', style: TextStyle(color: Colors.black)), // Set text color to black
                      Text('From: ${busPass.from}', style: TextStyle(color: Colors.black)), // Set text color to black
                      Text('To: ${busPass.to}', style: TextStyle(color: Colors.black)), // Set text color to black
                      Text('Number of Passes: ${busPass.numberOfPasses}', style: TextStyle(color: Colors.black)), // Set text color to black
                      Text('Date: ${currentDate.day}/${currentDate.month}/${currentDate.year}', style: TextStyle(color: Colors.black)), // Display the current date, Set text color to black
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pricing Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildPassPrice('1 pass', '60 rupees'),
                      _buildPassPrice('2 passes', '120 rupees'),
                      _buildPassPrice('3 passes', '180 rupees'),
                      _buildPassPrice('4 passes', '240 rupees'),
                      _buildPassPrice('5 passes', '300 rupees'),
                      _buildPassPrice('6 passes', '360 rupees'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Positioned(
        bottom: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Adjust the padding here
          child: FloatingActionButton(
            onPressed: () {
              // Add your onPressed logic here
            },
            child: Icon(Icons.payment), // Pay icon
            // Set background color to black
          ),
        ),
      ),
    );
  }

  Widget _buildPassPrice(String pass, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              pass,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '- $price',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
