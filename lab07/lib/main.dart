import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page1(),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Fondo azul para la página principal
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra los botones
          crossAxisAlignment: CrossAxisAlignment.center, // Alinea los botones al centro
          children: [
            ElevatedButton(
              child: Text("P1"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BluePage()),
                );
              },
            ),
            SizedBox(height: 20), // Separación entre los botones
            ElevatedButton(
              child: Text("P2"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RedPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BluePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Blue Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Regresar a la página inicial"),
          onPressed: () {
            Navigator.pop(context);  // Regresa a la página inicial (Page1)
          },
        ),
      ),
    );
  }
}

class RedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('Red Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Regresar a la página inicial"),
          onPressed: () {
            Navigator.pop(context);  // Regresa a la página inicial (Page1)
          },
        ),
      ),
    );
  }
}
