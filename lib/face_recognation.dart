// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:tflite/tflite.dart';

// class ImageClassificationPage extends StatefulWidget {
//   @override
//   _ImageClassificationPageState createState() =>
//       _ImageClassificationPageState();
// }

// class _ImageClassificationPageState extends State<ImageClassificationPage> {
//   late CameraController _cameraController;
//   late List<CameraDescription> _cameras;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//     _loadModel();
//   }

//   void _initializeCamera() async {
//     _cameras = await availableCameras();
//     _cameraController = CameraController(_cameras[0], ResolutionPreset.high);
//     await _cameraController.initialize();

//     setState(() {});
//   }

//   void _loadModel() async {
//     await Tflite.loadModel(
//       model: 'assets/model_unquant.tflite',
//       labels: 'assets/labels.txt',
//     );
//   }

//   void _classifyImage(CameraImage cameraImage) async {
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
//       // Process classification results
//       // Example: Display results or update state based on classification
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_cameraController.value.isInitialized) {
//       return Container();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Classification'),
//       ),
//       body: CameraPreview(_cameraController),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (_cameraController != null &&
//               _cameraController.value.isInitialized) {
//             // _cameraController.startImageStream((CameraImage cameraImage) {
//               _classifyImage(cameraImage);
//             });
//           }
//         },
//         child: Icon(Icons.camera),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     Tflite.close();
//     super.dispose();
//   }
// }
