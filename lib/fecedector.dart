// import 'package:fece_recognisition/detact_suces.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:camera/camera.dart';
// import 'package:tflite/tflite.dart';

// class FaceDetectionPage extends StatefulWidget {
//   @override
//   _FaceDetectionPageState createState() => _FaceDetectionPageState();
// }

// class _FaceDetectionPageState extends State<FaceDetectionPage> {
//   late CameraController? _cameraController;
//   late FaceDetector _faceDetector;
//   bool _isDetecting = false;
//   bool _isCameraInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//     _faceDetector = GoogleMlKit.vision.faceDetector();
//   }

//   void _initializeCamera() async {
//     try {
//       final cameras = await availableCameras();
//       final frontCamera = cameras.firstWhere(
//         (camera) => camera.lensDirection == CameraLensDirection.front,
//       );

//       _cameraController = CameraController(frontCamera, ResolutionPreset.high);
//       await _cameraController!.initialize();

//       _cameraController!.startImageStream((image) {
//         if (!_isDetecting) {
//           _isDetecting = true;
//           _isCameraInitialized = true;

//           final WriteBuffer allBytes = WriteBuffer();
//           for (Plane plane in image.planes) {
//             allBytes.putUint8List(plane.bytes);
//           }
//           final bytes = allBytes.done().buffer.asUint8List();

//           final inputImage = InputImage.fromBytes(
//             bytes: bytes,
//             metadata: InputImageMetadata(
//               size: Size(image.width.toDouble(), image.height.toDouble()),
//               rotation: _rotationIntToImageRotation(
//                   _cameraController!.description.sensorOrientation),
//               format: _inputImageFormatFromRawValue(image.format.raw),
//               bytesPerRow: image.planes.first.bytesPerRow,
//             ),
//           );

//           _faceDetector.processImage(inputImage).then((faces) {
//             if (faces.isNotEmpty) {
//               // Do something with the detected faces
//               print("Detected ${faces.length} faces");
//               _cameraController!.dispose();
//               _faceDetector.close();
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => FaceDetectSucess()));
//             }
//             _isDetecting = false;
//           }).catchError((e) {
//             print(e);
//             _isDetecting = false;
//           });
//         }
//       });

//       setState(() {});
//     } catch (e) {
//       print('Error initializing camera: $e');
//       // Handle initialization error as needed
//     }
//     // final cameras = await availableCameras();
//     // final frontCamera = cameras.firstWhere(
//     //   (camera) => camera.lensDirection == CameraLensDirection.front,
//     // );

//     // _cameraController = CameraController(frontCamera, ResolutionPreset.high);
//     // await _cameraController.initialize();

//     setState(() {});
//   }

//   InputImageRotation _rotationIntToImageRotation(int rotation) {
//     switch (rotation) {
//       case 90:
//         return InputImageRotation.rotation90deg;
//       case 180:
//         return InputImageRotation.rotation180deg;
//       case 270:
//         return InputImageRotation.rotation270deg;
//       case 0:
//       default:
//         return InputImageRotation.rotation0deg;
//     }
//   }

//   InputImageFormat _inputImageFormatFromRawValue(int rawFormat) {
//     switch (rawFormat) {
//       case 17:
//         return InputImageFormat.nv21;
//       case 35:
//         return InputImageFormat.yuv420;
//       case 842094169:
//         return InputImageFormat.yv12;
//       default:
//         throw UnsupportedError('Unsupported image format: $rawFormat');
//     }
//   }

//   void _recognizeFace(CameraImage cameraImage) async {
//     var recognitions = await Tflite.runModelOnFrame(
//       bytesList: cameraImage.planes.map((plane) {
//         return plane.bytes;
//       }).toList(),
//       imageHeight: cameraImage.height,
//       imageWidth: cameraImage.width,
//       imageMean: 127.5,
//       imageStd: 127.5,
//       rotation: 90,
//       numResults: 2,
//     );

//     setState(() {
//       // Process recognition results
//       // Example: Display results or update state based on recognition
//     });
//   }

//   @override
//   void dispose() {
//     _cameraController!.dispose();
//     _faceDetector.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Face Detection'),
//       ),
//       body: _isCameraInitialized
//           ? Center(child: CircularProgressIndicator())
//           : CameraPreview(_cameraController!),
//     );
//   }
// }
