import 'package:github_search_app/models/repo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Fetch {
  Future<Repository> fetchRepo() async {
    final response = await http
        .get(Uri.parse('https://api.github.com/repos/spotify/pedalboard'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Repository.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Not found');
    }
  }

  Future<Repository> refreshRepo(String ownerRepo) async {
    final response = await http.get(
      Uri.parse('https://api.github.com/repos/' + ownerRepo),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Repository.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then return default result
      var notFoundRepo = await http.get(
        Uri.parse('https://api.github.com/repos/spotify/pedalboard'),
      );
      return Repository.fromJson(jsonDecode(notFoundRepo.body));
    }
  }
}
