import 'package:flutter/material.dart';
import 'yelp_service.dart';

class RestaurantsPage extends StatefulWidget {
  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  late YelpService yelpService;
  List<dynamic> restaurants = [];
  String searchQuery = ''; 
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    yelpService = YelpService();
    fetchRestaurants("San Francisco"); 
  
  }

  Future<void> fetchRestaurants(String location) async {
    try {
      final results = await yelpService.searchRestaurants(location); 
      setState(() {
        restaurants = results; 
      });
    } catch (e) {
      print(e); 
    }
  }

  void onSearch() {
    String location = searchController.text.trim();
    if (location.isNotEmpty && location.length >= 3) {
      fetchRestaurants(location); 
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurants')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: 'Enter the first 3 letters of the city',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: onSearch, 
              
                ),
              ],
            ),
          ),
          restaurants.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      final name = restaurant['name'];
                      final address = restaurant['location']['address1'];
                      final imageUrl = restaurant['image_url'] ?? ''; 
                

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: imageUrl.isNotEmpty
                              ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                              : const Icon(Icons.restaurant, size: 50),
                          title: Text(name),
                          subtitle: Text(address),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
