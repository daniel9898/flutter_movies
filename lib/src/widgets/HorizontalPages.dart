import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculas.dart';

class HorizontalPages extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;
  final _pageControler = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  HorizontalPages({@required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    _pageControler.addListener(() {
      if (_pageControler.position.pixels >=
          _pageControler.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      height: screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageControler,
        itemCount: peliculas.length,
        itemBuilder: (context, i) => getMovie(context, peliculas[i]),
      ),
    );
  }

  Widget getMovie(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-page';

    final cardMovie = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      child: cardMovie,
      onTap: () => Navigator.pushNamed(context, 'detalle', arguments: pelicula),
    );
  }
}
