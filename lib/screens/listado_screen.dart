import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'reproduccion_screen.dart';
import 'login_screen.dart';

class ListadoScreen extends StatefulWidget {
  const ListadoScreen({Key? key}) : super(key: key);

  @override
  ListadoScreenState createState() => ListadoScreenState();
}

class ListadoScreenState extends State<ListadoScreen> {
  List<Map<String, dynamic>> categorias = [];

  @override
  void initState() {
    super.initState();
    cargarCategoriasDesdeFirebase();
  }

  Future<void> cargarCategoriasDesdeFirebase() async {
    try {
      final DatabaseReference dbRef =
          FirebaseDatabase.instance.ref('categorias');
      final DataSnapshot snapshot = await dbRef.get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        setState(() {
          categorias = data.entries.map((entry) {
            return {
              "nombre": entry.key,
              "peliculas": List<Map<String, dynamic>>.from(
                (entry.value["peliculas"] as List)
                    .map((e) => Map<String, dynamic>.from(e)),
              ),
            };
          }).toList();
        });
      } else {
        mostrarMensaje('No hay datos para mostrar');
      }
    } catch (e) {
      mostrarMensaje('Error: $e');
    }
  }

  void mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }

  Future<void> cerrarSesion(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas Disponibles'),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => cerrarSesion(context)),
        ],
      ),
      body: categorias.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: categorias
                  .map((categoria) => construirCategoria(categoria))
                  .toList(),
            ),
    );
  }

  Widget construirCategoria(Map<String, dynamic> categoria) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            categoria["nombre"],
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
        ),
        Column(
          children: List<Widget>.from(
            categoria["peliculas"]
                .map((pelicula) => construirTarjeta(pelicula)),
          ),
        ),
      ],
    );
  }

  Widget construirTarjeta(Map<String, dynamic> pelicula) {
  return Card(
    child: ListTile(
      leading: Image.network(
        pelicula["portada"],
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(pelicula["titulo"]),
      subtitle: Text(pelicula["genero"]),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ReproduccionScreen(megaUrl: pelicula["megaUrl"]),
          ),
        );
      },
    ),
  );
}

}
