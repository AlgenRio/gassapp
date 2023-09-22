import 'package:flutter/material.dart';
import 'package:test/home.dart';
import 'package:test/main.dart';
import 'package:test/mainpage.dart';
import 'package:test/register.dart';

class NavBar extends StatelessWidget {
  
   final String username;

  const NavBar({Key? key, required this.username}) : super(key: key);
//  Center(
 // child: Text(
 //   'Welcome, ${username}!', // Display the username here
  //  style: TextStyle(
   //   fontSize: textSize,
   //   fontWeight: FontWeight.bold,
  //  ),
 // ),
//),

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
    ' ${username}!', // Display the username here
    style: TextStyle(
     
      fontWeight: FontWeight.bold,
    ),
  ),
            accountEmail: Text('test'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(''),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffb81736),
                Color(0xff281537),
              ]),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home), // Add an icon for the home screen
            title: Text('Home'), // Text for the home screen
            onTap: () {
              Navigator.of(context).pushReplacement( // Navigate to the home screen
                MaterialPageRoute(builder: (context) => HomeScreen(username: '',)), // Replace HomeScreen() with your actual home screen widget
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add_location),
            title: Text('Map'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          Divider(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const HomePage()),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
