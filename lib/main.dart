import 'package:flutter/material.dart';

import 'package:peliculas/src/pages/home.dart';
import 'package:peliculas/src/pages/peliculaDetalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'detalle': (context) => PeliculaDetalle(),
      },
    );
  }
}
