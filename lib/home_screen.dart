import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> data = {
    'id': '1',
    'city': '',
    'temp': '',
    'icon': '',
    'temp_min': '',
    'temp_max': '',
    'description': '',
    'updatedTime': '12',
  };
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  void getWeatherData() async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=dhaka&appid=2890507c01a5d0b66f6e9faa24f773c4';
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      isLoading = true;
      Map decodedData = jsonDecode(response.body);
      // print(decodedData['name']);
      data['id'] = decodedData['weather'][0]['id'];
      data['city'] = decodedData['name'];
      data['temp'] = decodedData['main']['temp'];
      data['icon'] = decodedData['weather'][0]['icon'];
      data['temp_min'] = decodedData['main']['temp_min'];
      data['temp_max'] = decodedData['main']['temp_max'];
      data['description'] = decodedData['weather'][0]['description'];
      isLoading = false;
      setState(() {});
      print(data['icon']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Weather'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 50,
              ),
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(81, 48, 167, 1),
                    Color.fromRGBO(111, 95, 232, 1),
                  ],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    data['city'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const Text(
                    'Updated: 3:38 PM',
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Colors.grey,
                        child: Image.network(
                          'https://openweathermap.org/img/wn/${data['icon']}@2x.png',
                          width: 50,
                          errorBuilder: (
                            context,
                            obj,
                            stackTrace,
                          ) {
                            return const Icon(
                              Icons.image,
                              size: 100,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                      // Weather degree
                      Row(
                        children: [
                          Text(
                            data['temp'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                            ),
                          ),
                          const Text(
                            '\u1d3c',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      // max and min
                      Column(
                        children: [
                          // max
                          Row(
                            children: [
                              Text(
                                'max: ${data['temp_max']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.w600,
                                  // fontSize: 20,
                                ),
                              ),
                              const Text(
                                '\u1d3c',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          // min
                          Row(
                            children: [
                              Text(
                                'min: ${data['temp_min']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.w600,
                                  // fontSize: 25,
                                ),
                              ),
                              const Text(
                                '\u1d3c',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    data['description'].toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 26),
                  ),
                ],
              ),
            ),
    );
  }
}
