import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularCities extends StatefulWidget {
  final String city;
  final String country;
  final String image;
  final Function clickedPopularCityHandler;
  const PopularCities(
      {super.key,
      required this.city,
      required this.country,
      required this.image,
      required this.clickedPopularCityHandler});

  @override
  State<PopularCities> createState() => _PopularCitiesState();
}

class _PopularCitiesState extends State<PopularCities> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: ClipRRect(
                child: InkWell(
                    splashColor: Colors.black12,
                    borderRadius: BorderRadius.circular(40),
                    onTap: (() {
                      widget.clickedPopularCityHandler(
                          "${widget.city}, ${widget.country}");
                    }),
                    child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.image)),
                        ),
                        height: 250,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: 40,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Center(
                                        child: Text(widget.city,
                                            textAlign: TextAlign.center))))
                          ],
                        ))))),
      ],
    );
  }
}

typedef CityCallback = void Function(String cityName);
