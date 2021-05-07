import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//http://www.omdbapi.com/?i=(imdb movie id goes here)&apikey=6088c3b1

Future<MovieData> fetchMovieData(String id) async {
  final response = await http.get(Uri.parse(
    'https://www.omdbapi.com/?i=$id&apikey=6088c3b1'
  ));

  if (response.statusCode == 200) {
    return MovieData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class MovieData {
  final String title;
  final String released;
  final String poster;
  final String imdbRating;
  final String imdbID;
  final String type;

  MovieData(
      {
        @required this.title,
        @required this.released,
        @required this.poster,
        @required this.imdbRating,
        @required this.imdbID,
        @required this.type,
      });

  factory MovieData.fromJson(Map<String, dynamic> json) {
    return MovieData(
        title: json['Title'],
        released: json['Released'],
        poster: json['Poster'],
        imdbRating: json['imdbRating'],
        imdbID: json['imdbID'],
        type: json['Type'],
    );
  }
}

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatefulWidget{
  MovieApp({Key key}) : super (key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MovieApp>{
  Future<MovieData> futureData1;
  Future<MovieData> futureData2;
  Future<MovieData> futureData3;
  Future<MovieData> futureData4;
  Future<MovieData> futureData5;

  var id = [
    'tt0119217', //Good Will Hunting
    'tt4846340', //Hidden Figures
    'tt0878804', //The Blind Side
    'tt5774002', //Jupiter's Legacy
    'tt2442560', //Peaky Blinders
  ];

  @override
  void initState(){
    super.initState();
    futureData1 = fetchMovieData(id[0]);
    futureData2 = fetchMovieData(id[1]);
    futureData3 = fetchMovieData(id[2]);
    futureData4 = fetchMovieData(id[3]);
    futureData5 = fetchMovieData(id[4]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Movie App"
          ),
          centerTitle: true,
        ),
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("1"),
                  FutureBuilder<MovieData>(
                    future: futureData1,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        return Card(
                          color: Colors.blueAccent,
                          elevation: 10,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {

                                  },
                                  child: Container(
                                    width: 75,
                                    height: 75,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot.data.poster),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 7.0,
                                              color: Colors.black
                                          )
                                        ]
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  return showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(snapshot.data.title),
                                        content:
                                        Text('Rating : ${snapshot.data.imdbRating}\n'
                                            'Released : ${snapshot.data.released}\n'
                                            'IMDB ID : ${snapshot.data.imdbID}\n'
                                            'Type : ${snapshot.data.type}'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                    padding: EdgeInsets.all(25.0),
                                    child: Chip(
                                      label: Text(
                                        snapshot.data.title,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      shadowColor: Colors.blue,
                                      backgroundColor: Colors.green,
                                      elevation: 10,
                                      autofocus: true,
                                    )
                                ),
                              )
                            ],
                          ),
                        );
                        /*return Image.network(
                          snapshot.data.poster,
                          height: 100,
                          width: 100,
                        );*/
                        //return Text("${snapshot.data.title}");
                      }else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FutureBuilder<MovieData>(
                    future: futureData2,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        return Card(
                          color: Colors.blueAccent,
                          elevation: 10,
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  return showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(snapshot.data.title),
                                        content:
                                        Text('Rating : ${snapshot.data.imdbRating}\n'
                                            'Released : ${snapshot.data.released}\n'
                                            'IMDB ID : ${snapshot.data.imdbID}\n'
                                            'Type : ${snapshot.data.type}'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                    padding: EdgeInsets.all(25.0),
                                    child: Chip(
                                      label: Text(
                                        snapshot.data.title,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      shadowColor: Colors.blue,
                                      backgroundColor: Colors.green,
                                      elevation: 10,
                                      autofocus: true,
                                    )
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {

                                  },
                                  child: Container(
                                    width: 75,
                                    height: 75,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot.data.poster),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 7.0,
                                              color: Colors.black
                                          )
                                        ]
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        /*return Image.network(
                          snapshot.data.poster,
                          height: 100,
                          width: 100,
                        );*/
                        //return Text("${snapshot.data.title}");
                      }else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  Text("2"),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("3"),
                  FutureBuilder<MovieData>(
                    future: futureData3,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        return Card(
                          color: Colors.blueAccent,
                          elevation: 10,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {

                                  },
                                  child: Container(
                                    width: 75,
                                    height: 75,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot.data.poster),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 7.0,
                                              color: Colors.black
                                          )
                                        ]
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  return showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(snapshot.data.title),
                                        content:
                                        Text('Rating : ${snapshot.data.imdbRating}\n'
                                            'Released : ${snapshot.data.released}\n'
                                            'IMDB ID : ${snapshot.data.imdbID}\n'
                                            'Type : ${snapshot.data.type}'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                    padding: EdgeInsets.all(25.0),
                                    child: Chip(
                                      label: Text(
                                        snapshot.data.title,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      shadowColor: Colors.blue,
                                      backgroundColor: Colors.green,
                                      elevation: 10,
                                      autofocus: true,
                                    )
                                ),
                              )
                            ],
                          ),
                        );
                        /*return Image.network(
                          snapshot.data.poster,
                          height: 100,
                          width: 100,
                        );*/
                        //return Text("${snapshot.data.title}");
                      }else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FutureBuilder<MovieData>(
                    future: futureData4,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        return Card(
                          color: Colors.blueAccent,
                          elevation: 10,
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  return showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(snapshot.data.title),
                                        content:
                                        Text('Rating : ${snapshot.data.imdbRating}\n'
                                            'Released : ${snapshot.data.released}\n'
                                            'IMDB ID : ${snapshot.data.imdbID}\n'
                                            'Type : ${snapshot.data.type}'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                    padding: EdgeInsets.all(25.0),
                                    child: Chip(
                                      label: Text(
                                        snapshot.data.title,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      shadowColor: Colors.blue,
                                      backgroundColor: Colors.green,
                                      elevation: 10,
                                      autofocus: true,
                                    )
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {

                                  },
                                  child: Container(
                                    width: 75,
                                    height: 75,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot.data.poster),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 7.0,
                                              color: Colors.black
                                          )
                                        ]
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        /*return Image.network(
                          snapshot.data.poster,
                          height: 100,
                          width: 100,
                        );*/
                        //return Text("${snapshot.data.title}");
                      }else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  Text("4"),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("5"),
                  FutureBuilder<MovieData>(
                    future: futureData5,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        return Card(
                          color: Colors.blueAccent,
                          elevation: 10,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {

                                  },
                                  child: Container(
                                    width: 75,
                                    height: 75,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot.data.poster),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 7.0,
                                              color: Colors.black
                                          )
                                        ]
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  return showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(snapshot.data.title),
                                        content:
                                        Text('Rating : ${snapshot.data.imdbRating}\n'
                                            'Released : ${snapshot.data.released}\n'
                                            'IMDB ID : ${snapshot.data.imdbID}\n'
                                            'Type : ${snapshot.data.type}'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                    padding: EdgeInsets.all(25.0),
                                    child: Chip(
                                      label: Text(
                                        snapshot.data.title,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      shadowColor: Colors.blue,
                                      backgroundColor: Colors.green,
                                      elevation: 10,
                                      autofocus: true,
                                    )
                                ),
                              )
                            ],
                          ),
                        );
                        /*return Image.network(
                          snapshot.data.poster,
                          height: 100,
                          width: 100,
                        );*/
                        //return Text("${snapshot.data.title}");
                      }else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(
            Icons.account_circle_rounded,
            color: Colors.white,
          ),
          onPressed: (){
            print("Hello");
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      ),
    );
  }
}

