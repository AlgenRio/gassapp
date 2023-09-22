import 'package:flutter/material.dart';

class EditAccountPage extends StatefulWidget {
  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _validateFields() {
    // Check if any of the fields are empty
    if (_nameController.text.isEmpty ||
        _currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      return false; // Fields are empty
    }
    return true; // All fields have values
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Account'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow[800]!, Colors.yellow[600]!], // Dark yellow gradient
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change Name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'New Name',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Change Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
              ),
            ),
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
            ),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Check if any of the fields are empty
                if (_validateFields()) {
                  // Add logic to update the user's name and password here
                  String newName = _nameController.text;
                  String currentPassword = _currentPasswordController.text;
                  String newPassword = _newPasswordController.text;
                  String confirmPassword = _confirmPasswordController.text;

                  // Validate password change logic here
                  if (newPassword == confirmPassword) {
                    // Passwords match, you can save the new name and password
                    // and perform any necessary actions such as updating the backend server.
                    // Then, you can navigate back to the account page or any other page as needed.
                    Navigator.pop(context);
                  } else {
                    // Passwords don't match, display an error or handle it as needed.
                    // You can also add more validation checks.
                  }
                } else {
                  // Fields are empty, display an error or handle it as needed.
                  // You can show a snackbar or alert dialog to inform the user.
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
