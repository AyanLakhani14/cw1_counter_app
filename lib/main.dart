import 'package:flutter/material.dart';

void main() {
  runApp(const CounterImageToggleApp());
}

class CounterImageToggleApp extends StatelessWidget {
  const CounterImageToggleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CW1 Counter & Toggle',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  bool _isFirstImage = true;

  void _incrementCounter() {
    setState(() => _counter++);
  }

  void _toggleImage() {
    setState(() => _isFirstImage = !_isFirstImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CW1 Counter & Toggle')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Counter: $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('Increment'),
            ),
            const SizedBox(height: 24),
            Image.asset(
              _isFirstImage ? 'assets/image1.png' : 'assets/image2.png',
              width: 180,
              height: 180,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _toggleImage,
              child: const Text('Toggle Image'),
            ),
          ],
        ),
      ),
    );
  }
}
