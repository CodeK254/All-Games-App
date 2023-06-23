import 'package:all_games/Screens/game_bio.dart';
import 'package:all_games/Services/api_response.dart';
import 'package:all_games/Services/games_service.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  String game_id;

  Loading({
    required this.game_id
  });

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Map game_data = {};
  Future singleMovie(String id) async {
    print(widget.game_id);
    ApiResponse response = await getSingleMovie(id);

    if(response.error == null){
      setState(() {
        game_data = response.data as Map;
        // print(game_data);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GameData(game: game_data)));
      });
    } else {
      print(response.error);
    }
  }
  @override
  void initState(){
    super.initState();
    singleMovie(widget.game_id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.red[900],
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}