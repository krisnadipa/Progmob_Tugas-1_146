import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Category extends StatelessWidget {
  final iconName;
  final String title;
  final VoidCallback onCLickButton;
  const Category({
    Key? key,
    required this.iconName,
    required this.title,
    required this.onCLickButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 75,
          height: 72,
          child: Column(
            children: [
              // Image.asset(
              //   iconName,
              //   width: 30,
              // ),
              Icon(iconName),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: onCLickButton,
                child: Text(
                  title,
                  style: GoogleFonts.montserrat(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
