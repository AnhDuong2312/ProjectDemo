import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:icorp_print_ticket/pages/camera/text_detector_painter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import '../../common/mixins/controller_mixin.dart';
import 'flutter_camera_overlay.dart';
import 'model.dart';
import 'overlay_shape.dart';

class LicenceCameraOverlay extends StatefulWidget {
  const LicenceCameraOverlay({Key? key}) : super(key: key);

  @override
  _LicenceCameraOverlayState createState() => _LicenceCameraOverlayState();
}

class _LicenceCameraOverlayState extends State<LicenceCameraOverlay> {
  final TextRecognizer _textRecognizer = TextRecognizer();
  OverlayFormat format = OverlayFormat.normal;
  late Uint8List imageFile;
  CardOverlay? _overlay;
  String? _text;

  File? fileOrigin;
  File? fileScreenShot;
  ScreenshotController screenshotController = ScreenshotController();
  ImageProvider imageProvider = FileImage(File(''));
  double zoomIn = 1.0;

  void loadImage() {
    imageProvider = FileImage(fileOrigin!);

    final stream = imageProvider.resolve(const ImageConfiguration());
    stream.addListener(ImageStreamListener((image, synchronousCall) {
      if (mounted) {
        screenshotController
            .capture(delay: const Duration(milliseconds: 300))
            .then((image) async {
          imageFile = image!;
          final tempDir = await getTemporaryDirectory();
          final File fileCurrent = await File(
                  '${tempDir.path}/image${DateTime.now().toIso8601String()}.jpg')
              .create();
          fileCurrent.writeAsBytesSync(imageFile);

          setState(() {
            fileScreenShot = File(fileCurrent.path);
          });
          var result = InputImage.fromFile(fileScreenShot!);
          processImage(result);
        }).catchError((onError) {
          throw onError;
        });
      }
    }));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_overlay != null)
          SizedBox(
              width: double.infinity,
              child: Screenshot(
                controller: screenshotController,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Transform.scale(
                      scale: zoomIn,
                      child: Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    OverlayShape(
                        CardOverlay.byFormat(OverlayFormat.normalColorBlack)),
                  ],
                ),
              ))
        else
          const SizedBox(),
        FutureBuilder<List<CameraDescription>?>(
          future: availableCameras(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Loading',
                      style: TextStyle(color: Colors.black),
                    ));
              }
              return CameraOverlay(
                snapshot.data!.first,
                CardOverlay.byFormat(format),
                (XFile file, double zoomInCamera) async {
                   ControllerMixin().showLoading();
                  CardOverlay overlay = CardOverlay.byFormat(format);
                  setState(() {
                    _overlay = overlay;
                    zoomIn = zoomInCamera;
                    fileOrigin = File(file.path);
                  });
                  loadImage();
                },
              );
            } else {
              return const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Fetching cameras',
                    style: TextStyle(color: Colors.black),
                  ));
            }
          },
        ),
      ],
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    setState(() {
      _text = '';
    });
    final recognizedText = await _textRecognizer.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      TextRecognizerPainter(recognizedText, inputImage.metadata!.size,
          inputImage.metadata!.rotation);
    } else {
      var newText = recognizedText.text.split("\n");
      var textResult = "";
      for (var element in newText) {
        textResult += element.trim();
      }
      setState(() {
        _text = textResult;
        if (_text != "") {
          Get.back(result: {"data": _text});
          ControllerMixin().hideLoading();
        }
      });
    }
    if (mounted) {
      setState(() {});
    }
  }
}
