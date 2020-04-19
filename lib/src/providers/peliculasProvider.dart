import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/actores.dart';
import 'package:peliculas/src/models/peliculas.dart';

class PeliculasProvider {
  String _apiKey = 'eb56388c884febb3f6f7e59588202552';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 1;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _streamController = StreamController<List<Pelicula>>.broadcast();
  Function(List<Pelicula>) get popularesSink => _streamController.sink.add;
  Stream<List<Pelicula>> get popularesStream => _streamController.stream;

  void dispose() => _streamController.close();

  Future<List<Pelicula>> _getModeledData(Uri url) async {
    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    final peliculas = Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }

  Uri getUriWithParams(String endPoint) {
    return Uri.https(
      _url,
      endPoint,
      {
        'api_key': _apiKey,
        'language': _language,
        'page': _popularesPage.toString(),
      },
    );
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(
      _url,
      '/3/movie/now_playing',
      {
        'api_key': _apiKey,
        'language': _language,
      },
    );
    return await _getModeledData(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;
    _popularesPage++;

    final url = getUriWithParams('/3/movie/popular');
    final response = await _getModeledData(url);
    _populares.addAll(response);
    popularesSink(_populares);

    _cargando = false;
    return [];
  }

  Future<List<Actor>> getCasting(String movieId) async {
    final url = getUriWithParams('/3/movie/$movieId/credits');
    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    final casting = Cast.fromJsonList(decodeData['cast']);

    return casting.items;
  }

  Future<List<Pelicula>> buscarPeliculas(String query) async {
    final url = Uri.https(
      _url,
      '/3/search/movie',
      {
        'api_key': _apiKey,
        'language': _language,
        'query': query,
      },
    );
    return await _getModeledData(url);
  }
}
