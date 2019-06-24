import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:flutter/material.dart';

class BarcodeScannerScreen extends StatefulWidget {
  @override
  _BarcodeScannerScreenState createState() => new _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  QRReaderController controller;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    var cameras = await availableCameras();

    controller = new QRReaderController(
        cameras[0], ResolutionPreset.medium, [CodeFormat.ean13],
        (dynamic value) {
      Navigator.pop(context, value);
    });
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      controller.startScanning();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return new Container();
    }
    return new AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: new QRReaderPreview(controller));
  }
}
