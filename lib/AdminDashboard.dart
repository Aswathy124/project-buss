import 'package:buspassfinal/Hostlerview.dart';
import 'package:buspassfinal/RequestView.dart';
import 'package:buspassfinal/dayscholarview.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        // You can add more app bar customization here
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ADMIN !!!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24, // Adjust the font size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              _buildGradientBox(
                context,
                Colors.blue,
                Colors.purple,
                'HOSTLERS',
                    () {
                  // Navigate to Hostlerview
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Hostlerview()));
                },
              ),
              SizedBox(height: 20),
              _buildGradientBox(
                context,
                Colors.blue,
                Colors.purple,
                'DAYSCHOLAR',
                    () {
                  // Navigate to page 2
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>DayscholarView()));
                },
              ),
              SizedBox(height: 20),
              _buildGradientBox(
                context,
                Colors.blue,
                Colors.purple,
                'REQUEST FOR FACULTY',
                    () {
                  // Navigate to page 3
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>ViewAllHodsScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientBox(BuildContext context, Color startColor, Color endColor, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [startColor, endColor],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
