import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:narr/widgets/custom_button.dart';

class UploadOcr extends StatelessWidget {
  final String imagePicked;
  final Response response;
  UploadOcr({this.imagePicked, this.response});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                spreadRadius: 3,
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(imagePicked),
              ),
              SizedBox(
                height: 15,
              ),
              CustomBotton(
                buttonTitle: 'OCR',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConvertedImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(''),
    );
  }
}
