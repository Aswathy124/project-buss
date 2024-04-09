import 'package:buspassfinal/MODEL/registerday.dart';
import 'package:buspassfinal/ViewDayscholar.dart';
import 'package:flutter/material.dart';

import 'SERVICE/registerday.dart';

class Register extends StatefulWidget {
  const Register({Key? key});



  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _departmentController = TextEditingController();
  final _admissionNoController = TextEditingController();
  final _placeController = TextEditingController();
  final _busNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image1.jpg'), // Add your background image path here
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30.0),
                Text(
                  "Register",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white.withOpacity(0.8),
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _departmentController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please select your department';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Department',
                          prefixIcon: Icon(Icons.business),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _admissionNoController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your admission number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Admission No',
                          prefixIcon: Icon(Icons.confirmation_number),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _placeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your place';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Place',
                          prefixIcon: Icon(Icons.location_on),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _busNoController,
                        decoration: InputDecoration(
                          labelText: 'Bus No',
                          prefixIcon: Icon(Icons.directions_bus),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, show a success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Form submitted successfully'),
                                duration: Duration(seconds: 2), // Adjust the duration as needed
                              ),
                            );
                            // Create a DayScholar object
                            DayScholar dayScholar = DayScholar(
                              name: _nameController.text,
                              department: _departmentController.text,
                              admissionNo: _admissionNoController.text,
                              place: _placeController.text,
                              busNo: _busNoController.text,
                            );

                            try {
                              // Call the service to submit the form data
                              await ApiService.submitDayScholarForm(dayScholar);

                              // Navigate to the next screen after successful submission
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewDayscholar(
                                    name: _nameController.text,
                                    department: _departmentController.text,
                                    admissionNo: _admissionNoController.text,
                                    place: _placeController.text,
                                    busNo: _busNoController.text,
                                  ),
                                ),
                              );
                            } catch (e) {
                              // Handle errors if submission fails
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to submit form'),
                                  duration: Duration(seconds: 2), // Adjust the duration as needed
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text('Register', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _departmentController.dispose();
    _admissionNoController.dispose();
    _placeController.dispose();
    _busNoController.dispose();
    super.dispose();
  }
}
