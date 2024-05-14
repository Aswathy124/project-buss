import 'package:buspassfinal/SERVICE/request.dart';
import 'package:flutter/material.dart';

import 'MODEL/request.dart';

class FacultySub extends StatefulWidget {
  const FacultySub({Key? key}) : super(key: key);

  @override
  State<FacultySub> createState() => _FacultySubState();
}

class _FacultySubState extends State<FacultySub> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _studentEmailController = TextEditingController();
  final TextEditingController _hodNameController = TextEditingController();
  final TextEditingController _hodMailController = TextEditingController();
  final TextEditingController _tutorNameController = TextEditingController();
  final TextEditingController _tutorMailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black, // Change color to black
          image: DecorationImage(
            image: AssetImage("assets/image1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Request Form to Have Bus',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Container for input fields
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        _buildFormField(
                          _nameController,
                          'Name of the Student',
                          Icons.person,
                        ),
                        SizedBox(height: 10),
                        _buildFormField(
                          _departmentController,
                          'Department',
                          Icons.school,
                        ),
                        SizedBox(height: 10),
                        _buildFormField(
                          _reasonController,
                          'Reason to Have Bus',
                          Icons.info,
                          largeText: true,
                        ),
                        SizedBox(height: 10),
                        _buildFormField(
                          _studentEmailController,
                          'Student Email',
                          Icons.email,
                          largeText: true,
                        ),
                        SizedBox(height: 10),
                        _buildFormField(
                          _hodNameController,
                          'HOD Name',
                          Icons.person,
                          largeText: true,
                        ),
                        SizedBox(height: 10),
                        _buildFormField(
                          _hodMailController,
                          'HOD Mail ID',
                          Icons.email,
                        ),
                        SizedBox(height: 10),
                        _buildFormField(
                          _tutorNameController,
                          'Tutor Name',
                          Icons.person,
                          largeText: true,
                        ),
                        SizedBox(height: 10),
                        _buildFormField(
                          _tutorMailController,
                          'Tutor Mail ID',
                          Icons.email,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: Text('Submit', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(
      TextEditingController controller,
      String labelText,
      IconData iconData, {
        bool largeText = false,
      }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(iconData, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.black.withOpacity(0.5),
        labelStyle: TextStyle(color: Colors.white),
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: largeText ? 18 : 14,
      ),
    );
  }

  void _submitForm() async {
    // Create a HodModel instance with the form data
    final hod = HodModel(
      name: _nameController.text,
      department: _departmentController.text,
      reason: _reasonController.text,
      bus: 'Bus',
      // You can set default bus value here
      studentEmail: _studentEmailController.text,
      hodName: _hodNameController.text,
      hodMail: _hodMailController.text,
      tutorName: _tutorNameController.text,
      tutorMail: _tutorMailController.text,
    );

    try {
      // Call a service method to submit the form data
      await HodService.submitHodForm(hod);

      // Handle success, show a dialog or navigate to another page
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Form submitted successfully'),
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
    } catch (e) {
      // Handle error
      print('Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to submit form'),
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
  }
}
