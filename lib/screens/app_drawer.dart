import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_notifier.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),

            _buildItem(
              context,
              icon: Icons.home,
              title: 'Home',
              onTap: () => Navigator.pop(context),
            ),

            _buildItem(
              context,
              icon: Icons.fitness_center,
              title: 'Workouts',
              onTap: () => Navigator.pop(context),
            ),

            _buildItem(
              context,
              icon: Icons.history,
              title: 'Workout History',
              onTap: () {
                // Navigate later
                Navigator.pop(context);
              },
            ),

            const Spacer(),
            const Divider(),

            const Divider(),

            _buildItem(
              context,
              icon: Icons.settings,
              title: 'Settings',
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Drawer Header
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(radius: 30, child: Icon(Icons.person, size: 32)),
          const SizedBox(height: 12),
          Text(
            'Personal Gym',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            'Train. Track. Improve.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // 🔹 Drawer Item
  Widget _buildItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }
}
