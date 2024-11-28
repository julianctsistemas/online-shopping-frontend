import 'package:encafeinados/shared/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: const NavigationBarWidget(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido a Online Shopping',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            const Text(
              'Explora productos y categorías fácilmente',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            _buildNavigationCards(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCards(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // Card para productos
      GestureDetector(
        onTap: () {
          context.go('/products'); // Usar context.go para redirigir
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            width: 150,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.shopping_cart, size: 50, color: Colors.blue),
                SizedBox(height: 10),
                Text(
                  'Productos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      // Card para categorías
      GestureDetector(
        onTap: () {
          context.go('/categories'); // Usar context.go para redirigir
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            width: 150,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.category, size: 50, color: Colors.green),
                SizedBox(height: 10),
                Text(
                  'Categorías',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
}