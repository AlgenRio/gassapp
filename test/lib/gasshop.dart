import 'dart:convert';
import 'package:test/gasindex.dart';
import 'package:test/home.dart';
import 'package:test/mainpage.dart';
import 'package:test/register.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:test/gasindex.dart';

void main() => runApp(const GasApp());

class GasApp extends StatelessWidget {
  const GasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: gasOwnerLoginPage(),
    );
  }
}

class gasOwnerLoginPage extends StatefulWidget {
  const gasOwnerLoginPage({super.key});

  @override
  State<gasOwnerLoginPage> createState() => _HomePageState();
}

class _HomePageState extends State<gasOwnerLoginPage> {
  String url = 'http://localhost/Phinma/user1.php';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter username and password!'),
      ));
      return;
    }

    Map<String, String> jsonData = {
      'username': _usernameController.text,
      'password': _passwordController.text,
    };

    Map<String, String> requestBody = {
      'operation': 'login',
      'json': jsonEncode(jsonData),
    };

    var response = await http.post(Uri.parse(url), body: requestBody);

    if (response.body != '0') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => shopIndex(username: '',)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid Username or Password, Please try again!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 53, 109, 221), Color.fromARGB(255, 236, 4, 4),  Color.fromARGB(255, 240, 210, 12)], // Change gradient colors
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 18.0, left: 19),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0, // Remove the shadow
                  toolbarHeight: 150, // Adjust the height as needed
                  title: Row(
                    children: [
                      Image.network(
                        'images/p.png', // Replace with your image URL
                        width: 100, // Adjust the width as needed
                        height: 100, // Adjust the height as needed
                      ),
                      const SizedBox(width: 10), // Add spacing between the image and text
                      Text(
                        'Gas Owner',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black, // Change text color to black
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Change label color to black
                            ),
                            hintText: 'Input Username',
                            prefixIcon: Icon(Icons.person),
                            suffixIcon: Icon(Icons.check),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black, // Change border color to black
                              ),
                            ),
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
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Change label color to black
                            ),
                            hintText: 'Input Password',
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: Icon(Icons.visibility_off),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black, // Change border color to black
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 40.0,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black, // Change button color to black
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Text(
                              'Login Gasowner',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 76, 112, 210), // Change button text color to yellow
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: ((context) => const Register())),
                              );
                            },
                            child: Center(
      child: Text(
        'Create Account',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
