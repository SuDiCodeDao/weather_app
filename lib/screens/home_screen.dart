import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/utils.dart';

import '../blocs/weather_bloc.dart';
import '../common/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const double kToolbarHeightMultiplier = 1.2;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              _buildCircleContainer(
                  context, AppColors.deepPurpleAccentColor, 3, -0.3),
              _buildCircleContainer(
                  context, AppColors.deepPurpleAccentColor, -3, -0.3),
              _buildSquareContainer(context, AppColors.lightBlueColor, 0, -1.2),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  return (state is WeatherSuccess)
                      ? _buildWeatherContent(context, state.weather)
                      : Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleContainer(
      BuildContext context, Color color, double dx, double dy) {
    return Positioned(
      top: HomeScreen.kToolbarHeightMultiplier * kToolbarHeight * 2,
      left: MediaQuery.of(context).size.width / 2 + dx * 100,
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }

  Widget _buildWeatherContent(BuildContext context, Weather weather) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('📍${weather.areaName}', style: AppStyles.whiteText),
          const SizedBox(height: 5),
          Text(_getGreeting(), style: AppStyles.boldWhiteText),
          getWeatherIcon(weather.weatherConditionCode!),
          Center(
            child: Text('${weather.temperature!.celsius!.round()}°C',
                style: AppStyles.temperatureText),
          ),
          Center(
            child: Text(weather.weatherMain!.toUpperCase(),
                style: AppStyles.weatherMainText),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(AppUtils.formatDateTime(weather.date!),
                style: AppStyles.smallWhiteText),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoRow('Sunrise', weather.sunrise!),
              _buildInfoRow('Sunset', weather.sunset!),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Divider(color: AppColors.grey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoRow('Temp Max', weather.tempMax!.celsius!.round()),
              _buildInfoRow('Temp Min', weather.tempMin!.celsius!.round()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, dynamic value) {
    return Row(
      children: [
        Image.asset('assets/${getTitleIcon(title)}.png', scale: 8),
        const SizedBox(width: 3),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppStyles.infoRowText),
            const SizedBox(height: 3),
            Text(value is DateTime ? AppUtils.formatTime(value) : '$value°C',
                style: AppStyles.infoRowValueText),
          ],
        ),
      ],
    );
  }

  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/5.png');
      case == 800:
        return Image.asset('assets/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/7.png');
      default:
        return Image.asset('assets/7.png');
    }
  }

  Widget _buildSquareContainer(
      BuildContext context, Color color, double dx, double dy) {
    return Positioned(
      top: HomeScreen.kToolbarHeightMultiplier * kToolbarHeight * 2 + dy * 100,
      left: MediaQuery.of(context).size.width / 2 + dx * 100,
      child: Container(
          height: 300, width: 300, decoration: BoxDecoration(color: color)),
    );
  }

  String getTitleIcon(String title) {
    switch (title.toLowerCase()) {
      case 'sunrise':
        return '11';
      case 'sunset':
        return '12';
      case 'temp max':
        return '13';
      case 'temp min':
        return '14';
      default:
        return '7';
    }
  }

  String _getGreeting() {
    final currentTime = DateTime.now();
    final currentHour = currentTime.hour;

    if (currentHour < 12) {
      return 'Good Morning';
    } else if (currentHour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }
}
