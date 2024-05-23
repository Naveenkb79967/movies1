import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//hi
class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late Future<List<dynamic>> _movieList;

  @override
  void initState() {
    super.initState();
    _movieList = fetchMovieList();
  }

  Future<List<dynamic>> fetchMovieList() async {
    final response = await http.post(
      Uri.parse('https://hoblist.com/api/movieList'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'category': 'movies',
        'language': 'kannada',
        'genre': 'all',
        'sort': 'voting',
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data['result'] as List<dynamic>;
    } else {
      throw Exception('Failed to load movie list');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Movie List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _movieList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: Image.network(
                      movies[index]['poster'] ?? '',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    title: Text(movies[index]['title'] ?? ''),
                    subtitle:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(movies[index]['genre'] ?? '',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(movies[index]['id'] ?? ''),
                        if (movies[index]['director'] != null && movies[index]['director'].isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'Director: ${movies[index]['director'].join(', ')}',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {}
                );
              },
            );
          }
        },
      ),
    );
  }
}
