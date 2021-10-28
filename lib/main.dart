import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> offsetAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    offsetAnimation = Tween<double>(begin: 550, end: 250).animate(
      CurvedAnimation(parent: controller, curve: Curves.decelerate),
    )..addListener(() {
        setState(() {});
      });
    // offsetAnimation = Tween<Offset>(
    //         begin: const Offset(0.55, 0.0), end: const Offset(0.00, 0.0))
    //     .animate(
    //   CurvedAnimation(parent: controller, curve: Curves.decelerate),
    // );
    // Future.delayed(const Duration(milliseconds: 500)).then((value) => controller
    //     .forward()
    //     .then((value) => Future.delayed(const Duration(seconds: 1))
    //         .then((value) => controller.reverse())));
    // controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: () {
              controller.forward();
            },
            child: CustomPaint(
              painter: OvalShape(offsetAnimation.value),
              child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.34,
                  width: MediaQuery.of(context).size.width * 0.47,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          controller.reverse();
                        },
                        icon: const Icon(
                          Icons.cancel_sharp,
                          color: Color.fromRGBO(58, 44, 154, 1),
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
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero)),
                            onPressed: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color.fromRGBO(58, 44, 154, 1),
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
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class OvalShape extends CustomPainter {
  final double x;

  OvalShape(this.x);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = const Color.fromRGBO(132, 206, 252, 1);
    canvas.drawOval(Rect.fromLTRB(x * 0.6, 400, x * 4, 800), paint);
  }

  @override
  bool shouldRepaint(OvalShape oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(OvalShape oldDelegate) => false;
}
