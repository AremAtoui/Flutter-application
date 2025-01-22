import 'package:flutter/material.dart';
import 'commandes_provider.dart';
import 'package:provider/provider.dart';

class CommandesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final commandesProvider = Provider.of<CommandesProvider>(context);
    double totalPrix = commandesProvider.calculerPrixTotal();

    return Scaffold(
      appBar: AppBar(title: Text("Orders")),
      body: commandesProvider.commandes.isEmpty
          ? Center(child: Text("No orders at the moment."))
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Total Price:\$${totalPrix.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: commandesProvider.commandes.length,
                    itemBuilder: (context, index) {
                      final commande = commandesProvider.commandes[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(commande.title),
                          subtitle: Text(commande.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(commande.price),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Appel à la méthode de suppression
                                  commandesProvider.supprimerCommande(index);
                                },
                              ),
                            ],
                          ),
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
