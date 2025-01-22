import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'commandes_provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commandesProvider = Provider.of<CommandesProvider>(context);


    final List<Commande> menuItems = [
      Commande(
        title: 'Pizza',
        description: 'Delicious cheese pizza',
        price: '\$10.00',
        imagePath: 'assets/images/pizza.jpg',
      ),
      Commande(
        title: 'Burger',
        description: 'Juicy beef burger',
        price: '\$8.00',
        imagePath: 'assets/images/burger.jpeg',
      ),
      Commande(
        title: 'Café',
        description: 'A hot cup of coffee',
        price: '\$2.30',
        imagePath: 'assets/images/café.jpeg',
      ),
      Commande(
    title: 'Salade César',
    description: 'Fresh salad with grilled chicken, lettuce, and Caesar dressing',
    price: '\$7.20',
    imagePath: 'assets/images/Salade César.png',
),
Commande(
    title: 'Poulet rôti',
    description: 'Roast chicken served with vegetables and mashed potatoes',
    price: '\$10.00',
    imagePath: 'assets/images/poulet-roti.png',
),
Commande(
    title: 'Spaghetti Bolognese',
    description: 'Pasta with a rich meat sauce and parmesan cheese',
    price: '\$9.50',
    imagePath: 'assets/images/Spaghetti-Bolognese.png',
),
Commande(
    title: 'Thé',
    description: 'A cup of hot tea',
    price: '\$1.50',
    imagePath: 'assets/images/tea.png',
),
   
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.asset(
                item.imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(item.title),
              subtitle: Text(item.description),
              trailing: Text(
                item.price,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                commandesProvider.ajouterCommande(item);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.title} added to orders!')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
