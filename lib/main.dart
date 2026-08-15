import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/root_shell.dart';

void main() {
  runApp(const AceItApp());
}

class AceItApp extends StatelessWidget {
  const AceItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AceIt — Interview Prep',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const RootShell(),
    );
  }
}
