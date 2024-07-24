import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final bool isMultiLine;

  const StyledText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.isMultiLine = false,
  });

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: fontSize ?? 14,
            color: color,
            fontWeight: fontWeight,
          ),
        ),
        overflow: isMultiLine ? TextOverflow.ellipsis : TextOverflow.visible,
        maxLines: isMultiLine ? 4 : null,
      );
}
