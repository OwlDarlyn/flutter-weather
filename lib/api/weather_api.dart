library weather.api;
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../models/city_model.dart';
import '../models/weather_model.dart';

var apiKey = "YOUR_API_KEY";

Future<List<City>> fetchCity(String city) async {
  final response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/find?q=${city}&appid=${apiKey}'));
  if(response.statusCode == 200) {
   return (json.decode(response.body)['list'] as List).map((data) => City.fromJson(data)).toList();
  }else{
    throw Exception('Failed to fetch city');
  }
}

Future<Weather> fetchWeather(String city) async {
  final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?&q=${city}&units=metric&appid=${apiKey}'));
  if(response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to fetch weather');
  }
}