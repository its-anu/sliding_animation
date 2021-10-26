import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    offsetAnimation =
        Tween<Offset>(begin: const Offset(0, 0.0), end: const Offset(0.55, 0.0))
            .animate(
      CurvedAnimation(parent: controller, curve: Curves.decelerate),
    );
    controller.repeat(reverse: true);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SlideTransition(
              position: offsetAnimation,
              child: GestureDetector(
                onTap: () {
                  controller.reverse();
                },
                child: CustomPaint(
                  painter: OvalShape(),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 230,
                      width: 170,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.forward();
                            },
                            icon: const Icon(
                              Icons.cancel,
                              size: 20,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Got a problem?',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Just take a screenshot and share it with us',
                                style: TextStyle(fontSize: 14),
                                maxLines: 2,
                              ),
                              TextButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero)),
                                onPressed: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        left: 40, right: 40, top: 8, bottom: 8),
                                    child: Text(
                                      'Tell Us',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                          const SizedBox(height: 40)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

class OvalShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blue;
    canvas.drawOval(const Rect.fromLTRB(150, 470, 700, 730), paint);
  }

  @override
  bool shouldRepaint(OvalShape oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(OvalShape oldDelegate) => false;
}
