import 'package:all_games/Screens/constants.dart';
import 'package:all_games/Services/api_response.dart';
import 'package:all_games/Services/games_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameData extends StatefulWidget {
  Map game;

  GameData({
    required this.game
  });

  @override
  State<GameData> createState() => _GameDataState();
}

class _GameDataState extends State<GameData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.red[200],
        toolbarHeight: 65,
        centerTitle: true,
        iconTheme: IconThemeData(
          size: 25,
          color: Colors.red[900]
        ),
        title: Text(
          widget.game["title"],
          style: GoogleFonts.rancho(
            fontSize: 30,
            color: Colors.red[900],
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        children: [
          gameBioDescription("Short - Description", widget.game["short_description"]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.longestSide * 0.35,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: Image(
                image: NetworkImage(widget.game["thumbnail"]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          gameBioDescription("Description", widget.game["description"]),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: Center(
              child: Text(
                "Minimum System Requirements",
                style: GoogleFonts.rancho(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          const Divider(height: 8),
          widget.game["platform"].toString().toLowerCase() != "web browser" ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myTextDescriptor("Operating Systems - ${widget.game["minimum_system_requirements"]["os"]}"),
              myTextDescriptor("Processor - ${widget.game["minimum_system_requirements"]["processor"]}"),
              myTextDescriptor("Memory - ${widget.game["minimum_system_requirements"]["memory"]}"),
              myTextDescriptor("Graphics - ${widget.game["minimum_system_requirements"]["graphics"]}"),
              myTextDescriptor("Storage - ${widget.game["minimum_system_requirements"]["storage"]}"),
            ],
          ) : Container(),
        ],
      ),
    );
  }
}