import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_altruism_assignment/pages/home_page.dart';
import 'package:system_altruism_assignment/providers/api_service_provider.dart';
import 'package:system_altruism_assignment/providers/selected_image_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ApiServiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectedImageProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

