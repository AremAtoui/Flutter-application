import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'commandes_provider.dart';
import 'menu_page.dart';
import 'commandes_page.dart';
import 'restaurants_page.dart';

void main() {
  runApp(const DeliveryApp());
}

class DeliveryApp extends StatelessWidget {
  const DeliveryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CommandesProvider(),
      child: const DeliveryAppContent(),
    );
  }
}

class DeliveryAppContent extends StatefulWidget {
  const DeliveryAppContent({Key? key}) : super(key: key);

  @override
  State<DeliveryAppContent> createState() => _DeliveryAppContentState();
}

class _DeliveryAppContentState extends State<DeliveryAppContent> {
  Locale _locale = const Locale('en', '');
  bool _isDarkMode = false;

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('it', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: DeliveryHomePage(
        changeLanguage: _changeLanguage,
        toggleTheme: _toggleTheme,
        isDarkMode: _isDarkMode,
      ),
    );
  }
}

class DeliveryHomePage extends StatelessWidget {
  final Function(Locale) changeLanguage;
  final Function() toggleTheme;
  final bool isDarkMode;

  const DeliveryHomePage({
    Key? key,
    required this.changeLanguage,
    required this.toggleTheme,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: const Color.fromARGB(255, 133, 62, 11)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text('Menu'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MenuPage())),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Orders'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CommandesPage())),
            ),
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: const Text('Restaurants'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RestaurantsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Change Language'),
              onTap: () => _showLanguageDialog(context),
            ),
            SwitchListTile(
              secondary: Icon(Icons.brightness_6),
              title: const Text('Dark Mode'),
              value: isDarkMode,
              onChanged: (value) => toggleTheme(),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to the Delivery App!',
                  style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 75, 8, 8)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuPage()),
                  ),
                  child: const Text('See the Menu'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  changeLanguage(const Locale('en', ''));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Italiano'),
                onTap: () {
                  changeLanguage(const Locale('it', ''));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
