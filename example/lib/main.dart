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

  // We define a controller here to keep the same scroll offset while
  // switching between the classic version and the animated version
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SmoothListView.adaptiveSeparated(
            controller: controller,
            smoothScroll: smooth,
            scrollDirection: Axis.vertical,
            duration: const Duration(milliseconds: 400),
            itemCount: 50,
            itemBuilder: (ctx, idx) {
              return Container(
                height: 200,
                width: 200,
                color: colorList[idx % colorList.length],
              );
            },
            separatorBuilder: (ctx, idx) {
              return Container(
                height: 10,
                width: 100,
                color: Colors.black,
              );
            }),
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
