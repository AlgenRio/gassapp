import 'package:flutter/material.dart';

//class ShopOwnerRegistrationPage extends StatelessWidget {
 // @override
 // Widget build(BuildContext context) {
  //  return Scaffold(
    //  appBar: AppBar(
     //   title: Text('Shop Owner Registration'),
    //  ),
     // body: Center(
    //    child: Text('Shop Owner Registration Page Content'),
   //   ),
 //   );
 // }
//}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test/gasshop.dart';
import 'package:test/home.dart';
import 'package:test/gasshop.dart';
import 'package:test/main.dart';
import 'package:test/Gasregister.dart';
import 'package:http/http.dart' as http;
import 'package:test/gasindex.dart';

class gasOwnerRegistrationPage extends StatefulWidget {
  const gasOwnerRegistrationPage({super.key});
  @override
  State<gasOwnerRegistrationPage> createState() => _RegisterState();
}

class _RegisterState extends State<gasOwnerRegistrationPage> {
  String url = 'http://localhost/Phinma/user1.php';

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to check password strength
  bool isPasswordStrong(String password) {
    // Password should contain at least one uppercase letter, one lowercase letter, and one number.
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).+$');
    return regex.hasMatch(password);
  }

  Future<void> register() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill in all fields!'),
      ));
      return;
    }

    if (!isPasswordStrong(password)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password should contain at least one uppercase letter, one lowercase letter, and one number.'),
      ));
      return;
    }

    Map<String, String> jsonData = {
      'fullname': _fullnameController.text,
      'username': _usernameController.text,
      'password': _passwordController.text,
    };
    Map<String, String> requestBody = {
      'operation': 'signup',
      'json': jsonEncode(jsonData),
    };
    var response = await http.post(Uri.parse(url), body: requestBody);
    if (response.body != '0') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => shopIndex(username: '',)),
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registered Successfully'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 53, 109, 221), Color.fromARGB(255, 236, 4, 4),  Color.fromARGB(255, 240, 210, 12)!],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              'REGISTER Gas OWNERS',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _fullnameController,
              decoration: InputDecoration(
                labelText: 'Fullname',
                hintText: 'Enter your Full name',
                suffixIcon: const Icon(Icons.check),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your Username',
                prefixIcon: const Icon(Icons.person),
                suffixIcon: const Icon(Icons.check),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your Password',
                prefixIcon: const Icon(Icons.password),
                suffixIcon: const Icon(Icons.visibility_off),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40.0,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  register();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.yellow[200]!,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text('Signup'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Add the button for shop owners registration here
         SizedBox(
              height: 40.0,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the ShopOwnerLoginPage
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => gasOwnerLoginPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.yellow[200]!,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text('Login as Shop Owner'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
