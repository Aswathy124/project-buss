import 'package:buspassfinal/PaymentPage.dart';
import 'package:flutter/material.dart';
import 'MODEL/buspass.dart';

class ViewHostler extends StatelessWidget {
  final BusPassModel busPass;
  final DateTime currentDate;
  final DateTime passExpiryDate;

  const ViewHostler({
    Key? key,
    required this.busPass,
    required this.currentDate,
    required this.passExpiryDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/fisats.jpg'),
                        radius: 30,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Federal Institute of',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Science and Technology',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Name: ${busPass.name}', style: TextStyle(color: Colors.black)),
                      Text('Department: ${busPass.department}', style: TextStyle(color: Colors.black)),
                      Text('Admission No: ${busPass.admissionNo}', style: TextStyle(color: Colors.black)),
                      Text('From: ${busPass.from}', style: TextStyle(color: Colors.black)),
                      Text('To: ${busPass.to}', style: TextStyle(color: Colors.black)),
                      Text('Number of Passes: ${busPass.numberOfPasses}', style: TextStyle(color: Colors.black)),
                      Text('Date: ${currentDate.day}/${currentDate.month}/${currentDate.year}', style: TextStyle(color: Colors.black)),
                      Text('Pass Expiry Date: ${passExpiryDate.day}/${passExpiryDate.month}/${passExpiryDate.year}', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PricingPage()),
                      );
                    },
                    child: Text('View Pricing Information'),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PricingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pricing Information',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Fisat to Thrissur',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                _buildPricingInfo('1 pass', '60 rupees'),
                _buildPricingInfo('2 passes', '120 rupees'),
                _buildPricingInfo('3 passes', '180 rupees'),
                _buildPricingInfo('4 passes', '240 rupees'),
                _buildPricingInfo('5 passes', '300 rupees'),
                _buildPricingInfo('6 passes', '360 rupees'),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Fisat to Angamaly',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                _buildPricingInfo('1 pass', '25 rupees'),
                _buildPricingInfo('2 passes', '50 rupees'),
                _buildPricingInfo('3 passes', '75 rupees'),
                _buildPricingInfo('4 passes', '100 rupees'),
                _buildPricingInfo('5 passes', '125 rupees'),
                _buildPricingInfo('6 passes', '150 rupees'),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentPage()),
          );
        },
        child: Icon(Icons.payment),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildPricingInfo(String pass, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            pass,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            '- $price',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
