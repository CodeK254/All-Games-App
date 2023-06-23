import 'dart:convert';

import 'package:all_games/Services/api_response.dart';
import 'package:http/http.dart' as http;

const String all_games = "https://www.freetogame.com/api/games";
const String notFound = "Serve not found";
const String serverError = "An error occured while processing";

Future<ApiResponse> allGames() async {
  ApiResponse apiResponse = ApiResponse();
  var response = await http.get(
    Uri.parse(all_games),
    headers: {
      "Accept": "application/json",
    }
  );

  try{
    switch(response.statusCode){
      case 200:
      apiResponse.data = jsonDecode(response.body);
      break;

      case 404:
      apiResponse.error = notFound;
      break;

      default:
      apiResponse.error = serverError;
      break;
    }
  } catch(e){
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> categorizedGames(String category, String srtBy) async {
  ApiResponse apiResponse = ApiResponse();
  var response = await http.get(
    Uri.parse("$all_games?platform=$category&sort-by=$srtBy"),
    headers: {
      "Accept": "application/json",
    }
  );

  try{
    switch(response.statusCode){
      case 200:
      apiResponse.data = jsonDecode(response.body);
      break;

      case 404:
      apiResponse.error = notFound;
      break;

      default:
      apiResponse.error = serverError;
      break;
    }
  } catch(e){
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> getSingleMovie(String id) async {
  ApiResponse apiResponse = ApiResponse();

  var response = await http.get(
    Uri.parse("https://www.freetogame.com/api/game?id=$id"),
    headers: {
      "Accept": "application/json",
    }
  );

  try{
      switch(response.statusCode){
      case 200:
      apiResponse.data = jsonDecode(response.body);
      break;

      case 404:
      apiResponse.error = notFound;
      break;

      default:
      apiResponse.error = serverError;
      break;
    }
  } catch(e){
    apiResponse.error = serverError;
  }

  return apiResponse;
}