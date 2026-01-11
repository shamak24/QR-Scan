import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrscan/screens/result_screen.dart';

class QrScanner extends StatefulWidget {
  /// Constructor for simple Mobile Scanner example
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  Barcode? _barcode;
  late final MobileScannerController _controller;
  // bool _isScanning = false;

  @override
  void initState() {
    super.initState();

    _controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
      facing: CameraFacing.back,
    );
  }

  @override
  Future<void> dispose() async {
    await _controller.dispose();
    super.dispose();
  }

  void _barcodePreview(Barcode? value) {
    if (value != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ResultScreen(result: value.rawValue ?? "No data");
      }));
    }
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
      _controller.stop();
      _barcodePreview(_barcode);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hindi Club', style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontSize: 20,
        color: Theme.of(context).colorScheme.primary,
         fontFamily: GoogleFonts.inter(fontWeight: FontWeight.bold).fontFamily),),
      foregroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _handleBarcode,
          ),
          // Overlay with scanning frame
          Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
        ),
        child: Stack(
          children: [
            // Center scanning area with corner borders
            Center(
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(
            color: Colors.transparent,
            width: 2,
              ),
            ),
            child: Stack(
              children: [
            // Top-left corner
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Theme.of(context).colorScheme.primary, width: 4),
                left: BorderSide(color: Theme.of(context).colorScheme.primary, width: 4),
              ),
                ),
              ),
            ),
            // Top-right corner
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Theme.of(context).colorScheme.primary, width: 4),
                right: BorderSide(color: Theme.of(context).colorScheme.primary, width: 4),
              ),
                ),
              ),
            ),
            // Bottom-left corner
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 4),
                left: BorderSide(color: Theme.of(context).colorScheme.primary, width: 4),
              ),
                ),
              ),
            ),
            // Bottom-right corner
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 4),
                right: BorderSide(color: Theme.of(context).colorScheme.primary, width: 4),
              ),
                ),
              ),
            ),
              ],
            ),
          ),
            ),
            // Clear center area for scanning
            Center(
          child: ClipPath(
            clipper: _ScannerOverlay(),
            child: Container(
              color: Colors.transparent,
            ),
          ),
            ),
          ],
        ),
          ),
          // Bottom instruction panel
          Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 40),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
          Icon(
            Icons.qr_code_scanner,
            size: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 8),
          Text(
            "Align QR Code within frame",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Scanning will happen automatically",
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
            ],
          ),
        ),
          ),
        ],
      ),
    );
  }
}

class _ScannerOverlay extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    
    // Create a hole in the center (250x250 scanning area)
    final scanArea = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: 250,
      height: 250,
    );
    
    path.addRect(scanArea);
    path.fillType = PathFillType.evenOdd;
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}