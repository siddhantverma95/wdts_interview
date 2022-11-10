import 'dart:io';

import 'package:flutter/material.dart';
import 'package:interview_qr/view_model.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key, this.endpoint}) : super(key: key);

  final String? endpoint;

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  static const qrDebuglabel = 'qr_debug';
  final GlobalKey qrKey = GlobalKey(debugLabel: qrDebuglabel);
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 3,
            child: Consumer<ViewModel>(
              builder: (context, items, child) {
                if (items.items.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(items.items[index].description),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    if (widget.endpoint == null) {
      controller.scannedDataStream.listen((scanData) {
        debugPrint('QR DATA: ${scanData.code}');
        Provider.of<ViewModel>(context, listen: false).add(scanData.code ?? '');
      });
    } else {
      Provider.of<ViewModel>(context, listen: false).add(widget.endpoint ?? '');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
