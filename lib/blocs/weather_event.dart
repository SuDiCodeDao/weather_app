part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final Position position;

  const FetchWeather({required this.position});
  @override
  // TODO: implement props
  List<Object?> get props => [position];
}
