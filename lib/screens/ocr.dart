// import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:narr/screens/uploadOcr.dart';

class OCRScreen extends StatefulWidget {
  static const String id = 'OCRScreen';
  @override
  _OCRScreenState createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  String imageFileName;
  String selectedImageFile;
  String imageExtension;

  Future<String> _selectImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'tiff', 'gif'],
    );

    if (result != null) {
      imageFileName = result.files.first.name;
      selectedImageFile = result.files.first.path;
      print(selectedImageFile);
      print(imageExtension);
      setState(() {});
    }
    return imageExtension;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0xff00a368),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'OCR',
          style: TextStyle(
            color: Color(0xff00a368),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2.5),
                color: Colors.black.withOpacity(0.15),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select Picture Upload Method',
                style: TextStyle(
                  color: Color(0xff00a368),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushNamed(SingleFileUpload.id);
                    },
                    child: OcrCard(
                      icon: Icons.camera_alt,
                      cardTitle: 'Take Photo',
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      _selectImage();
                      if (selectedImageFile != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return UploadOcr();
                          }),
                        );
                      }
                    },
                    child: OcrCard(
                      icon: Icons.photo,
                      cardTitle: 'Select from photos',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OcrCard extends StatelessWidget {
  final IconData icon;
  final String cardTitle;
  const OcrCard({Key key, this.icon, this.cardTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 35, bottom: 35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey[600].withOpacity(0.5),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: Color(0xff00a368),
          ),
          SizedBox(height: 3),
          Text(
            cardTitle,
            style: TextStyle(
              fontSize: 11,
              color: Color(0xff00a368),
            ),
          ),
        ],
      ),
    );
  }
}
