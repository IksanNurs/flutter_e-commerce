import 'dart:io';

// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  // CameraController? controller;

  // Future<void> initialCamera() async{
  //   var cameras = await availableCameras();
  //   controller = CameraController(
  //     cameras[0],
  //     ResolutionPreset.medium
  //   );
  //   await controller!.initialize();
  // }

  // @override
  // void dispose() {
  //   controller!.dispose();
  //   super.dispose();
  // }

  // Future<File> takePicture() async{
  //   Directory root = await getTemporaryDirectory();
  //   String directoryPath = '${root.path}/Guided_Camera';
  //   await Directory(directoryPath).create(recursive: true);
  //   String filePath = '$directoryPath/${DateTime.now()}.jpg';
  //   try{
  //     await controller!.takePicture(filePath);
  //   }
  //   catch(e){
  //     return null!;
  //   }

  //   return File(filePath);
  // }

 
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}