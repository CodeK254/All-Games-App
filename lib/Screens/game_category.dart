import 'dart:convert';
import 'package:all_games/Screens/constants.dart';
import 'package:all_games/Screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:http/http.dart" as http;

class GameCategory extends StatefulWidget {
  String category;

  GameCategory({
    required this.category,
  });

  @override
  State<GameCategory> createState() => _GameCategoryState();
}

class _GameCategoryState extends State<GameCategory> {
  List data = [];

  void loadGames(String cat) async {
    var url = Uri.parse("https://www.freetogame.com/api/games?category=$cat");

    final response = await http.get(url);

    // print(response.body);
    
    setState(() {
      data = jsonDecode(response.body);
    });

    print(data);
  }

  @override
  void initState(){
    super.initState();
    loadGames(widget.category);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        shadowColor: Colors.red[900],
        centerTitle: true,
        iconTheme: IconThemeData(
          size: 25,
          color: Colors.red[900],
        ),
        title: Text(
          widget.category.toUpperCase(),
          style: GoogleFonts.rancho(
            fontSize: 25,
            letterSpacing: 1.2,
            color: Colors.red[900],
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              data[index]["platform"];
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => Loading(game_id: data[index]["id"].toString())),
              );
            },
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.5,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                        child: Text(
                          data[index]["title"],
                          style: GoogleFonts.rancho(
                            fontSize: 20,
                            color: Colors.grey,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image(
                            image: NetworkImage(data[index]["thumbnail"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1,
                                    color: Colors.red.shade200
                                  )
                                ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Description",
                                      style: GoogleFonts.rancho(
                                        fontSize: 18,
                                        letterSpacing: 1.2,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Divider(height: 1,),
                                    const SizedBox(height: 10),
                                    Center(
                                      child: Text(
                                        data[index]["short_description"],
                                        style: GoogleFonts.rancho(
                                          fontSize: 17,
                                          letterSpacing: 1.2,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            myDescriptor("genre -", data[index]["genre"]),
                            myDescriptor("platform -", data[index]["platform"]),
                            myDescriptor("publisher -", data[index]["publisher"]),
                            myDescriptor("developer -", data[index]["developer"]),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(height: 1, thickness: 1, color: Colors.red[900],)
              ],
            ),
          );
        }
      ),
    );
  }
}