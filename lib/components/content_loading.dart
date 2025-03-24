import 'package:flutter/material.dart';

class ContentLoading extends StatelessWidget {
  final bool isSmall;
  final Color color;

  const ContentLoading({ 
    super.key,
    this.isSmall = false,
    this.color = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: (isSmall) ? 20 : 30,
        height: (isSmall) ? 20 : 30,
        child: CircularProgressIndicator(
          color: color,
        ),
      )
    );
  }
}