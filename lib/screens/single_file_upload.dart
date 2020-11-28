import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:narr/helpers/dropdownHelper.dart';
import 'package:narr/helpers/file_picker_helper.dart';
// import 'package:narr/helpers/file_water_mark_helper.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/register.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/container_with_shadow.dart';
import 'package:narr/widgets/custom_button.dart';

class SingleFileUpload extends StatefulWidget {
  static const String id = 'SingleFileUpload';
  @override
  _SingleFileUploadState createState() => _SingleFileUploadState();
}

class _SingleFileUploadState extends State<SingleFileUpload> {
  String baseUrl = 'http://192.168.43.219:3000/upload';
  String uploadUrl = 'https://narr.ng/api/v1/research/upload';

  FilePickerHelper _filePickerHelper = FilePickerHelper();
  // FileWaterMarkHelper _fileWaterMarkHelper = FileWaterMarkHelper();

  List<String> watermarkExtension = ['pdf'];
  List<String> uploadDocExtensions = [
    'doc',
    'docx',
    'pdf',
    'odt',
  ];

  static DateTime dateTime = DateTime.now();
  DropdownHelper _dropdownHelper = DropdownHelper();
  static TextEditingController topicController = TextEditingController();
  static TextEditingController authorController = TextEditingController();
  static TextEditingController monthlyController = TextEditingController();
  static TextEditingController yearController = TextEditingController();
  bool isClickable = false;
  static DateTime selectedDate = DateTime.now();
  bool isPicked = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        isPicked = true;
      }); //get
    }
  }

  //
  Dio dio = Dio();
  bool flag = false;
  Response response;
  double progress;
  int bytesSent;
  int bytesTotal;

  Map uploadMeta = {
    "researchTitle": "${topicController.text}",
    "authors": "${authorController.text}",
    "category": "${DropdownHelper().selectedCategory}",
    'genre': "${DropdownHelper().selectedGenre}",
    'accessType': "${DropdownHelper().selectedAccessType}",
    'monthlyFee': "${monthlyController.text}",
    'year': '$selectedDate',
    'ownerEmail': '',
  };
  void onSendProgress(int sent, int total) {
    double percentage = (sent / total * 100);
    setState(() {
      bytesSent = sent;
      bytesTotal = total;
      progress = percentage;
      //update the progress
    });
  }

// drop file
  void dropFile() {
    _filePickerHelper.fileName = null;
    _filePickerHelper.fileExtension = null;
    _filePickerHelper.selectedfile = null;
    setState(() {
      flag = false;
    });
  }

  void getFileName;

  @override
  Widget build(BuildContext context) {
    String dob = '${selectedDate.toLocal()}'.split(' ')[0];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[600],
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Upload',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ),
      body: _filePickerHelper.selectedfile != null
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ContainerWithShadow(
                    child: Column(
                      children: [
                        _filePickerHelper.selectedfile != null && flag == true
                            ? ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: LinearProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  value: progress != null ? progress : 0,
                                ),
                                subtitle: Text(progress != null
                                    ? '$bytesSent of $bytesTotal'
                                    : 'w'),
                                trailing: Text(progress != null
                                    ? '${progress.toInt()} %'
                                    : 't'),
                              )
                            : Container(),

                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                '${_filePickerHelper.fileName}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () => dropFile(),
                              child: Icon(Icons.close),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        //
                        TextField(
                          controller: topicController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Research Topic',
                            filled: true,
                          ),
                        ),
                        SizedBox(height: 14),
                        TextField(
                          controller: authorController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Author',
                            filled: true,
                          ),
                        ),
                        SizedBox(height: 14),
                        DropdownContainer(
                          child: DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Please select category';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 13.0),
                              child: Text(
                                'Category',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            items: _dropdownHelper.getCategoryDropdownItems(),
                            onChanged: (value) {
                              setState(() {
                                _dropdownHelper.selectedCategory = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 14),
                        DropdownContainer(
                          child: DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a genre';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 13.0),
                              child: Text(
                                'Genres',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            items: _dropdownHelper.getGenreDropdownItems(),
                            onChanged: (value) {
                              setState(() {
                                _dropdownHelper.selectedGenre = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 14),
                        DropdownContainer(
                          child: DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Please select category';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 13.0),
                              child: Text(
                                'Access Type',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            items: _dropdownHelper.getaccessTypeDropdownItems(),
                            onChanged: (value) {
                              setState(() {
                                _dropdownHelper.selectedAccessType = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        _dropdownHelper.selectedAccessType ==
                                _dropdownHelper.accessType[1]
                            ? TextField(
                                controller: monthlyController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Monthly Fess',
                                  filled: true,
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 14,
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey[600],
                                  size: 20,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  isPicked ? dob : 'Date of Birth',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomBotton(
                          isLoading: isClickable,
                          buttonTitle: 'Upload',
                          onTap: () async {
                            // onSendProgress();
                            setState(() {
                              flag = true;
                              isClickable = true;
                            });

                            // await _uploadFile();
                            NetworkHelper(url: uploadUrl)
                                .uploadFile(
                                  response: response,
                                  selectedfile: _filePickerHelper.selectedfile,
                                  uploadMeta: uploadMeta,
                                  onSendProgress: onSendProgress,
                                  trancitionedScreen: HomeScreen(),
                                  alertMessage: 'File Uploaded successfully',
                                  context: context,
                                )
                                .whenComplete(
                                  () => setState(() {
                                    isClickable = false;
                                  }),
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    await _filePickerHelper.selectDoc(
                      allowedExtensions: watermarkExtension,
                    );
                    setState(() {
                      flag = false;
                    });
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Center(
                            child: Text(
                              'Click the upload file \n button to start \n upload proccess.',
                              maxLines: 3,
                              style: TextStyle(
                                color: Colors.grey[900].withOpacity(0.25),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.file_upload,
                          color: Color(0xff00a368),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Recent Uploads:'),
                    ),
                  ],
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
