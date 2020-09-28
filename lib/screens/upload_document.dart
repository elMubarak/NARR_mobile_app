import 'package:flutter/material.dart';
import 'package:narr/screens/bulk_file_upload.dart';
import 'package:narr/screens/single_file_upload.dart';

class UploadDoc extends StatefulWidget {
  static const String id = 'UploadDoc';
  @override
  _UploadDocState createState() => _UploadDocState();
}

class _UploadDocState extends State<UploadDoc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.grey[600],
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Upload File',
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(10),
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
              children: [
                Text(
                  'Select File Upload Method',
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(SingleFileUpload.id);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey[700].withOpacity(0.5),
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.receipt,
                              size: 60,
                              color: Colors.grey[700].withOpacity(0.5),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Quick, Single File Upload',
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(BulkFileUpload.id);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey[700].withOpacity(0.5),
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.unarchive,
                              size: 60,
                              color: Colors.grey[700].withOpacity(0.5),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Bulk, Multi File Upload',
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Text('Recent Uploads'),
                  // Expanded(
                  //   child: ListView(),
                  // ),
                ],
              ))
        ],
      ),
    );
  }
}
