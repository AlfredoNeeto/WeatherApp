import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/application/services/weather_service.dart';
import 'package:myapp/domain/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPage();
}

class _WeatherPage extends State<WeatherPage> {
//Chave da api
  final _weatherService = WeatherService('5d28bc18a6ad9e353f9ef8a17135c144');
  Weather? _weather;

// carregar tempo
  _fetchWeather() async {
//obtem a cidade atual
    String cityName = await _weatherService.getCurrentCity();

//Obtem o tempo da cidade
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

//Animação do tempo
  String getWeatherAnimation(String? mainCondition) {
    String pathAssets = 'lib/presentation/assets';

    if (mainCondition == null) return '$pathAssets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return '$pathAssets/cloud.json';
      case 'mist':
        return '$pathAssets/mist.json';
      case 'smoke':
        return '$pathAssets/smoke.json';
      case 'haze':
      case 'dust':
      case 'fog':
        return '$pathAssets/cloud.json';
      case 'rain':
        return '$pathAssets/rain.json';
      case 'drizzle':
      case 'shower rain':
        return '$pathAssets/rain.json';
      case 'thunderstorm':
        return '$pathAssets/thunder.json';
      case 'clear':
        return '$pathAssets/sunny.json';
      default:
        return '$pathAssets/sunny.json';
    }
  }

//Inicando animação
  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Icon(Icons.location_on_sharp,
                size: 30, color: Theme.of(context).primaryColor),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _weather?.cityName.toUpperCase() ?? "loading city..",
              style: GoogleFonts.anton(
                  textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 30,
              )),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(top: 82.0, bottom: 82.0),
            child: Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 16.0),
            child: Text(
              '${_weather?.temperature.round().toString().toUpperCase()}°C',
              style: GoogleFonts.anton(
                  textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 45,
              )),
            ),
          ),
        ],
      )),
    );
  }
}
