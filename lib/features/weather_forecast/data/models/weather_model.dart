class WeatherModel {
  WeatherModel(
    this.feelsLike,
    this.currentCondition,
    this.cloudCover,
    this.sunrise,
    this.sunset,
    this.currentTemperature,
    this.humidity,
    this.pressure,
  );

  final double feelsLike;
  final double currentTemperature;
  final String currentCondition;
  final double cloudCover;
  final double humidity;
  final double pressure;
  final String sunrise;
  final String sunset;

  WeatherModel.fromJson(Map<String, dynamic> json)
      : currentTemperature = json['currentConditions']['temp'],
        feelsLike = json['currentConditions']['feelslike'],
        currentCondition = json['currentConditions']['conditions'],
        cloudCover = json['currentConditions']['cloudcover'],
        humidity = json['currentConditions']['humidity'],
        pressure = json['currentConditions']['pressure'],
        sunrise = json['currentConditions']['sunrise'],
        sunset = json['currentConditions']['sunset'];
}
