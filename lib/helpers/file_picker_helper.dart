import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  String selectedfile = '';
  String fileExtension = '';
  String fileName = '';
  Future<String> selectDoc({
    required List<String> allowedExtensions,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      onFileLoading: (val) {
        if (val != null) {
          // do something
        }
      },
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    if (result != null) {
      fileName = result.files.first.name;
      selectedfile = result.files.first.path!;
      fileExtension = result.files.first.extension!;
      print('File Name $selectedfile');
      print('File Extension: $fileExtension');
    }
    return fileExtension;
  }
}
