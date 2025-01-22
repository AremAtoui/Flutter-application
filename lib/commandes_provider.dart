import 'package:flutter/material.dart';


class Commande {
  final String title;
  final String description;
  final String imagePath;
  final String price;

  Commande({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.price,
  });
}

class CommandesProvider extends ChangeNotifier {
  final List<Commande> _commandes = [];

  List<Commande> get commandes => _commandes;

  void ajouterCommande(Commande commande) {
    _commandes.add(commande);
    notifyListeners();
  }

  void supprimerCommande(int index) {
    if (index >= 0 && index < _commandes.length) {
      _commandes.removeAt(index);
      notifyListeners();
    }
  }

  void effacerCommandes() {
    _commandes.clear();
    notifyListeners();
  }

  double calculerPrixTotal() {
    double total = 0.0;
    for (var commande in _commandes) {
      total += double.tryParse(
              commande.price.replaceAll('\$', '').replaceAll(',', '')) ??
          0.0;
    }
    return total;
  }
}
