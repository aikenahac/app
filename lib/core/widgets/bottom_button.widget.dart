import 'package:flutter/material.dart';
import 'package:coinseek/utils/assets.util.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outline = true,
  }) : super();

  final String label;
  final Function() onPressed;
  final bool outline;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: 55.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: AppAssets.colors.black,
          shape: outline
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  side: BorderSide(
                    color: AppAssets.colors.whiteFaded,
                    width: 0.5,
                  ),
                )
              : null,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: AppAssets.colors.whiteFaded,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
