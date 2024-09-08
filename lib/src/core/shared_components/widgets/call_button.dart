import 'package:flutter/material.dart';

class CallButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CallButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 44.0,
        height: 44.0,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.call,
            color: Colors.white,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}
