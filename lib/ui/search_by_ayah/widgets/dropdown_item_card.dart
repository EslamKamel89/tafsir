import 'package:flutter/material.dart';
import 'package:tafsir/utils/text_styles.dart';

class DropdownItemDisplayCard extends StatelessWidget {
  const DropdownItemDisplayCard({super.key, required this.content});
  final String content;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: DefaultText(content),
      ),
    );
  }
}
