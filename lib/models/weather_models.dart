class Weather {
  final String cityName;
  final double temp;
  final String condition;

  Weather(
      {required this.cityName, required this.temp, required this.condition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temp: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
    );
  }
}