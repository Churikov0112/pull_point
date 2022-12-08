import 'package:flutter/material.dart' show MaterialPageRoute;
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:flutter/widgets.dart';

import '../../../../artist/artist_guest_screen.dart';

class QrReaderScreen extends StatefulWidget {
  const QrReaderScreen({Key? key}) : super(key: key);

  @override
  State<QrReaderScreen> createState() => _QrReaderScreenState();
}

class _QrReaderScreenState extends State<QrReaderScreen> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    cameraController.start();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("cameraController.hashCode ${cameraController.hashCode}");
    return MobileScanner(
      controller: cameraController,
      allowDuplicates: false,
      onDetect: (barcode, args) {
        if (barcode.rawValue == null) {
          debugPrint('Failed to scan Barcode');
        } else {
          final String code = barcode.rawValue!;
          debugPrint('Barcode found! $code');
          // Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) => ArtistGuestScreen()));
          cameraController.stop();
        }
      },
    );
  }
}
