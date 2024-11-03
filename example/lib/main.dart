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
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Center(
              child: SizedBox(
                width: constraints.maxWidth * 0.8,
                height: constraints.maxHeight * 0.8,
                child: SmoothListView.builder(
                  smoothScroll: smooth,
                  duration: const Duration(milliseconds: 200),
                  controller: controller,
                  itemCount: 20,
                  itemBuilder: (ctx, idx) {
                    return ListTile(
                      textColor: colorList[idx % colorList.length],
                      onTap: () => debugPrint("pressed $idx"),
                      title: Text("$idx"),
                    );
                  },
                ),
              ),
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
