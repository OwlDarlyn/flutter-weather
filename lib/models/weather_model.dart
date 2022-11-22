library weather.models.weather;

class Weather { 
  final String city;
  final String country;
  final String weatherStatus;
  final String weatherDescription;
  final String icon;
  final num temp;
  final num tempMin;
  final num tempMax;
  final int date;
  const Weather({required this.weatherStatus, required this.weatherDescription, required this.icon, required this.temp, required this.tempMin, required this.tempMax, required this.city, required this.country, required this.date});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      country: json['sys']['country'],
      weatherStatus: json['weather'][0]['main'],
      weatherDescription: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      temp: json['main']['temp'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      date: json['dt']
    );
  }
}