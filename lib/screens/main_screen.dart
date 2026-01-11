import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrscan/widgets/heading.dart';
import 'package:qrscan/screens/qr_scanner.dart';
import 'package:qrscan/utils/sync_db.dart';
import 'package:qrscan/widgets/sync_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(alignment: Alignment.topLeft, child: Heading()),
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.15),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    child: Icon(
                      Icons.qr_code_scanner,
                      size: 70,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Ready to Scan",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 25,
                      fontFamily: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                      ).fontFamily,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Scan participant QR codes to verify their identity.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 15,
                      fontFamily: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                      ).fontFamily,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                        return const QrScanner();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontFamily: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                        ).fontFamily,
                      ),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                    ),
                    child: const Text("Start Scanning"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.15),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.cloud_sync_sharp,
                      color: Theme.of(context).colorScheme.primary,
                      size: 40,
                    ),
                    title: Text(
                      "Database Sync",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 20,
                        fontFamily: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                        ).fontFamily,
                      ),
                    ),
                    subtitle: Text(
                      "Keep participant data up-to-date.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SyncButton(onSync: syncDatabase),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
