import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'reproduccion_screen.dart';

class ListadoScreen extends StatefulWidget {
  const ListadoScreen({Key? key}) : super(key: key);

  @override
  ListadoScreenState createState() => ListadoScreenState();
}

class ListadoScreenState extends State<ListadoScreen> {
  List<dynamic> categorias = [];

  @override
  //INICIALIZA LA CARGA DE LOS DATOS DE LAS PELICULAS PROVENIENTES DEL JSON
  void initState() {
    super.initState();
    cargarPeliculas();
  }


// SE USA rootBundle.loadString PARA LEER EL JSON,  json.decode PARA DECODIFICAR 
//SE USA SET STATE PARA ACTUALIZAR EL ESTADO DEL WIDGET
Future<void> cargarPeliculas() async {
  final String response = await rootBundle.loadString('assets/peliculas.json');
  final data = json.decode(response);
  setState(() {
    categorias = data["categorias"];
  });
}

  ////////////E M P I E Z A    A     C O N S T R U I R     E L    W I D G E T////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Películas Disponibles')),
      body: categorias.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: categorias.map((categoria) => buildCategoria(categoria, context)).toList(),
            ),
    );
  }

  //C A R G A    D E    U N A    C A T E G O R I A///
  Widget buildCategoria(Map<String, dynamic> categoria, BuildContext context) {
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
              color: Colors.deepPurple,
            ),
          ),
        ),
        Column(
          children: List<Widget>.from(
            categoria["peliculas"].map((pelicula) => buildTarjeta(pelicula, context)),
          ),
        ),
      ],
    );
  }

  //C A R G A    D E    U N A    T A R J E T A///
  Widget buildTarjeta(Map<String, dynamic> pelicula, BuildContext context) {
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
            MaterialPageRoute(builder: (context) => const ReproduccionScreen()),
          );
        },
      ),
    );
  }
}
