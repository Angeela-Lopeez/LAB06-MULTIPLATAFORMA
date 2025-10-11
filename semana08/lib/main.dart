import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  cardTheme: const CardThemeData(
    elevation: 2,
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(fontWeight: FontWeight.bold),
  ),
);

class AppData {
  static String? nombre;
  static String? ocupacion;
  static String? correo;
  static int?   edad;

  static final List<Map<String, String>> tareas = [
    {'titulo': 'Trabajo 1', 'prioridad': 'Alta',   'img': 'https://picsum.photos/seed/t1/80'},
    {'titulo': 'Trabajo 2', 'prioridad': 'Normal', 'img': 'https://picsum.photos/seed/t2/80'},
    {'titulo': 'Acerreo',   'prioridad': 'Baja',   'img': 'https://picsum.photos/seed/t3/80'},
    {'titulo': 'Revisión',  'prioridad': 'Alta',   'img': 'https://picsum.photos/seed/t4/80'},
  ];
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Tareas',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/':       (context) => const GestorTareasPage(),
        '/menu':   (context) => const MenuPage(),
        '/profile':(context) => const RegistroUsuarioPage(),
        '/tareas': (context) => const RegistroTareasPage(),
      },
    );
  }
}

/// ---------------PANTALLA 1: GESTOR DE TAREAS --------------------------------
class GestorTareasPage extends StatelessWidget {
  const GestorTareasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Text(
                'Gestor de\nTareas',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushReplacementNamed(context, '/menu'),
                icon: const Icon(Icons.login),
                label: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// --------- PANTALLA 2: MENÚ --------------
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'titulo': 'Home',    'ruta': 'home'},
      {'titulo': 'Profile', 'ruta': '/profile'},
      {'titulo': 'Tareas',  'ruta': '/tareas'},
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('MENÚ')),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final it = items[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.menu_book),
                trailing: const Icon(Icons.chevron_right),
                title: Text(it['titulo']!),
                onTap: () {
                  if (it['ruta'] == 'home') {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (route) => false,
                    );
                  } else {
                    Navigator.pushNamed(context, it['ruta']!);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

/// ----------- PANTALLA 3: REGISTRO DE USUARIO ----------------------
class RegistroUsuarioPage extends StatefulWidget {
  const RegistroUsuarioPage({super.key});

  @override
  State<RegistroUsuarioPage> createState() => _RegistroUsuarioPageState();
}

class _RegistroUsuarioPageState extends State<RegistroUsuarioPage> {
  final TextEditingController _nombre    = TextEditingController(text: AppData.nombre);
  final TextEditingController _ocupacion = TextEditingController(text: AppData.ocupacion);
  final TextEditingController _correo    = TextEditingController(text: AppData.correo);
  final TextEditingController _edad      = TextEditingController(text: AppData.edad?.toString() ?? '');

  String? _validarCorreo(String value) {
    if (value.isEmpty) return 'Ingresa un correo';
    if (!value.contains('@') || !value.contains('.')) return 'Correo no válido';
    return null;
  }

  String? _validarEdad(String value) {
    if (value.isEmpty) return 'Ingresa tu edad';
    final n = int.tryParse(value);
    if (n == null || n <= 0 || n > 120) return 'Edad no válida';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final hasUser = (AppData.nombre ?? '').isNotEmpty;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registro de Usuario'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const SizedBox(height: 8),
              TextField(
                controller: _nombre,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _ocupacion,
                decoration: const InputDecoration(
                  labelText: 'Ocupación',
                  prefixIcon: Icon(Icons.work),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _correo,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _edad,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  prefixIcon: Icon(Icons.cake),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  final correo = _correo.text.trim();
                  final edadTxt = _edad.text.trim();

                  final correoError = _validarCorreo(correo);
                  if (correoError != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(correoError)));
                    return;
                  }
                  final edadError = _validarEdad(edadTxt);
                  if (edadError != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(edadError)));
                    return;
                  }

                  AppData.nombre    = _nombre.text.trim();
                  AppData.ocupacion = _ocupacion.text.trim();
                  AppData.correo    = correo;
                  AppData.edad      = int.tryParse(edadTxt);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Datos guardados')),
                  );
                  Navigator.pop(context); 
                },
                icon: const Icon(Icons.save),
                label: const Text('Continuar'),
              ),
              const SizedBox(height: 16),
              if (hasUser || (AppData.correo ?? '').isNotEmpty || (AppData.edad ?? 0) > 0)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.person, color: Colors.green),
                    title: Text((AppData.nombre ?? '').isEmpty ? 'Usuario' : AppData.nombre!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text((AppData.ocupacion ?? '').isEmpty ? 'Sin ocupación' : AppData.ocupacion!),
                        if ((AppData.correo ?? '').isNotEmpty) Text(AppData.correo!),
                        if ((AppData.edad ?? 0) > 0) Text('Edad: ${AppData.edad} años'),
                      ],
                    ),
                    trailing: const Icon(Icons.check_circle, color: Colors.green),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ------------- PANTALLA 4: REGISTRO DE TAREAS ---------------------------------
class RegistroTareasPage extends StatefulWidget {
  const RegistroTareasPage({super.key});

  @override
  State<RegistroTareasPage> createState() => _RegistroTareasPageState();
}

class _RegistroTareasPageState extends State<RegistroTareasPage> {
  final List<String> prioridades = ['Todas', 'Alta', 'Normal', 'Baja'];
  String filtro = 'Todas';

  Color _colorPrioridad(String p) {
    switch (p) {
      case 'Alta':  return Colors.red;
      case 'Baja':  return Colors.green;
      default:      return Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    final visibles = AppData.tareas.where((t) {
      if (filtro == 'Todas') return true;
      return t['prioridad'] == filtro;
    }).toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registro de Tareas'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 180,
                  child: DropdownButtonFormField<String>(
                    value: filtro,
                    items: prioridades
                        .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => filtro = val);
                      }
                    },
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Prioridad',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: visibles.length,
                  itemBuilder: (context, index) {
                    final t = visibles[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(t['img']!),
                        ),
                        title: Text(t['titulo']!),
                        subtitle: Text('Prioridad: ${t['prioridad']}'),
                        trailing: Text(
                          t['prioridad']!,
                          style: TextStyle(
                            color: _colorPrioridad(t['prioridad']!),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => _DetalleTarea(t: t),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------- DETALLE DE TAREA -------------------------
class _DetalleTarea extends StatelessWidget {
  final Map<String, String> t;
  const _DetalleTarea({required this.t});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(t['img']!),
              ),
              const SizedBox(width: 12),
              Text(
                t['titulo']!,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Prioridad: ${t['prioridad']}'),
          const SizedBox(height: 8),
          const Text(
            'Detalle: esta es una descripción breve de la tarea. '
            'Puedes ampliar con fecha, responsable o notas.',
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ),
        ],
      ),
    );
  }
}

