import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Taukeet",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final salah = [
    "FAJR",
    "SUNRISE",
    "DHUHR",
    "ASR",
    "MAGHRIB",
    "ISHA",
  ];

  final cardTimeStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xff191923),
  );

  final cardTimeLabelStyle = const TextStyle(
    fontSize: 8,
    color: Color(0xff191923),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff191923),
      body: Stack(
        children: [
          Positioned(
            top: 30,
            right: 10,
            child: IconButton(
              onPressed: () {
                print("clicked");
              },
              iconSize: 26,
              icon: const Icon(
                Icons.settings,
                color: Color(0xffF0E7D8),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "FAJR",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 6,
                      color: Color(0xffF0E7D8),
                    ),
                  ),
                  Text(
                    "05:30:45",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 8,
                      color: Color(0xffF0E7D8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 196),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: salah
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(
                            top: 2,
                            left: 10,
                            right: 10,
                          ),
                          child: Card(
                            color: const Color(0xffF0E7D8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 6,
                                      color: Color(0xff191923),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "START",
                                            style: cardTimeLabelStyle,
                                          ),
                                          Text(
                                            "05:30 AM",
                                            style: cardTimeStyle,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "END",
                                            style: cardTimeLabelStyle,
                                          ),
                                          Text(
                                            "05:30 AM",
                                            style: cardTimeStyle,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
