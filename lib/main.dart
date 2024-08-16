import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/weather_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.lightBlue[50], // Light blue background
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Search Weather',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue[100],
                prefixIcon: Icon(Icons.search, color: Colors.blue),
              ),
              onSubmitted: (value) {
                weatherProvider.setCityName(value);
                weatherProvider.fetchWeather();
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                weatherProvider.setCityName(_cityController.text);
                weatherProvider.fetchWeather();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
              child: Text('Get Weather'),
            ),
            SizedBox(height: 30),
            weatherProvider.weatherData == null
                ? Column(
              children: [
                Icon(Icons.cloud_off, size: 100, color: Colors.blueGrey),
                SizedBox(height: 20),
                Text(
                  'No data available',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            )
                : WeatherInfo(weatherProvider.weatherData!),
          ],
        ),
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  WeatherInfo(this.weatherData);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          weatherData['name'],
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[700],
          ),
        ),
        SizedBox(height: 10),
        Text(
          '${weatherData['main']['temp']} °C',
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.w300,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 10),
        Text(
          weatherData['weather'][0]['description'].toString().toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
