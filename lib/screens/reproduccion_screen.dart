import 'package:flutter/material.dart';

class ReproduccionScreen extends StatelessWidget {
  const ReproduccionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reproductor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.play_circle_outline, size: 100, color: Colors.blue), 
            SizedBox(height: 20),
            Text('Ejemplo de reproductor', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
