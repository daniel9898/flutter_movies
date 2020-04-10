import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculas.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(width: 10.0),
              _getposterTitulo(context, pelicula),
              _getDescripcion(pelicula),
              _getDescripcion(pelicula),
              _getDescripcion(pelicula),
              _getDescripcion(pelicula),
              _getDescripcion(pelicula),
              _getDescripcion(pelicula),
            ]),
          )
        ],
      ),
    );
  }

  Widget _getposterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsetsDirectional.only(top: 10.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              height: 150.0,
            ),
          ),
          SizedBox(width: 10.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subhead,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDescripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Text(pelicula.overview, textAlign: TextAlign.justify),
    );
  }

  Widget _createAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      expandedHeight: 200.0,
      backgroundColor: Colors.indigoAccent,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(pelicula.getBackgroundImg()),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 150),
        ),
      ),
    );
  }
}
