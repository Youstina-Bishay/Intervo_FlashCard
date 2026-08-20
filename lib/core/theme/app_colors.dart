import 'package:flutter/material.dart';

/// Centralized color palette matching the purple/indigo gradient design
/// used across the app (cards, tracks, buttons, streaks).
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF7C3AED);
  static const Color primaryDark = Color(0xFF5B21B6);
  static const Color primaryLight = Color(0xFFA78BFA);

  static const List<Color> primaryGradient = [
    Color(0xFF8B5CF6),
    Color(0xFF6D28D9),
  ];

  static const List<Color> heroGradient = [
    Color(0xFF894FF9),
    Color(0xFFAF8EF1),
  ];

  static const Color background = Color(0xFFF5F4FC);
  static const Color surface = Colors.white;
  static const Color cardBorder = Color(0xFFEDE9F7);

  static const Color textPrimary = Color(0xFF1E1B2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);
//Tracks colors
  static const Color frontend = Color(0xFF058D60);
  static const Color backend = Color(0xFF6366F1);
  static const Color flutter = Color(0xFF05A7DB);
  static const Color devops = Color(0xFF7523D9);

  static const Color authentication = Color(0xFFEF4444);
  static const Color docker = Color(0xFF3B82F6);
  static const Color linux = Color(0xFF8B5CF6);

  static const Color sql = Color(0xFF06B6D4);
  static const Color normalization = Color(0xFFF59E0B);
  static const Color joins = Color(0xFF22C55E);
  static const Color indexes = Color(0xFF6366F1);
  static const Color transactions = Color(0xFFEC4899);
  static const Color git = Color(0xFF64748B);
  static const Color cicd = Color(0xFF22C55E);
  static const Color kubernetes = Color(0xFF6366F1);
  static const Color iac = Color(0xFF8B5CF6);
  static const Color scalability = Color(0xFF22C55E);
  static const Color caching = Color(0xFF06B6D4);
  static const Color loadBalancing = Color(0xFFF59E0B);

  static const Color success = Color(0xFF22C55E);
  static const Color danger = Color(0xFFEF4444);
  static const Color streak = Color(0xFFF97316);
  static const Color accuracy = Color(0xFFFACC15);
  static const Color studied = Color(0xFF3B82F6);

  static Color trackColor(String key) {
    switch (key.toLowerCase()) {
      case 'flutter':
        return flutter;
      case 'frontend':
        return frontend;
      case 'backend':
        return backend;
      case 'rest_api':
        return backend;
      case 'database':
      case 'sql':
      case 'sql_basics':
        return sql;
      case 'normalization':
        return normalization;
      case 'joins':
        return joins;
      case 'indexes':
        return indexes;
      case 'transactions':
        return transactions;;
      case 'authentication':
        return authentication;
      case 'docker':
        return docker;
      case 'kubernetes':
        return kubernetes;
      case 'linux':
        return linux;
      case 'devops':
        return devops;
      case 'git':
        return git;
      case 'ci_cd':
        return cicd;
      case 'iac':
        return iac;
      case 'scalability':
        return scalability;
      case 'caching':
        return caching;
      case 'load_balancing':
        return loadBalancing;
      default:
        return primary;
    }
  }
}
