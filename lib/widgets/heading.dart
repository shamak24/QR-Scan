import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Heading extends StatelessWidget {
  const Heading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Hindi Club",
        style: TextStyle(
          fontSize: 30,
          color: Theme.of(context).colorScheme.primary,
          fontFamily: GoogleFonts.inter(fontWeight: FontWeight.bold).fontFamily,
        ),
      ),
      subtitle: Text(
        "QR Scanner App",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 20,
          fontFamily: GoogleFonts.inter().fontFamily,
        )
      ),
      leading: CircleAvatar(
        radius: 37.5,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(
          Icons.qr_code_scanner,
          size: 45,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
