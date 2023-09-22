import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/gasshop.dart';


const apiBaseUrl = 'http://localhost/Phinma/test.php';

Future<void> addGasStationAndItem(String name, double latitude, double longitude, String gasName, double gasPrice) async {
  final url = Uri.parse('$apiBaseUrl?action=addGasStation');

  final response = await http.post(
    url,
    body: {
      'action': 'addGasStation',
      'name': name,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'gasName': gasName, // Use the updated column name
      'gasPrice': gasPrice.toString(), // Use the updated column name
    },
  );

  if (response.statusCode == 200) {
    print('Gas and prices item added successfully');
  } else {
    throw Exception('Failed to add gas item');
  }
}

// Function to retrieve restaurants and menu items
Future<List<Map<String, dynamic>>> getRestaurantsAndMenuItems() async {
  final url = Uri.parse('$apiBaseUrl');

  var http;
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load restaurants');
  }
}

class Product {
  final String name;
  final double price;

  Product({
    required this.name,
    required this.price,
  });
}

class Restaurant {
  final String name;
  final LatLng location;
  final List<Product> menu;

  Restaurant({
    required this.name,
    required this.location,
    required this.menu,
  });
}

class shopIndex extends StatefulWidget {
  final String username;
  shopIndex({Key? key, required this.username}) : super(key: key);

  @override
  _shopindexState createState() => _shopindexState();
}

class _shopindexState extends State<shopIndex> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  List<Restaurant> restaurants = [];

  GoogleMapController? _mapController;
  Set<Marker> _markers = {};



  
//





//
@override
void initState() {
  super.initState();
  if (restaurants.isEmpty) {
    // Initialize a sample restaurant (replace this with user's restaurant data)
    final sampleRestaurant = Restaurant(
      name: 'Shell',
      location: LatLng(	8.47374, 124.69515),
      menu: [],
    );
    restaurants.add(sampleRestaurant);
    _addRestaurantMarker(sampleRestaurant);
  }
}


void addProductToRestaurant() async {
  String name = _productNameController.text;
  double price = double.tryParse(_priceController.text) ?? 0.0;

  if (name.isNotEmpty && price > 0) {
    Restaurant? currentRestaurant = restaurants.isEmpty ? null : restaurants.last;
    if (currentRestaurant == null) {
      currentRestaurant = Restaurant(
        name: 'Gas station ',
        location: LatLng(8.482013,124.63572), //8.482013,124.63572,111m //coc-8.477217, 124.645920
        menu: [],
      );
      restaurants.add(currentRestaurant);
      _addRestaurantMarker(currentRestaurant);
    }

    currentRestaurant.menu.add(Product(name: name, price: price));

    // Send a POST request to your PHP API to save the restaurant and menu item
    final response = await http.post(
      Uri.parse('http://localhost/Phinma/test.php'),
      body: {
        'action': 'addRestaurant',
        'name': currentRestaurant.name,
        'latitude': currentRestaurant.location.latitude.toString(),
        'longitude': currentRestaurant.location.longitude.toString(),
        'gas_name': name,
        'gas_price': price.toString(),
      },
    );

    if (response.statusCode == 200) {
      print(' item added successfully');
    } else {
      print('Failed to add gas  item: ${response.body}');
    }

    _productNameController.clear();
    _priceController.clear();
  }
}


  void _addRestaurantMarker(Restaurant restaurant) {
    final marker = Marker(
      markerId: MarkerId(restaurant.name),
      position: restaurant.location,
      onTap: () {
        _showRestaurantInfo(restaurant);
      },
    );

    setState(() {
      _markers.add(marker);
    });
  }

  void _showRestaurantInfo(Restaurant restaurant) {
    String menuInfo = _buildMenuInfo(restaurant.menu);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(restaurant.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Oil Prices:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(menuInfo),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  String _buildMenuInfo(List<Product> menu) {
    final List<String> menuItems = menu.map((product) {
      return '${product.name}: \$${product.price.toStringAsFixed(2)}';
    }).toList();
    return menuItems.join('\n');
  }

  // Method to show a dialog for adding food items
  Future<void> _showAddFoodItemDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add gas Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _productNameController,
                decoration: InputDecoration(labelText: 'Regular/Special'),
              ),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price '),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                addProductToRestaurant(); // Call the method to add the food item
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Create a drawer widget
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Welcome, ${widget.username}!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () {
            // Implement logout logic here
            Navigator.pop(context); // Close the drawer
            // Add your logout logic here, such as navigating to the login screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => gasOwnerLoginPage(), // Replace 'LoginPage' with your login page widget
              ),
            );
          },
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gasowner ${widget.username}'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Map'),
              Tab(text: 'Add Oil '),
            ],
          ),
        ),
        drawer: _buildDrawer(), // Add the drawer
        body: TabBarView(
          children: [
            Center(
              child: Text('Home Tab Content'),
            ),
            // Map Tab
            Center(
              child: GoogleMap(
                onMapCreated: (controller) {
                  setState(() {
                    _mapController = controller;
                  });
                },
                markers: _markers,
                initialCameraPosition: CameraPosition(
                  target: LatLng(8.482013,124.63572),// Adjust to the actual location
                  zoom: 15.0, // Adjust the zoom level as needed
                ),
              ),
            ),
            // Add Product Tab
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _productNameController,
                      decoration: InputDecoration(labelText: 'Regular/Special'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Price (\$)'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showAddFoodItemDialog(context); // Show the add food item dialog
                    },
                    child: Text('Add oil price'),
                  ),
                  // List of products for the current restaurant
                  if (restaurants.isNotEmpty && restaurants.last.menu.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          'Prices for ${restaurants.last.name}:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: restaurants.isNotEmpty
                              ? restaurants.last.menu.length
                              : 0,
                          itemBuilder: (context, index) {
                            final product =
                                restaurants.isNotEmpty ? restaurants.last.menu[index] : null;
                            return ListTile(
                             
                              title: Text(product?.name ?? ''),
                              subtitle:
                                  Text('\$${product?.price.toStringAsFixed(2) ?? ''}'),
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: shopIndex(username: 'YourUsername'),
  ));
}
