import 'package:all_games/Screens/constants.dart';
import 'package:all_games/Screens/game_category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: 
      AppBar(
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: gameCategories.length,
          itemBuilder: (context, index){
            return Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameCategory(category: gameCategories[index])),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.08,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Game Category: ",
                                  style: GoogleFonts.rancho(
                                    fontSize: 18,
                                    color: Colors.black,
                                    letterSpacing: 1.2
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  gameCategories[index].toUpperCase(),
                                  style: GoogleFonts.rancho(
                                    fontSize: 18,
                                    color: Colors.red[900],
                                    letterSpacing: 1.2
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.more_horiz,
                              size: 25,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
              ],
            );
          }
        )
        // GridView.builder(
        //   itemCount: gameCategories.length,
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 3,
        //     crossAxisSpacing: 3,
        //     mainAxisSpacing: 3,
        //   ),
        //   itemBuilder: (context, index){
        //     return Container(
        //       decoration: const BoxDecoration(
        //         color: Colors.white,
        //         boxShadow: [
        //           BoxShadow(
        //             blurRadius: 1,
        //           )
        //         ]
        //       ),
        //       child: Center(
        //         child: Text(
        //           gameCategories[index],
        //           style: GoogleFonts.rancho(
        //             fontSize: 15,
        //             fontWeight: FontWeight.w500,
        //             letterSpacing: 1.2,
        //             color: Colors.red[900],
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
      )
    );
  }
}