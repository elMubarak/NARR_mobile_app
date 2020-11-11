import 'package:flutter/material.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/container_with_shadow.dart';
import 'package:narr/widgets/custom_button.dart';

class OcrResult extends StatelessWidget {
  static String id = 'ocrResult';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: NetworkHelper('https://shamskhalil.ngrok.io/tika/form')
            .uploadPhoto(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ContainerWithShadow(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Result',
                  style: TextStyle(
                    color: Color(0xff00a368),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(top: 35, bottom: 35, left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey[600].withOpacity(0.5),
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                      'mfbzvjfngrofinvk sfgrfepowrjqf  urioefbiorgr roewhriehf'),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomBotton(
                      buttonTitle: 'Save',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
