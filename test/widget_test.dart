import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart'; // Importation du fichier principal

void main() {
  testWidgets('DeliveryApp increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DeliveryApp()); // Remplacez MyApp par DeliveryApp

    // Verify that our initial message appears
    expect(find.text('Bienvenue dans l\'application de livraison!'), findsOneWidget);
    expect(find.text('Détails de Livraison'), findsNothing);

    // Tap the 'Voir Détails de Livraison' button and trigger a frame.
    await tester.tap(find.text('Voir Détails de Livraison'));
    await tester.pump();

    // Verify that the 'Détails de Livraison' page appears
    expect(find.text('Détails de Livraison'), findsOneWidget);
    expect(find.text('Adresse de livraison :'), findsOneWidget);
  });
}
