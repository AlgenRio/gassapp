import 'dart:convert';
import 'package:test/gasshop.dart';
import 'package:test/home.dart';
import 'package:test/gasshop.dart';
import 'package:test/mainpage.dart';
import 'package:test/register.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'admin.dart';

void main() => runApp(const GasApp());

class GasApp extends StatelessWidget {
  const GasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = 'http://localhost/Phinma/user.php';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordObscured = true; // State variable for password visibility

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
  var jsonResponse = jsonDecode(response.body);
  var userlevel = jsonResponse['userlevel'];
  
  if (response.body != '0') {
    if (userlevel == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Mainpage(username: username),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomeScreen(username: username),
        ),
      );
    }
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
                colors: [Color.fromARGB(255, 53, 109, 221), Color.fromARGB(255, 236, 4, 4),  Color.fromARGB(255, 240, 210, 12)],
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
  elevation: 0,
  toolbarHeight: 150,
  shape: const ContinuousRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
  ),
                  title: Row(
                    children: [
                      Image.network(
                        'images/p.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
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
                              color: Colors.black,
                            ),
                            hintText: 'Input Username',
                            prefixIcon: Icon(Icons.person),
                            suffixIcon: Icon(Icons.check),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _passwordObscured,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            hintText: 'Input Password',
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordObscured =
                                      !_passwordObscured; // Toggle password visibility
                                });
                              },
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
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
                              primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 82, 155, 239),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
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
                  onPrimary: Color.fromARGB(255, 102, 203, 234)!,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text('Login Gas Owner'),
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
