import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_notifier.dart';

class ThemeToggleButton extends StatefulWidget {
  const ThemeToggleButton({super.key});

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 0.5, // half rotation
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleTheme(bool isDark) {
    if (isDark) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    context.read<ThemeNotifier>().toggleTheme(isDark);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();

    return GestureDetector(
      onTap: () => _toggleTheme(!themeNotifier.isDarkMode),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 3.1416 * 2, // rotate smoothly
            child: child,
          );
        },
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: themeNotifier.isDarkMode
                ? Colors.grey[800]
                : Colors.yellow[600],
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(
            themeNotifier.isDarkMode ? Icons.nights_stay : Icons.wb_sunny,
            color: themeNotifier.isDarkMode ? Colors.white : Colors.yellow[900],
            size: 24,
          ),
        ),
      ),
    );
  }
}
