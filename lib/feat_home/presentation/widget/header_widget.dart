import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Halo selamat datang,',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            Text(
              'PinPoint',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: Colors.blue[100],
          radius: 20,
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}