import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/weather_api.dart';
import '../models/weather_model.dart';

class WeatherDataWidget extends StatefulWidget {
  final String city;

  const WeatherDataWidget({super.key, required this.city});

  @override
  State<WeatherDataWidget> createState() => _WeatherDataWidgetState();
}

class _WeatherDataWidgetState extends State<WeatherDataWidget> {
  final DateFormat formatter = DateFormat('d-LLL-y');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
        margin: const EdgeInsets.only(top: 25),
        alignment: Alignment.center,
        child: Column(children: <Widget>[
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              color: Colors.white.withOpacity(0.7),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: FutureBuilder<Weather>(
                    future: fetchWeather(
                        widget.city.isNotEmpty ? widget.city : "London"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            margin: const EdgeInsets.all(20),
                            child: Wrap(
                              spacing: MediaQuery.of(context).size.width < 450
                                  ? 10
                                  : 20,
                              children: [
                                Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.network(
                                        "http://openweathermap.org/img/wn/${snapshot.data!.icon}@2x.png")),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${snapshot.data!.temp.toString()}\u00B0C",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    400
                                                ? 16
                                                : 21)),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                            snapshot.data!.weatherStatus,
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        400
                                                    ? 14
                                                    : 18))),
                                    Flexible(
                                        child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Text(
                                                snapshot
                                                    .data!.weatherDescription,
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width <
                                                                450
                                                            ? 14
                                                            : 18,
                                                    color: Colors.black
                                                        .withOpacity(0.5))))),
                                  ],
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, bottom: 10),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${snapshot.data!.city}, ${snapshot.data!.country}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .width <
                                                              450
                                                          ? 14
                                                          : 16)),
                                          Text(
                                            formatter.format(DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    snapshot.data!.date *
                                                        1000)),
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        450
                                                    ? 14
                                                    : 16,
                                                color: Colors.grey),
                                          )
                                        ])),
                                const Divider(
                                  color: Colors.lightBlue,
                                  thickness: 0.3,
                                ),
                                SizedBox(
                                    height: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                "Min",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                    "${snapshot.data!.tempMin.toString()}\u00B0C",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18)),
                                              )
                                            ]),
                                        const VerticalDivider(
                                          color: Colors.lightBlue,
                                          width: 5,
                                          thickness: 0.3,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text("Max",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16)),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                    "${snapshot.data!.tempMax.toString()}\u00B0C",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18)))
                                          ],
                                        )
                                      ],
                                    ))
                              ],
                            ));
                      } else if (snapshot.hasError) {
                        return Container(
                            margin: const EdgeInsets.all(10),
                            child: Text("${snapshot.error}"));
                      }
                      return const SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator());
                    },
                  ))),
        ]));
  }
}
