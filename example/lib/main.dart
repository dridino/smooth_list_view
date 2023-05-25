import 'package:flutter/material.dart';
import 'package:smooth_list_view/smooth_list_view.dart';

const List<Color> colorList = [Colors.red, Colors.blue, Colors.green];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool smooth = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SmoothListView.builder(
          smoothScroll: smooth,
          duration: const Duration(milliseconds: 400),
          itemBuilder: (ctx, idx) {
            return Container(
              height: 200,
              width: 200,
              color: colorList[idx % colorList.length],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(smooth ? Icons.toggle_on : Icons.toggle_off),
          onPressed: () {
            setState(() {
              smooth = !smooth;
            });
          },
        ),
      ),
    );
  }
}
