import 'package:flutter/material.dart';

import '../../core/constants/screenSize.dart';
import '../../theme/app_colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height:ScreenSize.height(context)*.06 ,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey,width: 1,),
          borderRadius: BorderRadius.circular(15)
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search topics, e.g. REST API...',
          prefixIcon:
          Icon(Icons.search_rounded, color: AppColors.textMuted),
        ),
      ),
    );
  }
}
