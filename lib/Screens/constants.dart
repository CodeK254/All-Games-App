import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<String> drawerItems = [
  "PC",
  "Browser",
  "All",
];

String categ = "mmorpg, shooter, strategy, moba, racing, sports, social, sandbox, open-world, survival, pvp, pve, pixel, voxel, zombie, turn-based, first-person, third-Person, top-down, tank, space, sailing, side-scroller, superhero, permadeath, card, battle-royale, mmo, mmofps, mmotps, 3d, 2d, anime, fantasy, sci-fi, fighting, action-rpg, action, military, martial-arts, flight, low-spec, tower-defense, horror, mmorts";

List<String> gameCategories = categ.split(", ");

List<String> sortBy = [
  "release-date", 
  "popularity", 
  "alphabetical", 
  "relevance"
];

AppBar appBarTheme(String title, IconData icn, int init, int selected, Function func){
  return AppBar(
    toolbarHeight: 65,
    backgroundColor: Colors.white,
    shadowColor: Colors.red,
    elevation: 1,
    iconTheme: IconThemeData(
      color: Colors.red[900],
      size: 25,
    ),
    title: Row(
      children: [
        Text(
          "Game Categories - ",
          style: GoogleFonts.rancho(
            fontSize: 30,
            color: Colors.red[900],
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold
          ),
        ),
        const Icon(Icons.gamepad)
      ],
    ),
    actions: [
      PopupMenuButton(
        initialValue: init,
        color: Colors.white,
        onSelected: (value){
          func;
        },
        itemBuilder: (context) {
          return [
            ...List.generate(sortBy.length, (index) => PopupMenuItem(
              onTap: (){
                func;
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selected == index ? Colors.grey : Colors.white,
                ),
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.shortestSide * 0.6,
                ),
                child: Text(
                  sortBy[index],
                  style: GoogleFonts.rancho(
                    fontSize: 15,
                    color: Colors.black,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            )),
          ];
        }
      )
    ],
  );
}


Padding myDescriptor(String label, String value){
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Row(
      children: [
        Text(
          label,
          style: GoogleFonts.rancho(
            fontSize: 15,
            color: Colors.black,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: GoogleFonts.rancho(
            fontSize: 15,
            color: Colors.black,
            letterSpacing: 1.2,
          ),
        ),
      ],
    ),
  );
}

Column gameBioDescription(String label, String message){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.rancho(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
          letterSpacing: 1.2,
        ),
      ),
      const Divider(height: 5),
      Center(
        child: Text(
          message,
          style: GoogleFonts.rancho(
            fontSize: 17,
            color: Colors.grey[800],
            letterSpacing: 1.2,
          ),
        ),
      ),
    ],
  );
}

Padding myTextDescriptor(String value){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      value,
      style: GoogleFonts.rancho(
        fontSize: 15,
        color: Colors.black,
        letterSpacing: 1.2,
      ),
    ),
  );
}