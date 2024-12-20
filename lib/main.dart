import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/listado_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CineMasterApp());
}

class CineMasterApp extends StatefulWidget {
  const CineMasterApp({Key? key}) : super(key: key);

  @override
  _EstadoCineMasterApp createState() => _EstadoCineMasterApp();
}

class _EstadoCineMasterApp extends State<CineMasterApp> {
  ThemeMode _modoTema = ThemeMode.dark; //MODO OSCURO VIENE ACTIVADO POR DEFECTO

  void _cambiarTema() {
    setState(() {
      _modoTema =
          _modoTema == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CineMaster',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black), //SE SETEA EL COLOR DEL TEXTO
          bodyMedium: TextStyle(color: Colors.black87), 
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      themeMode: _modoTema,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('CineMaster'),
              actions: [
                IconButton(
                  icon: Icon(_modoTema == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode), //ICONOS
                  onPressed: _cambiarTema,
                ),
              ],
            ),
            body: snapshot.hasData
                ? const ListadoScreen() // SI EL USUARIO ESTÁ AUTENTICADO, MUESTRA EL LISTADO
                : LoginScreen(), // RETORNA A LOGIN SI NO ESTÁ AUTENTICADO
          );
        },
      ),
    );
  }
}
