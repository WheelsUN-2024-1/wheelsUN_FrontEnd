import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(CurvedAnimation(
        parent: _controller,
        curve:
            Curves.easeInOut)); // Use an ease-in-out curve for a smooth effect

    _controller.forward(); // Start the animation a single time
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xFF68BB92),
        title: const Text(
          'Wheels UN',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Divider(
            color: Colors.black12,
            thickness: 2,
            height: 2,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido!', style: TextStyle(fontSize: 36)),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => Transform.scale(
                scale: _animation.value,
                child: child,
              ),
              child: ClipOval(
                child:
                    Image.asset('lib/images/car.png', width: 300, height: 300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}