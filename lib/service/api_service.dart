import 'dart:convert';

import 'package:http/http.dart';
import 'package:ostad_flutter_3_assignment_9/constants/constants.dart';
import 'package:ostad_flutter_3_assignment_9/model/weather_model.dart';

class ApiService {
  Future<WeatherModel> getWeatherData() async {
    String url = base_url;
    try {
      Response response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(json);
        return weatherModel;
      } else {
        throw "No data found";
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
