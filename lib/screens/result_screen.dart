import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrscan/screens/qr_scanner.dart';
import 'package:qrscan/utils/sync_db.dart';

class ResultScreen extends StatelessWidget {
  final String result;
  const ResultScreen({super.key, required this.result});


  @override
  Widget build(BuildContext context) {
    final student = getStudentByRegNo(result.toString().trim().toUpperCase());

    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Scan Result",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 30,
                fontFamily: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                ).fontFamily,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              student != null
                  ? "Name: ${student.name}\nReg No: ${student.regNo}\nEmail: ${student.email}"
                  : "No student found with Reg No: $result",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 20,
                fontFamily: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                ).fontFamily,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
                      return const QrScanner();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text("Scan Again"),
                ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text("Go Home"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
