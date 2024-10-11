import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Stateman extends ChangeNotifier{
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location services are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are denied forever");
    }
    return await Geolocator.getCurrentPosition();
  }
  String _temperature = " ";
  String get temp=>_temperature;
  String _humidity = " ";
  String get humidity=>_humidity;
  String _apparenttemp = " ";
  String get apparenttemp=>_apparenttemp;
  String _location = " ";
  String get loc=>_location;
  String _unit = " ";
  String get unit=>_unit;
  String _time = " ";
  String get time=>_time;
  String _wind = " ";
  String get wind=>_wind;
  String _code = " ";
  String get code=>_code;
  String _weather = " ";
  String get weather=>_weather;
  String _date = " ";
  String get date=>_date;
  String _ele=" ";
  String get ele=>_ele;
  String _key=" ";
  String get key=>_key;
  List<double> _dailytemp=[];
  List<String> _dailydate=[];
  List<double> get dailytemp => _dailytemp;
  List<String> get dailydate=> _dailydate;
  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      await fetchData(position);
    } catch (e) {
      await Geolocator.requestPermission();
      notifyListeners();
    };
  }

  Future<void> fetchData(Position position) async {
    final url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
        _location = data["timezone"].toString();
        _temperature = data['current']['temperature_2m'].toString();
        _humidity = data['current']['relative_humidity_2m'].toString();
        _apparenttemp = data['current']['apparent_temperature'].toString();
        _unit = data['daily_units']['temperature_2m_max'].toString();
        _time = data['current']['time'].toString();
        _wind = data['current']['wind_speed_10m'].toString();
        _code = data['current']['weather_code'].toString();
        DateTime _now = DateTime.parse(_time);
        _date = DateFormat('EEE MMM d yyyy').format(_now);
        _ele=data['elevation'].toString();
        _dailytemp= List<double>.from(data['daily']['temperature_2m_max']);
        _dailydate=List<String>.from(data['daily']['time']);
        if (_code == '0') {
          _weather = 'Clear sky';
          _key="Sunny";
        } else if (_code == '1' || _code == '2' || _code == '3') {
          _weather = 'Mainly clear, partly cloudy, and overcast';
          _key = "Cloudy";
        } else if (_code == "45" || _code == "48") {
          _weather = "Fog and depositing rime fog";
          _code="Fog";
        } else if (_code == '51' || _code == '53' || _code == '55') {
          _weather = 'Drizzle: Light, moderate, and dense intensity';
          _key="Drizzle";
        }else if (_code == "56" || _code == "57") {
          _weather = "Freezing Drizzle: Light and dense intensity";
          _key="Cold";
        }  else if (_code == '61' || _code == '63' || _code == '65') {
          _weather = 'Rain: Slight, moderate and heavy intensity';
          _key="Moderate Rain";
        }else if (_code == "66" || _code == "67") {
          _weather = "Freezing Rain: Light and heavy intensity";
          _key="Rain";
        } else if (_code == '80' || _code == '81' || _code == '82') {
          _weather = 'Rain showers: Slight, moderate, and violent';
          _key="Rain";
        } else if (_code == "71" || _code == "73" || _code == "75") {
          _weather = "Snow fall: Slight, moderate, and heavy intensity";
        } else if (_code == "77") {
          _weather = "Snow grains";
          _code="Snow";
        }else if (_code == "85" || _code == "86") {
          _weather = "Snow showers: Slight and heavy";
          _code="Snow";
        } else if (_code == "96" || _code == "99") {
          _weather = "Thunderstorm with slight and heavy hail";
          _key="Thunderstorm";
        } else if (_code == '95') {
          _weather = 'Thunderstorm: Slight or moderate';
          _key="Thunderstorm";
        } else {
          _weather = 'Normal weather';
          _code="Sunny";
        }
        notifyListeners();
    }
    else {
      print("Unable to get location");
    }
  }
  Future<void> location() async {
    await _determinePosition();
    await _getLocation();
    notifyListeners();
  }
}