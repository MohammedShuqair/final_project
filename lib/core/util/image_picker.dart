import 'package:image_picker/image_picker.dart';

Future<XFile?> pickGelleryImage() async {
  return await ImagePicker().pickImage(source: ImageSource.gallery);
}

Future<XFile?> pickCameraImage() async {
  return await ImagePicker().pickImage(source: ImageSource.camera);
}

Future<List<XFile>> pickMullImage() async {
  return await ImagePicker().pickMultiImage();
}
