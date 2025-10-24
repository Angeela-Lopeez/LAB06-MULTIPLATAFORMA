import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disney+ Landing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Disney',
            fontSize: 30,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontFamily: 'TitleFont',
            fontSize: 20,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'TextFont',
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Imagen principal con título y botón
          Stack(
            children: [
              Image.network(
                'https://prod-ripcut-delivery.disney-plus.net/v1/variant/disney/5B5F6A1D3FCD2F47C0FC5B928712E34B64C8D4D0A9B78CEB5DB86C1E3B097D3E/scale?width=1200&aspectRatio=1.78&format=jpeg',
                fit: BoxFit.cover,
                height: 400,
                width: double.infinity,
              ),
              Positioned(
                bottom: 50,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Image.asset('assets/images/disney.jpg', height: 60),
                    const SizedBox(height: 10),
                    Text(
                      'Series exclusivas, éxitos del cine y más',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Correo electrónico',
                          filled: true,
                          fillColor: Colors.white12,
                          hintStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      onPressed: () {},
                      child: Text(
                        'SUSCRIBIRME AHORA',
                        style: TextStyle(
                          fontFamily: 'TitleFont',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Sección 2: ESPN y deportes
          Container(
            color: Colors.black,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset('assets/images/startwars.jpg'),
                const SizedBox(height: 15),
                Text(
                  'El deporte de ESPN y los eventos en vivo que te apasionan los encontrarás en el plan Premium de Disney+.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    padding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: () {},
                  child: Text(
                    'SUSCRIBIRME AHORA',
                    style: TextStyle(
                      fontFamily: 'TitleFont',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Sección 3: Planes
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  '¿Qué plan vas a elegir?',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'Podrás modificarlo o cancelarlo cuando quieras.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildPlanCard(
                      context,
                      'PREMIUM',
                      'PEN 68,90/mes',
                      '4K UHD, 4 dispositivos, ESPN',
                    ),
                    const SizedBox(width: 10),
                    buildPlanCard(
                      context,
                      'ESTÁNDAR',
                      'PEN 49,90/mes',
                      'Full HD, 2 dispositivos',
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Sección 4: Recién agregados
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recién agregados',
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 15),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      buildCardImage('assets/images/marvel.jpeg'),
                      buildCardImage('assets/images/pixar.png'),
                      buildCardImage('assets/images/startwars.jpg'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Sección 5: Footer simple
          Container(
            color: Colors.black54,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text('© 2025 Disney+ LATAM. Todos los derechos reservados.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text('Términos de uso | Política de privacidad | Ayuda',
                    style: TextStyle(color: Colors.white54, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlanCard(
      BuildContext context, String title, String price, String desc) {
    return Expanded(
      child: Card(
        color: Colors.blueGrey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              Text(price,
                  style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 16,
                      fontFamily: 'TitleFont')),
              const SizedBox(height: 10),
              Text(desc,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardImage(String path) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(path, fit: BoxFit.cover),
      ),
    );
  }
}
