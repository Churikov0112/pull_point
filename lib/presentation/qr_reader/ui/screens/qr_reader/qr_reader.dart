import 'dart:convert';

import 'package:flutter/material.dart' show MaterialPageRoute;
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:flutter/widgets.dart';

import '../../../../../data/http_requests/artist/get_artists.dart';
import '../../../../../data/http_requests/backend_config/backend_config.dart';
import '../../../../../domain/models/models.dart';
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
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return MobileScanner(
      controller: cameraController,
      allowDuplicates: false,
      onDetect: (barcode, args) async {
        if (barcode.rawValue != null) {
          final String code = barcode.rawValue!;

          if (code.contains("${BackendConfig.baseUrl}/artist/")) {
            final response = await GetArtistsRequest.send(
              search: code.replaceAll("${BackendConfig.baseUrl}/artist/", ""),
              categoryId: null,
              subcategoryIds: null,
            );
            String source = const Utf8Decoder().convert(response.bodyBytes);
            final decodedResponse = jsonDecode(source);
            if ((decodedResponse as List).isNotEmpty) {
              final artist = ArtistModel.fromJson((decodedResponse).first);
              if (response.statusCode == 200) {
                navigator.push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ArtistGuestScreen(artist: artist),
                  ),
                );
              }
            }
          }
        }
      },
    );
  }
}
