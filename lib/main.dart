import 'package:flutter/material.dart';

void main() {
  runApp(const CounterImageToggleApp());
}

class CounterImageToggleApp extends StatelessWidget {
  const CounterImageToggleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _counter = 0;
  bool _isDark = false;
  bool _isFirstImage = true;

  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.value = 1.0; // start visible
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() => _counter++);
  }

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  Future<void> _toggleImage() async {
    await _controller.reverse(); // fade out
    setState(() => _isFirstImage = !_isFirstImage);
    await _controller.forward(); // fade in
  }

  Color _getCounterColor() {
    if (_counter < 10) return Colors.green;
    if (_counter < 20) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CW1 Counter & Toggle',
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,

      // Builder ensures Theme.of(context) is under this MaterialApp
      home: Builder(
        builder: (context) {
          final baseStyle = Theme.of(context).textTheme.headlineMedium ??
              const TextStyle(fontSize: 28);

          return Scaffold(
            appBar: AppBar(
              title: const Text('CW1 Counter & Toggle'),
              actions: [
                IconButton(
                  onPressed: _toggleTheme,
                  icon: Icon(_isDark ? Icons.light_mode : Icons.dark_mode),
                  tooltip: _isDark ? 'Light mode' : 'Dark mode',
                ),
              ],
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated color change for the counter text
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    style: baseStyle.copyWith(
                      color: _getCounterColor(),
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text('Counter: $_counter'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Text('Increment'),
                  ),
                  const SizedBox(height: 24),
                  FadeTransition(
                    opacity: _fade,
                    child: Image.asset(
                      _isFirstImage ? 'assets/image1.png' : 'assets/image2.png',
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
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
        },
      ),
    );
  }
}
