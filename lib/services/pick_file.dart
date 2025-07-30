import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:tech_blog/controller/file_controller.dart';

FileController _fileController = Get.put(FileController());
Future pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.any,
  );
  _fileController.file.value = result!.files.first;
}
