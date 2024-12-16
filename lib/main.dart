import 'package:flutter/material.dart';
import 'package:sample_demo/server.dart';

import 'checkout_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stripe Checkout Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Center(
          child: ElevatedButton(
            onPressed: () async {
              final checkoutUrl = await Server().createCheckout();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Checkout URL: $checkoutUrl'),
                ),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(checkoutUrl: checkoutUrl),
                ),
              );
            },
            child: Text('Pay!'),
          ),
        ),
      ),
    );
  }
}
