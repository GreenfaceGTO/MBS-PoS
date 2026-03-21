import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptydataElement extends StatelessWidget {
  const EmptydataElement({super.key, this.caption = "Belum ada data"});
  final String caption;
  @override
  Widget build(BuildContext context) {
    TextTheme tema = TextTheme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.database,
            size: 50,
            color: Colors.grey.shade300,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            caption,
            style: tema.bodyMedium!.copyWith(fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
