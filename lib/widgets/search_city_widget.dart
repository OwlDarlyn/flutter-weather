import 'dart:developer';

import 'package:flutter/material.dart';
import '../api/weather_api.dart';
import '../models/city_model.dart';
import 'weather_data_widget.dart';
import 'popular_cities_widget.dart';
import 'faq_widget.dart';
import '../models/globals.dart' as globals;

class SearchCityWidget extends StatefulWidget {
  const SearchCityWidget({super.key});
  @override
  State<SearchCityWidget> createState() => _SearchCityWidgetState();
}

class _SearchCityWidgetState extends State<SearchCityWidget> {
  var textEditingController = TextEditingController();
  Color tileColor = globals.time > 20 ? Colors.black : Colors.lightBlue;
  bool hover = false;
  int hoverIndex = -1;
  bool dataNotEmpty = false;
  String cityName = "";
  String chosenCity = "";

  @override
  void initState() {
    super.initState();
    cityName;
    chosenCity;
  }

  void popularCityClicked(city) {
    setState(() {
      chosenCity = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: globals.time > 20
                    ? const AssetImage('assets/images/bgdark.png')
                    : const AssetImage('assets/images/bglight.png'),
                fit: BoxFit.cover),
          ),
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.center,
            child: Column(children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(25),
                      hintText: "Start typing to search...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      suffixIcon: MaterialButton(
                          onPressed: () {
                            cityName = textEditingController.text;
                            dataNotEmpty = true;
                            setState(() {});
                          },
                          padding: const EdgeInsets.only(left: -15.0),
                          shape: const CircleBorder(),
                          color: globals.time > 20
                              ? Colors.black
                              : Colors.lightBlue,
                          child:
                              const Icon(Icons.search, color: Colors.white))),
                ),
              ),
              Stack(children: [
                Positioned(
                    child: WeatherDataWidget(
                  city: chosenCity,
                )),
                Visibility(
                    visible: dataNotEmpty,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: Container(
                            constraints: const BoxConstraints(minHeight: 60),
                            width: MediaQuery.of(context).size.width * 0.8,
                            //margin: const EdgeInsets.only(top: 10),
                            child: FutureBuilder<List<City>>(
                                future: fetchCity(cityName),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<City> city =
                                        snapshot.data as List<City>;
                                    return ListView.separated(
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(height: 5);
                                        },
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                top: 0, bottom: 10),
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                MouseRegion(
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: ListTile(
                                                        dense: true,
                                                        title: Text(
                                                            "${city[index].city}, ${city[index].country}"),
                                                        focusColor: tileColor,
                                                        hoverColor: tileColor,
                                                        textColor: hover &&
                                                                hoverIndex ==
                                                                    index
                                                            ? Colors.white
                                                            : Colors.black,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        onTap: (() {
                                                          log(city[index].city);
                                                          dataNotEmpty = false;
                                                          textEditingController
                                                              .clear();
                                                          chosenCity =
                                                              "${city[index].city}, ${city[index].country}";
                                                          setState(() {});
                                                        }),
                                                        selectedTileColor:
                                                            globals.time > 20
                                                                ? Colors
                                                                    .lightBlue
                                                                : Colors.black,
                                                      )),
                                                  onEnter: (event) {
                                                    setState(() {
                                                      hoverIndex = index;
                                                      hover = true;
                                                    });
                                                  },
                                                  onExit: (event) {
                                                    setState(() {
                                                      hoverIndex = -1;
                                                      hover = false;
                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        itemCount: city.length);
                                  } else if (snapshot.hasError) {
                                    if (textEditingController.text.isEmpty) {
                                      return const ListTile(
                                          title: Text(
                                              "You should type city name first"));
                                    }
                                    return ListTile(
                                        title: Text("${snapshot.error}"));
                                  }
                                  return const ListTile(
                                      dense: true,
                                      title: CircularProgressIndicator());
                                })))),
              ]),
            ]),
          )),
      Container(
          margin: const EdgeInsets.only(top: 50, bottom: 50),
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Text(
            "Check the weather in most popular cities in the world",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          )),
      PopularCities(
        city: "New York",
        country: "US",
        image:
            "https://a.cdn-hotels.com/gdcs/production101/d154/ee893f00-c31d-11e8-9739-0242ac110006.jpg?impolicy=fcrop&w=800&h=533&q=medium",
        clickedPopularCityHandler: popularCityClicked,
      ),
      PopularCities(
        city: "London",
        country: "GB",
        image:
            "https://cdn.londonandpartners.com/-/media/images/london/visit/things-to-do/sightseeing/london-attractions/tower-bridge/towerbridge-640x360.jpg?mw=640&hash=9FF3EBA9414733318A48ABDB4F58FBEB3B7E29AC",
        clickedPopularCityHandler: popularCityClicked,
      ),
      PopularCities(
        city: "Dubai",
        country: "AE",
        image:
            "https://www.telegraph.co.uk/content/dam/travel/2022/04/28/TELEMMGLPICT000294202743_trans_NvBQzQNjv4BqE2XjdrYCNd3pnDOjqZKCS3wSCF1R0VweJ7DS2UnVMSQ.jpeg?imwidth=680",
        clickedPopularCityHandler: popularCityClicked,
      ),
      PopularCities(
        city: "Paris",
        country: "FR",
        image:
            "https://www.telegraph.co.uk/content/dam/Travel/Destinations/Europe/France/Paris/paris-vintage-car.jpg?imwidth=680",
        clickedPopularCityHandler: popularCityClicked,
      ),
      Container(
          margin: const EdgeInsets.only(top: 50, bottom: 50),
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Text(
            "Frequently asked questions",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          )),
      FaqWidget(
          title: "Question 1",
          description:
              "Once upon a time there was a lovely princess. But she had an enchantment upon her of a fearful sort which could only be broken by love's first kiss. She was locked away in a castle guarded by a terrible fire-breathing dragon.",
          isOpened: false),
      FaqWidget(
          title: "Question 2",
          description:
              "Once upon a time there was a lovely princess. But she had an enchantment upon her of a fearful sort which could only be broken by love's first kiss. She was locked away in a castle guarded by a terrible fire-breathing dragon.",
          isOpened: false),
    ]);
  }
}
