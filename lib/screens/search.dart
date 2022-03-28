import 'dart:async';
import 'package:flutter/material.dart';
import '../models/repo.dart';
import '../services/repo_fetch.dart';
import 'details.dart';

import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  late Future<Repository> futureAlbum;

  @override
  void initState() {
    super.initState();
    Fetch f = Fetch();
    futureAlbum = f.fetchRepo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Explorer',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.purple, Colors.blue.shade900])),
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<Repository>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: Row(children: [
                            Flexible(
                                child: Center(
                                    child: Text('GitHub Explorer',
                                        style: GoogleFonts.cabin(
                                            fontSize: 40,
                                            color: Colors.white)))),
                          ])),
                      TextFormField(
                        controller: _controller,
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 25),
                          hintText: 'Type user/repository name',
                          hintStyle: GoogleFonts.cabin(color: Colors.grey),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.laptop),
                          prefixIconConstraints:
                              const BoxConstraints(minWidth: 75),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurple,
                                onPrimary: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {
                              setState(() {
                                Fetch f = Fetch();
                                futureAlbum =
                                    f.refreshRepo(_controller.text.toString());
                              });
                            },
                            child: Text('Search Repo',
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.white)),
                          )),
                      Card(
                          color: Colors.purple,
                          child: ListTile(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => Details(
                                          avatar: snapshot.data!.avatar,
                                          name: snapshot.data!.name,
                                          description:
                                              snapshot.data!.description,
                                          stars: snapshot.data!.stars,
                                          forks: snapshot.data!.forks,
                                          issues: snapshot.data!.issues,
                                          watchers: snapshot.data!.watchers,
                                          url: snapshot.data!.url,
                                        )),
                                  ))
                            },
                            leading: Image.network(snapshot.data!.avatar),
                            title: Text(
                              snapshot.data!.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              snapshot.data!.description,
                              style: const TextStyle(color: Colors.white),
                            ),
                            isThreeLine: true,
                          ))
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
