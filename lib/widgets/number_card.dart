import 'package:flutter/material.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({
    required this.index,
    required this.imageUrl,
    super.key,
  });

  final int index;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              const SizedBox(width: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 110,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Positioned(
            left: -20,
            bottom: -27,
            child: BorderedText(
              text: '${index + 1}',
            ),
          ),
        ],
      ),
    );
  }
}

class BorderedText extends StatelessWidget {
  const BorderedText({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.white, Colors.grey],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(bounds),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}
