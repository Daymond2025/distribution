import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  final bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        iconTheme: const IconThemeData(
          color: colorblack,
        ),
        title: const Text(
          'Proprosition  de prix',
          maxLines: 1,
          style: TextStyle(
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  GestureDetector kCardCloneProduct() => GestureDetector(
        onTap: () {},
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: NetworkImage('')),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
