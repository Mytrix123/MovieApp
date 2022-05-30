import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models.dart';
import 'package:movie_app/shared.dart';

class Services {
  static Future<List<TopMovies>?> fetchBestMovie() async {
    const String url = baseUrl + "Top250Movies/$apiKey";

    List<TopMovies> dataReturn = [];

    try {
      var request = await http.get(
        Uri.parse(url),
      );

      if (request.statusCode == 200) {
        var dataRaw = json.decode(request.body);

        for (var i = 0; i < dataRaw['items'].length; i++) {
          dataReturn.add(TopMovies.fromJson(dataRaw['items'][i]));
        }
      }
    } catch (e) {
      print(e);
    }

    return dataReturn;
  }

  static Future<List<SearchMovie>?> searchMovie({required String query}) async {
    String url = baseUrl + "SearchTitle/$apiKey/$query";

    List<SearchMovie> dataReturn = [];

    try {
      var request = await http.get(
        Uri.parse(url),
      );

      if (request.statusCode == 200) {
        var dataRaw = json.decode(request.body);

        for (var i = 0; i < dataRaw['results'].length; i++) {
          dataReturn.add(SearchMovie.fromJson(dataRaw['results'][i]));
        }
      }
    } catch (e) {
      print(e);
    }

    return dataReturn;
  }

  static Future<List<Reviews>?> reviewsMovie({required String id}) async {
    String url = baseUrl + "Reviews/$apiKey/$id";

    List<Reviews> dataReturn = [];

    // try {
    var request = await http.get(
      Uri.parse(url),
    );

    if (request.statusCode == 200) {
      var dataRaw = json.decode(request.body);

      for (var i = 0; i < dataRaw['items'].length; i++) {
        dataReturn.add(Reviews.fromJson(dataRaw['items'][i]));
      }
    }
    // } catch (e) {
    //   print(e);
    // }

    return dataReturn;
  }
}
