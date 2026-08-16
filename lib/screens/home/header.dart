import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class Header extends StatelessWidget {
  const Header();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hi, \ud83d\udc4b',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              SizedBox(height: 2),
              Text("Let's ace your next interview!",
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }
}
