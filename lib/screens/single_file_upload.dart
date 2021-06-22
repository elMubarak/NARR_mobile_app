import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:narr/configs.dart';
import 'package:narr/global/global_vars.dart';
import 'package:narr/helpers/dropdownHelper.dart';
import 'package:narr/helpers/file_picker_helper.dart';
import 'package:narr/models/citation_mode.dart';
import 'package:narr/screens/add_citations.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/widgets/dropdown_container.dart';
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
  String uploadUrl = '$mubixyMockServer/research/upload';

  FilePickerHelper _filePickerHelper = FilePickerHelper();
  // FileWaterMarkHelper _fileWaterMarkHelper = FileWaterMarkHelper();

  List<String> watermarkExtension = ['pdf', 'doc', 'docx'];
  List<String> uploadDocExtensions = [
    'doc',
    'docx',
    'pdf',
    'odt',
  ];
  TextEditingController authorController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  DropdownHelper _dropdownHelper = DropdownHelper();
  final List<CitationModel> _addedCitations = <CitationModel>[];
  List<dynamic> _selectedCategories = <dynamic>[];
  final List<dynamic> categories = <dynamic>[
    "Arts",
    "Education",
    "Engineering",
    "Sciences",
    "Social sciences",
  ];

  final _formKey = GlobalKey<FormState>();

  bool isClickable = false;

  //
  Dio dio = Dio();
  bool flag = false;
  Response response;
  double progress;
  int bytesSent;
  int bytesTotal;

  static String researchTitle;
  static String authors;
  static String fee;
  static String year;
  static String description;

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
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Research Title is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Research Title',
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                onChanged: (value) {
                                  researchTitle = value;
                                },
                              ),
                              SizedBox(height: 14),
                              TextFormField(
                                maxLines: 5,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Description of publication is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Research Description',
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                onChanged: (value) {
                                  description = value;
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: 14),
                              TextFormField(
                                controller: authorController,
                                validator: (value) {
                                  if (addedAuthors.isEmpty) {
                                    return 'at least one authors is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: authorController.text.length >= 3
                                      ? Container(
                                          width: 100,
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    addedAuthors.add(
                                                        authorController.text);
                                                    authorController.clear();
                                                    setState(() {});
                                                  },
                                                  child: Text(
                                                    'Add author',
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        color:
                                                            determinePrimaryColor(
                                                                context)),
                                                  ),
                                                ),
                                              )),
                                        )
                                      : Container(width: 10),
                                  border: InputBorder.none,
                                  hintText: 'Authors',
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                onChanged: (value) {
                                  authors = value;
                                  setState(() {});
                                },
                                onFieldSubmitted: (String value) {
                                  addedAuthors.add(value);
                                  authorController.clear();
                                  setState(() {});
                                },
                                textInputAction: TextInputAction.go,
                                textCapitalization: TextCapitalization.words,
                              ),
                              // SizedBox(height: 14),
                              Wrap(
                                children: addedAuthors
                                    .map((String author) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Chip(
                                            label: Text(author),
                                            deleteButtonTooltipMessage:
                                                'Remove Author',
                                            onDeleted: () {
                                              addedAuthors.remove(author);
                                              setState(() {});
                                            },
                                          ),
                                        ))
                                    .toList(),
                              ),
                              SizedBox(height: 14),
                              //citation
                              ElevatedButton(
                                child: Text('Add Citation'),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CitationDialog(),
                                  ).then((value) {
                                    CitationModel newCitation = value;
                                    _addedCitations.add(newCitation);
                                    setState(() {});
                                  });
                                },
                              ),
                              SizedBox(height: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Added Citations'),
                                  Divider(),
                                  SizedBox(height: 8),
                                  _addedCitations.isNotEmpty
                                      ? Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 0.1)),
                                          child: DataTable(
                                            columns: [
                                              DataColumn(label: Text('Name')),
                                              DataColumn(label: Text('Year')),
                                              DataColumn(label: Text('Website'))
                                            ],
                                            rows: _addedCitations
                                                .map((CitationModel
                                                        citations) =>
                                                    DataRow(
                                                      cells: [
                                                        DataCell(Text(citations
                                                            .fullName)),
                                                        DataCell(Text(
                                                            citations.date)),
                                                        DataCell(Text(
                                                            citations.url)),
                                                      ],
                                                    ))
                                                .toList(),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),

                              SizedBox(height: 14),
                              MultiSelectBottomSheetField(
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                validator: (value) {
                                  if (value == null) {
                                    return 'at least one category is required';
                                  }
                                  return null;
                                },
                                searchable: true,
                                title: Text('Categories'),
                                buttonText: Text('Categories'),
                                items: categories
                                    .map((e) => MultiSelectItem(e, e))
                                    .toList(),
                                listType: MultiSelectListType.CHIP,
                                onConfirm: (values) {
                                  _selectedCategories = values;
                                },
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
                                  items:
                                      _dropdownHelper.getGenreDropdownItems(),
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
                                      return 'Please select Access Type';
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
                                  items: _dropdownHelper
                                      .getaccessTypeDropdownItems(),
                                  onChanged: (value) {
                                    setState(() {
                                      _dropdownHelper.selectedAccessType =
                                          value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: 14),
                              _dropdownHelper.selectedAccessType ==
                                      _dropdownHelper.accessType[1]
                                  ? TextField(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Monthly Fess',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                      ),
                                      onChanged: (value) {
                                        fee = value;
                                      },
                                    )
                                  : Container(),
                              SizedBox(
                                height: 14,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Year of publication is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Year of Publication',
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                onChanged: (value) {
                                  year = value;
                                },
                                keyboardType: TextInputType.datetime,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomBotton(
                          isLoading: isClickable,
                          buttonTitle: 'Upload',
                          onTap: () async {
                            // onSendProgress();

                            // await _uploadFile();
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              setState(() {
                                flag = true;
                                isClickable = true;
                              });
                              NetworkHelper(url: uploadUrl)
                                  .uploadFile(
                                    citation: _addedCitations,
                                    response: response,
                                    selectedfile:
                                        _filePickerHelper.selectedfile,
                                    onSendProgress: onSendProgress,
                                    trancitionedScreen: HomeScreen(),
                                    researchTitle: researchTitle,
                                    authors: addedAuthors,
                                    category: _selectedCategories,
                                    genre: _dropdownHelper.selectedGenre,
                                    accessType:
                                        _dropdownHelper.selectedAccessType,
                                    fee: fee,
                                    year: year,
                                    description: description,
                                    alertMessage:
                                        'Thank you for uploading your research work on NARR your document is being proccessed',
                                    context: context,
                                  )
                                  .whenComplete(
                                    () => setState(() {
                                      isClickable = false;
                                    }),
                                  );
                            }
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
                      children: [],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  List<String> addedAuthors = <String>[];
  List<CitationModel> addedCitations = <CitationModel>[];

  _addCitation() {}
}
