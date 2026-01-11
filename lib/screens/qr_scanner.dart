import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text('Simple Mobile Scanner')),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _handleBarcode),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Center(child: Text("Scan Barcode"))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}