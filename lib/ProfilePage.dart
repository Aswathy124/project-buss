import 'package:buspassfinal/vehicle%20booking.dart';
import 'package:flutter/material.dart';
import 'Hostler.dart';
import 'MailPage.dart';
import 'Register.dart';
import 'facultysub.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late double _top;
  late double _initialTop;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _top = 0.0;
    _initialTop = 0.0;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: 100.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _top = _initialTop + _animation.value;
        });
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToPage(String pageName) {
    Navigator.pop(context); // Close the drawer
    switch (pageName) {
      case 'Hostler':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BusPass()),
        );
        break;
      case 'Day Scholar':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Register()),
        );
        break;
      case 'Request to Faculty':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FacultySub()),
        );
        break;
      case 'Vehicle Booking': // New case for vehicle booking
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VehicleBooking()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Set app bar color to blue
        title: Text(
          'Welcome to Campus Navigator',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.mail_outline_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MailPage()),
              );
            },
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white), // Make the menu icon white
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black, // Set the background color to black
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black, // Set the background color to black
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10), // Adjust the spacing as needed
                    CircleAvatar(
                      backgroundColor: Colors.black, // Set the background color to black
                      radius: 50, // Set the radius of the avatar
                      backgroundImage: AssetImage('assets/fisats.jpg'),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  'Bus Pass',
                  style: TextStyle(color: Colors.white), // Set the text color to white
                ),
                onTap: () {
                  navigateToPage('Hostler');
                },
              ),
              ListTile(
                title: Text(
                  'Concession Card',
                  style: TextStyle(color: Colors.white), // Set the text color to white
                ),
                onTap: () {
                  navigateToPage('Day Scholar');
                },
              ),
              ListTile(
                title: Text(
                  'Request to Faculty',
                  style: TextStyle(color: Colors.white), // Set the text color to white
                ),
                onTap: () {
                  navigateToPage('Request to Faculty');
                },
              ),
              ListTile( // New ListTile for Vehicle Booking
                title: Text(
                  'Vehicle Booking',
                  style: TextStyle(color: Colors.white), // Set the text color to white
                ),
                onTap: () {
                  navigateToPage('Vehicle Booking');
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height, // Set the background color to blue
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/fisat8.jpg',
                fit: BoxFit.cover,
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 4 + _top,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0), // Adjusted padding
                  child: Text(
                    'Welcome to FISAT College, where transportation is made easy with our comprehensive bus facility, Your Digital Ticket to Campus Transit. Whether you are a day scholar, hosteler, or faculty member, our modern buses ensure a comfortable commute to and from campus. With digital ticketing and real-time tracking, traveling to FISAT is convenient and stress-free. Join us and make your journey to campus effortless.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set the opacity to 1.0 for fully opaque white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
