import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class Details extends StatelessWidget {
  const Details(
      {Key? key,
      required this.name,
      required this.description,
      required this.avatar,
      required this.stars,
      required this.forks,
      required this.issues,
      required this.watchers,
      required this.url})
      : super(key: key);

  static MaterialAccentColor bgColor = Colors.purpleAccent;

  final String name;
  final String description;
  final String avatar;
  final int stars;
  final int forks;
  final int issues;
  final int watchers;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Colors.purple, Colors.blue.shade900])),
          child: ListView(
            children: [
              cardBuilder(Colors.purple, Colors.white, 25, 15, name,
                  description, true, Image.network(avatar)),
              cardBuilder(
                Colors.deepPurpleAccent,
                Colors.white,
                25,
                15,
                'Watchers',
                watchers.toString(),
                false,
                const Icon(Icons.remove_red_eye, size: 35),
              ),
              cardBuilder(
                Colors.deepPurpleAccent,
                Colors.white,
                25,
                15,
                'Stars',
                stars.toString(),
                false,
                const Icon(Icons.star, size: 35),
              ),
              cardBuilder(
                Colors.deepPurpleAccent,
                Colors.white,
                25,
                15,
                'Forks',
                forks.toString(),
                false,
                const Icon(
                  Icons.fork_right,
                  size: 35,
                ),
              ),
              cardBuilder(
                Colors.deepPurpleAccent,
                Colors.white,
                25,
                15,
                'Open Issues',
                issues.toString(),
                false,
                const Icon(Icons.report_problem, size: 35),
              ),
              cardBuilder(
                Colors.deepPurpleAccent,
                Colors.white,
                25,
                15,
                'Copy URL',
                url,
                false,
                const Icon(Icons.link, size: 35),
              )
            ],
          ),
        ));
  }

  Card cardBuilder(
    Color bg,
    Color txtColor,
    double titleSize,
    double subSize,
    String title,
    String subtitle,
    bool isThreeLine,
    Widget leading,
  ) {
    return Card(
      color: bg,
      child: ListTile(
        leading: leading,
        title: Text(title,
            style: GoogleFonts.cabin(
                fontSize: titleSize,
                color: txtColor,
                fontWeight: FontWeight.bold)),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.cabin(
              fontSize: subSize,
              color: txtColor,
              fontWeight: FontWeight.normal),
        ),
        isThreeLine: false,
      ),
    );
  }
}
