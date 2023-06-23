import 'package:all_games/Screens/constants.dart';
import 'package:all_games/Screens/loading.dart';
import 'package:all_games/Services/api_response.dart';
import 'package:all_games/Services/games_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllGames extends StatefulWidget {
  const AllGames({super.key});

  @override
  State<AllGames> createState() => _AllGamesState();
}

class _AllGamesState extends State<AllGames> {
  int initValue = 0;
  int selectedItem = 0;
  int category = 2;
  
  List games = [];
  void callApi(int drawerIndex, int popUpIndex) async {
    ApiResponse response = await categorizedGames(drawerItems[category].toLowerCase(), sortBy[popUpIndex]);

    if(response.error == null){
      setState(() {
        games = response.data as List;
      });

      print(games.length);
      // print(games);
    } else {
      print(response.error);
    }
  }
  @override
  void initState(){
    super.initState();
    callApi(0, 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: const Image(
                    image: AssetImage("assets/logo.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ...List.generate(drawerItems.length, (index) => Column(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      category = index;
                    });
                    callApi(category, selectedItem);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: category == index ? Colors.grey[200] : Colors.white,
                    ),
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            drawerItems[index],
                            style: GoogleFonts.rancho(
                              fontSize: 18,
                              color: Colors.grey,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
              ],
            )),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/categories");
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.1,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Category",
                        style: GoogleFonts.rancho(
                          fontSize: 18,
                          color: Colors.grey,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
          ],
        ),
      ),
      appBar: AppBar(
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
              "All Games - ",
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
            initialValue: initValue,
            color: Colors.white,
            onSelected: (value){
              setState(() {
                initValue = value;
              });
            },
            itemBuilder: (context) {
              return [
                ...List.generate(sortBy.length, (index) => PopupMenuItem(
                  onTap: (){
                    setState(() {
                      selectedItem = index;
                    });
                    callApi(selectedItem, selectedItem);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedItem == index ? Colors.grey : Colors.white,
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
      ),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              games[index]["platform"];
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => Loading(game_id: games[index]["id"].toString())),
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
                          games[index]["title"],
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
                            image: NetworkImage(games[index]["thumbnail"]),
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
                                        games[index]["short_description"],
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
                            myDescriptor("genre -", games[index]["genre"]),
                            myDescriptor("platform -", games[index]["platform"]),
                            myDescriptor("publisher -", games[index]["publisher"]),
                            myDescriptor("developer -", games[index]["developer"]),
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