import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test/AboutPage.dart';
import 'package:test/EditAccountPage.dart';
import 'package:test/main.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(username: 'JohnDoe'),
  ));
}

class HomeScreen extends StatefulWidget {
  final String username;

  HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  GoogleMapController? mapController;
  Position? currentPosition;
  Set<Marker> _markers = {};

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<void> _handleLogout(BuildContext context) async {
    bool confirmLogout = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                confirmLogout = true;
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmLogout) {
    // Perform the logout action here, such as clearing user credentials or tokens.
    // After logging out, you can navigate the user to the login screen or any other appropriate screen.
    // For example, you can navigate back to the login screen:
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => HomePage(), // Replace with your login screen widget
      ),
      (route) => false, // This prevents the user from going back to the previous screen.
    );
  }
}

  Future<void> _showUserLocation(BuildContext context) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        currentPosition = position;
      });

      if (currentPosition != null) {
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                currentPosition!.latitude,
                currentPosition!.longitude,
              ),
              zoom: 15.0,
            ),
          ),
        );

        _markers.add(
          Marker(
            markerId: MarkerId('current_location'),
            position: LatLng(
              currentPosition!.latitude,
              currentPosition!.longitude,
            ),
            infoWindow: InfoWindow(
              title: 'Your Location',
            ),
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _showUserLocation(context); // Show the user's location when the app starts
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double textSize = screenWidth > 600 ? 24.0 : 18.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: _currentIndex == 0
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'Good day and Welcome, ${widget.username}!',
                      style: TextStyle(
                        fontSize: textSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 200,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ),
                      items: [
                        Image.network('images/gas3.jpg'),
                        Image.network('images/gasoline1.jpeg'),
                        Image.network('images/petron1.jpg'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Nearby Gasoline APP',
                      style: TextStyle(
                        fontSize: textSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    currentPosition != null
                        ? 'Your Current Location: ${currentPosition?.latitude}, ${currentPosition?.longitude}'
                        : 'Location not available',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  CardSection(),
                ],
              ),
            )
          : _currentIndex == 1
              ? LocationMapScreen()
              : EditAccountPage(username: widget.username),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow[800]!, Colors.yellow[600]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  ' ${widget.username}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(''),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Location'),
                onTap: () {
                  _showUserLocation(context);
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditAccountPage(
                        username: widget.username,
                      ),
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Account'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  // Navigate to AboutPage
                },
              ),
              ListTile(
                leading: Icon(Icons.feedback),
                title: Text('Send Feedback'),
                onTap: () {
                  // Add code to send feedback here
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  _handleLogout(context);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Find gas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Edit Account',
          ),
        ],
      ),
    );
  }
}

class LocationMapScreen extends StatefulWidget {
  @override
  _LocationMapScreenState createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  GoogleMapController? mapController;
  Position? currentPosition;
  Set<Marker> _markers = {};

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        currentPosition = position;
      });

      if (currentPosition != null) {
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                currentPosition!.latitude,
                currentPosition!.longitude,
              ),
              zoom: 15.0,
            ),
          ),
        );

        _markers.add(
          Marker(
            markerId: MarkerId('current_location'),
            position: LatLng(
              currentPosition!.latitude,
              currentPosition!.longitude,
            ),
            infoWindow: InfoWindow(
              title: 'Your Location',
            ),
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _onMapCreated(controller);
        },
        markers: _markers,
      ),
    );
  }
}

class EditAccountPage extends StatefulWidget {
  final String username;

  EditAccountPage({Key? key, required this.username}) : super(key: key);

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateAccountDetails() {
    String newUsername = _usernameController.text;
    String newPassword = _passwordController.text;

    // Implement logic to update the user's account details here
    // Update the username and password as needed

    // After updating, you can navigate back to the previous screen
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    // Initialize the username field with the current username
    _usernameController.text = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'New Username',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateAccountDetails,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Search Result 1'),
          onTap: () {
            // Handle the selected suggestion
          },
        ),
        ListTile(
          title: Text('Search Result 2'),
          onTap: () {
            // Handle the selected suggestion
          },
        ),
      ],
    );
  }
}

class CardSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CardItem(
              image: 'images/gas3.jpg',
              text: 'Card 1 Text',
            ),
            CardItem(
              image: 'images/petron1.jpg',
              text: 'Card 2 Text',
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CardItem(
              image: 'images/gasoline1.jpeg',
              text: 'Card 3 Text',
            ),
            CardItem(
              image: 'images/gasoline1.jpeg',
              text: 'Card 4 Text',
            ),
          ],
        ),
      ],
    );
  }
}

class CardItem extends StatelessWidget {
  final String image;
  final String text;

  CardItem({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(image, height: 100.0, width: 100.0),
          Text(text),
        ],
      ),
    );
  }
}