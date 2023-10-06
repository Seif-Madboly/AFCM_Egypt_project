import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:tflite/tflite.dart';

import '../main.dart';
import '../screens/ResultScreen.dart';

class HomeController extends GetxController{
  RxBool _loading = true.obs;
  Rx<File> _image = File('').obs;
  RxList<dynamic> predictions = <dynamic>[].obs;
  RxBool isWorking = false.obs;
  RxString result = ''.obs;
  CameraController? cameraController;
  CameraImage? cameraImage;
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadModel();
  }

  File applyGrayscaleFilter(File inputImage) {
    final image = img.decodeImage(inputImage.readAsBytesSync())!;
    final grayscaleImage = img.grayscale(image);

    final filteredImage =
    File(inputImage.path.replaceAll('.jpg', '_grayscale.jpg'))
      ..writeAsBytesSync(img.encodeJpg(grayscaleImage));

    return filteredImage;
  }

  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController?.initialize().then((value) {
      if (!Get.isRegistered<HomeController>()) {
        return;
      }

        cameraController?.startImageStream((imageFromStream) {
          if (!isWorking.value) {
            isWorking.value = true;
            cameraImage = imageFromStream;
            runModelOnFrame();
          }
        });

    });
  }

  loadImageGallery() async {
    var imagePicker = ImagePicker();

    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      final filteredImage = applyGrayscaleFilter(File(image.path));
      _image.value = filteredImage;
    }
    runModelImage(_image.value);
    Get.to(() => ResultScreen(image: _image.value, predictions: predictions));
  }

  loadImageCamera() async {
    var imagePicker = ImagePicker();

    var image = await imagePicker.pickImage(source: ImageSource.camera,
        imageQuality: 100
    );
    if (image == null) {
      return null;
    } else {
      _image.value = File(image.path);
    }
    runModelImage(_image.value);
    Get.to(() => ResultScreen(image: _image.value, predictions: predictions));
  }



  runModelImage(File image) async {
    var prediction = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 3,
        threshold: .7,
        imageStd: 100,
        imageMean: 100);


      _loading.value = false;
    predictions.assignAll(prediction!);

  }

  runModelOnFrame() async {
    if (cameraImage != null) {
      var recognition = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,

        //defaults to 127.5
        imageStd: 127.5,
        //defaults to 127.5
        rotation: 90,
        // defaults to 90, Android only
        numResults: 3,
        // defaults to 5
        threshold: 0.7,
        // defaults to 0.1
        asynch: true,
        // defaults to true
      );

      result.value = '';
      recognition?.forEach((response) {
        result.value += response['label'] +
            " " +
            (response['confidence'] as double).toStringAsFixed(1) +
            "\n\n";
      });


      isWorking.value= false;
    }
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model.tflite',
        labels: 'assets/labels.txt',
        isAsset: true
    );

  }
}