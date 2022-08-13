import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TweenAnimationBuilder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _columnChildren = [];

  @override
  initState() {
    super.initState();
    addChildren();
  }

  void addChildren() async {
    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      if (i == 0) {
        _columnChildren.add(const SliderWidget(
            child: CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 100,
          child: Text(
            "DV",
            style: TextStyle(
                color: Colors.orange,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        )));
      } else {
        _columnChildren.add(SliderWidget(
          child: Text("Widget Number ${i + 1}",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
        ));
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _columnChildren),
      ),
    );
  }
}

class SliderWidget extends StatelessWidget {
  const SliderWidget(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 700)})
      : super(key: key);
  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      curve: Curves.easeIn,
      tween: Tween<Offset>(begin: const Offset(0, 64), end: const Offset(0, 0)),
      duration: duration,
      child: TweenAnimationBuilder<double>(
        tween: Tween(
          begin: 0,
          end: 1,
        ),
        duration: duration,
        builder: (_, value, child) {
          return Opacity(
            child: child,
            opacity: value,
          );
        },
        child: child,
      ),
      builder: (context, offsetValue, child) {
        return Transform.translate(offset: offsetValue, child: child!);
      },
    );
  }
}
