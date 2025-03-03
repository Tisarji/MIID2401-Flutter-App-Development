class DailyData {
  final List<String> time;
  final List<double> maxTemperatures;
  final List<double> minTemperatures;
  final List<double> precipitation;

  DailyData({
    required this.time,
    required this.maxTemperatures,
    required this.minTemperatures,
    required this.precipitation,
  });

  factory DailyData.fromJson(Map<String, dynamic> json) {
    return DailyData(
      time: List<String>.from(json['time']),
      maxTemperatures: List<double>.from(json['temperature_2m_max']),
      minTemperatures: List<double>.from(json['temperature_2m_min']),
      precipitation: List<double>.from(json['precipitation_sum']),
    );
  }
}

class WeatherData {
  final double latitude;
  final double longitude;
  final CurrentData current;
  final HourlyData hourly;
  final DailyData daily;

  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      latitude: json['latitude'],
      longitude: json['longitude'],
      current: CurrentData.fromJson(json['current']),
      hourly: HourlyData.fromJson(json['hourly']),
      daily: DailyData.fromJson(json['daily']),
    );
  }
}


class CurrentData {
  final String time;
  final double temperature;
  final double windSpeed;

  CurrentData({
    required this.time,
    required this.temperature,
    required this.windSpeed,
  });

  factory CurrentData.fromJson(Map<String, dynamic> json) {
    return CurrentData(
      time: json['time'],
      temperature: json['temperature_2m'],
      windSpeed: json['wind_speed_10m'],
    );
  }
}

class HourlyData {
  final List<String> time;
  final List<double> temperatures;
  final List<int> humidity;
  final List<double> windSpeeds;

  HourlyData({
    required this.time,
    required this.temperatures,
    required this.humidity,
    required this.windSpeeds,
  });

  factory HourlyData.fromJson(Map<String, dynamic> json) {
    return HourlyData(
      time: List<String>.from(json['time']),
      temperatures: List<double>.from(json['temperature_2m']),
      humidity: List<int>.from(json['relative_humidity_2m']),
      windSpeeds: List<double>.from(json['wind_speed_10m']),
    );
  }
}


