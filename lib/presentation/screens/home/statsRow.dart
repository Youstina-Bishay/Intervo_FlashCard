import 'package:flutter/material.dart';
import 'package:intervo/core/constants/screenSize.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: '🔥',
            value: '12',
            label: 'Day Streak',
            bgColor: Color(0xFFFFF1EC),
          ),
        ),
        SizedBox(width: 3),
        Expanded(
          child: _StatCard(
            icon: '⭐',
            value: '85%',
            label: 'Accuracy',
            bgColor: Color(0xFFFFF8E1),
          ),
        ),
        SizedBox(width: 3),
        Expanded(
          child: _StatCard(
            icon: '📋',
            value: '124',
            label: 'Cards Studied',
            bgColor: Color(0xFFEAF2FF),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final Color bgColor;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: ScreenSize.height(context)*.15,
        width: ScreenSize.width(context)*.17,
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 3),
            Text(
              value,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}