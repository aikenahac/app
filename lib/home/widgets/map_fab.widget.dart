import 'package:flutter/material.dart';

class MapFabWidget extends StatelessWidget {
  const MapFabWidget({
    super.key,
    required this.child,
    required this.alignment,
    required this.onTap,
  });

  final Widget child;
  final AlignmentGeometry alignment;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: alignment,
        child: GestureDetector(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
