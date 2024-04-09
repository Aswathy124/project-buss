import 'package:buspassfinal/MODEL/buspass.dart';
import 'package:flutter/material.dart';
import 'package:buspassfinal/SERVICE/buspass.dart';
import 'package:buspassfinal/ViewHostler.dart';

class BusPass extends StatefulWidget {
  const BusPass({Key? key}) : super(key: key);

  @override
  State<BusPass> createState() => _BusPassState();
}

class _BusPassState extends State<BusPass> {
  final BusPassService _busPassService = BusPassService();

  String _selectedFrom = 'Fisat';
  String _selectedTo = 'Fisat';
  int _selectedPasses = 1;
  DateTime _selectedDate = DateTime.now();

  String _name = '';
  String _department = '';
  String _admissionNo = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.directions_bus,
                            size: 100,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TAKE YOUR',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'BUS PASS',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      _buildFieldContainer(
                        'Name',
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _name = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      _buildFieldContainer(
                        'Department',
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _department = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your department';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter your department',
                            prefixIcon: Icon(Icons.business),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      _buildFieldContainer(
                        'Admission No',
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _admissionNo = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your admission number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter your admission number',
                            prefixIcon: Icon(Icons.confirmation_number),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      _buildFieldContainer(
                        'From',
                        DropdownButtonFormField<String>(
                          value: _selectedFrom,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedFrom = newValue!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select from location';
                            }
                            return null;
                          },
                          items: <String>['Fisat', 'Thrissur']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.location_on),
                          ),
                        ),
                      ),
                      _buildFieldContainer(
                        'To',
                        DropdownButtonFormField<String>(
                          value: _selectedTo,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedTo = newValue!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select to location';
                            }
                            return null;
                          },
                          items: <String>['Fisat', 'Thrissur']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.location_on),
                          ),
                        ),
                      ),
                      _buildFieldContainer(
                        'Number of Passes',
                        DropdownButtonFormField<int>(
                          value: _selectedPasses,
                          onChanged: (int? newValue) {
                            setState(() {
                              _selectedPasses = newValue!;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select number of passes';
                            }
                            return null;
                          },
                          items: List.generate(6, (index) => index + 1)
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.confirmation_number),
                          ),
                        ),
                      ),
                      _buildFieldContainer(
                        'Date',
                        TextButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 5),
                              Text(
                                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldContainer(String labelText, Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          child,
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final busPass = BusPassModel(
        name: _name,
        department: _department,
        admissionNo: _admissionNo,
        from: _selectedFrom,
        to: _selectedTo,
        numberOfPasses: _selectedPasses,
        date: _selectedDate,
      );
      try {
        await _busPassService.submitBusPass(busPass);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bus pass submitted successfully!'),
            duration: Duration(seconds: 3),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit bus pass. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
      }

      // Get current date
      DateTime currentDate = DateTime.now();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewHostler(busPass: busPass, currentDate: currentDate),
        ),
      );
    }
  }
}
