import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyWidget extends StatelessWidget {
  final String message;

  const EmptyWidget({
    super.key,
    this.message = 'Data tidak ada, silahkan tambahkan terlebih dahulu',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SVG Image
          const SizedBox(height: 32),
          SvgPicture.asset(
            'assets/images/ic_empty.svg',
            height: 150,
            placeholderBuilder: (context) => const CircularProgressIndicator(),
            errorBuilder: (context, error, stackTrace) {
              print('Error loading SVG: $error');
              return const Icon(Icons.error, color: Colors.red);
            },
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}