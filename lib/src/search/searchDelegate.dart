import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculas.dart';
import 'package:peliculas/src/providers/peliculasProvider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';

/* final peliculas = [
    'Iron man',
    'Harry',
    'Spartacus',
    'El lobo',
    'Avengers',
    'Mortal Kombat',
  ];

  final peliculasRecientes = [
    'El lobo',
    'Avengers',
  ]; */

  final peliculasProvider = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        width: 200.0,
        height: 200.0,
        color: Colors.brown,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPeliculas(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

/*@override
  Widget buildSuggestions(BuildContext context) {
    final listaSugeridas = query.isEmpty
        ? peliculasRecientes
        : peliculas
            .where((p) => p.toLowerCase().startsWith(
                  query.toLowerCase(),
                ))
            .toList();

    return ListView.builder(
      itemCount: listaSugeridas.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugeridas[i]),
          onTap: () {
            seleccion = listaSugeridas[i];
            showResults(context);
          },
        );
      },
    );
  } */
}
