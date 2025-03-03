import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'weather_model.dart';
import 'weather_service.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<WeatherData> futureWeather;
  String? selectedCountry;
  Map<String, Map<String, double>> countryCoordinates = {};

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      List<dynamic> countries = jsonDecode(response.body);
      Map<String, Map<String, double>> fetchedCountries = {};
      for (var country in countries) {
        if (country['latlng'] != null && country['latlng'].length == 2) {
          fetchedCountries[country['name']['common']] = {
            'lat': country['latlng'][0],
            'long': country['latlng'][1]
          };
        }
      }
      setState(() {
        countryCoordinates = fetchedCountries;
        selectedCountry = countryCoordinates.keys.first;
        _fetchWeatherForSelectedCountry();
      });
    } else {
      throw Exception('Failed to load countries');
    }
  }

  Future<WeatherData> fetchWeatherData(double lat, double long) async {
    final data = await WeatherService.fetchWeather(lat, long);
    return WeatherData.fromJson(data);
  }

  void _fetchWeatherForSelectedCountry() {
    if (selectedCountry != null && countryCoordinates.containsKey(selectedCountry)) {
      final coordinates = countryCoordinates[selectedCountry]!;
      setState(() {
        futureWeather = fetchWeatherData(coordinates['lat']!, coordinates['long']!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildCountryDropdown(),
                SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder<WeatherData>(
                    future: futureWeather,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(color: Colors.white));
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("Error: ${snapshot.error}", style: TextStyle(color: Colors.white)),
                        );
                      } else if (snapshot.hasData) {
                        final weather = snapshot.data!;
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildCurrentWeather(weather.current),
                              SizedBox(height: 20),
                              Text('Hourly Forecast', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                              SizedBox(height: 10),
                              _buildHourlyList(weather.hourly),
                              SizedBox(height: 20),
                              _buildDailyForecast(weather.daily), // Add this here
                            ],
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> countryHistory = [];

  Widget _buildCountryDropdown() {
    List<String> sortedCountries = countryCoordinates.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown for selecting a country
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
          ),
          child: DropdownButton<String>(
            value: selectedCountry,
            isExpanded: true,
            underline: SizedBox(),
            items: sortedCountries.map((String country) {
              return DropdownMenuItem<String>(
                value: country,
                child: Text(country, style: TextStyle(fontSize: 16)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedCountry = newValue;
                  if (!countryHistory.contains(newValue)) {
                    countryHistory.insert(0, newValue); // Add to history
                    if (countryHistory.length > 5) {
                      countryHistory.removeLast(); // Limit to last 5 searches
                    }
                  }
                });
                _fetchWeatherForSelectedCountry();
              }
            },
          ),
        ),

        SizedBox(height: 10),

        // Recently selected countries (History)
        if (countryHistory.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Recent Searches", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 5),
              Wrap(
                spacing: 10,
                children: countryHistory.map((country) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCountry = country;
                      });
                      _fetchWeatherForSelectedCountry();
                    },
                    child: Chip(
                      label: Text(country),
                      backgroundColor: Colors.white.withOpacity(0.8),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
      ],
    );
  }


  Widget _buildCurrentWeather(CurrentData current) {
    final timeFormat = DateFormat('MMM d, y • HH:mm');
    return Card(
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Weather', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(timeFormat.format(DateTime.parse(current.time))),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.temperatureHigh, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('${current.temperature.toStringAsFixed(1)}°C', style: TextStyle(fontSize: 24)),
                  ],
                ),
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.wind, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('${current.windSpeed.toStringAsFixed(1)} km/h'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyList(HourlyData hourly) {
    final timeFormat = DateFormat('HH:mm');
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourly.time.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(timeFormat.format(DateTime.parse(hourly.time[index])), style: TextStyle(fontWeight: FontWeight.bold)),
                FaIcon(FontAwesomeIcons.cloudSun, color: Colors.blue),
                Text('${hourly.temperatures[index].toStringAsFixed(1)}°C'),
                Text('${hourly.humidity[index]}% Humidity'),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _buildDailyForecast(DailyData daily) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('7-Day Forecast', textAlign: TextAlign.center, style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
      SizedBox(height: 10),
      SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: daily.time.length,
          itemBuilder: (context, index) {
            return Container(
              width: 120,
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(DateFormat('E, MMM d').format(
                      DateTime.parse(daily.time[index])),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  FaIcon(FontAwesomeIcons.cloudSun, color: Colors.blue),
                  Text('${daily.maxTemperatures[index].toStringAsFixed(
                      1)}°C / ${daily.minTemperatures[index].toStringAsFixed(
                      1)}°C'),
                  Text('${daily.precipitation[index]} mm Rain'),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}
