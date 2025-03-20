import 'package:flutter/material.dart';

class ContentLoading extends StatelessWidget {
  const ContentLoading({ super.key });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}