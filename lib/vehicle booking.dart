import 'package:buspassfinal/MODEL/vechile.dart';
import 'package:buspassfinal/SERVICE/vechile.dart';
import 'package:flutter/material.dart';

class VehicleBooking extends StatefulWidget {
  const VehicleBooking({Key? key}) : super(key: key);

  @override
  State<VehicleBooking> createState() => _VehicleBookingState();
}

class _VehicleBookingState extends State<VehicleBooking> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final VehicleService _vehicleService = VehicleService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _empidController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _hodNameController = TextEditingController();
  final TextEditingController _hodEmailController = TextEditingController();
  final TextEditingController _adminNameController = TextEditingController();
  final TextEditingController _adminEmailController = TextEditingController();

  void _submitVehicleRequest() async {
    final request = VehicleRequest(
      name: _nameController.text,
      empid: _empidController.text,
      reason: _reasonController.text,
      type: _typeController.text,
      capacity: int.tryParse(_capacityController.text) ?? 0,
      hodName: _hodNameController.text,
      hodEmail: _hodEmailController.text,
      adminName: _adminNameController.text,
      adminEmail: _adminEmailController.text,
    );

    try {
      await _vehicleService.submitVehicleRequest(request);
      _showSuccessDialog();
    } catch (error) {
      _showSnackbar('Failed to submit form: $error');
    }
  }

  void _showSnackbar(String message) {
    if (_scaffoldKey.currentState != null &&
        _scaffoldKey.currentContext != null &&
        _scaffoldKey.currentState!.mounted) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Form submitted successfully'),
          actions: <Widget>[
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Vehicle Booking'),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('Name', _nameController, Icons.person),
              _buildTextField('Employee ID', _empidController, Icons.work),
              _buildTextField('Reason', _reasonController, Icons.info),
              _buildTextField('Type of Vehicle', _typeController, Icons.directions_car),
              _buildTextField('Capacity', _capacityController, Icons.people_alt,
                  keyboardType: TextInputType.number),
              _buildTextField('HOD Name', _hodNameController, Icons.person_outline),
              _buildTextField('HOD Email', _hodEmailController, Icons.email,
                  keyboardType: TextInputType.emailAddress),
              _buildTextField('Admin Name', _adminNameController, Icons.person_outline),
              _buildTextField('Admin Email', _adminEmailController, Icons.email,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitVehicleRequest,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller, IconData? iconData,
      {TextInputType keyboardType = TextInputType.text}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          prefixIcon: iconData != null ? Icon(iconData, color: Colors.white) : null,
          labelStyle: const TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
