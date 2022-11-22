library weather.models.city;

class City {
  final String city;
  final String country;

  const City({
    required this.city,
    required this.country,
  });


  factory City.fromJson(Map<String, dynamic> json){
    return City(
      city: json['name'],
      country: json['sys']['country']
    );
  }
}