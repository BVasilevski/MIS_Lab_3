import 'package:flutter/material.dart';
import 'package:lab_2/provider/FavoriteJokeProvider.dart';
import 'package:lab_2/screens/home.dart';
import 'package:lab_2/services/notification_service.dart';
import 'package:provider/provider.dart';

void main() {
  NotificationService notificationService = NotificationService();
  notificationService.initNotifications();
  notificationService.scheduleNotification(
      id: 1,
      title: "Daily Notification",
      body: "Your daily reminder to see the joke of the day!",
      hour: 11,
      minute: 30);
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteJokesProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Joke App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
