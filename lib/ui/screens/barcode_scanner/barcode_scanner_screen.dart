import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:flutter/material.dart';

class BarcodeScannerScreen extends StatelessWidget {
  const BarcodeScannerScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BarcodeScannerScreenContent(),
    );
  }
}

class BarcodeScannerScreenContent extends StatefulWidget {
  @override
  _BarcodeScannerScreenContentState createState() =>
      new _BarcodeScannerScreenContentState();
}

class _BarcodeScannerScreenContentState
    extends State<BarcodeScannerScreenContent> {
  QRReaderController controller;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() async {
    var cameras = await availableCameras();

    if (cameras.length == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Une erreur est survenue'),
                content:
                    Text('Aucune caméra n\'est accessible sur le téléphone.'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('OK'),
                      onPressed: () {
                        var navigator = Navigator.of(context);
                        // Close the dialog
                        navigator.maybePop();
                        // Close the screen
                        navigator.maybePop();
                      })
                ],
              ));
    } else {
      controller = new QRReaderController(
          cameras[0], ResolutionPreset.high, [CodeFormat.ean13],
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
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    } else {
      var mediaQuery = MediaQuery.of(context);
      var screenSize = mediaQuery.size;
      var padding = mediaQuery.padding;
      var previewSize = controller.value.previewSize;
      var aspectRatio = (screenSize.height - padding.top - padding.bottom) /
          previewSize.height;

      var height = screenSize.height * aspectRatio;

      return Center(
        child: Transform.scale(
          scale: screenSize.height / height,
          child: SizedBox(
            height: height,
            child: QRReaderPreview(controller),
          ),
        ),
      );
    }
  }
}
