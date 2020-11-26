import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:narr/widgets/dark_mode_reader.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:photo_view/photo_view.dart';

class Reader extends StatefulWidget {
  static const String id = 'Reader';
  @override
  _ReaderState createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  bool isLoading;
  PDFDocument doc;

  void initState() {
    super.initState();
    getQuestionPdf();
    // _delayTime();
  }

  void getQuestionPdf() async {
    setState(() {
      isLoading = true;
    });

    doc = await PDFDocument.fromURL(
        'https://eloquentjavascript.net/Eloquent_JavaScript.pdf');

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reader'),
      ),
      // body: Container(
      //   padding: EdgeInsets.all(8),
      //   width: double.infinity,
      //   child: isLoading
      //       ? Center(
      //           child: CircularProgressIndicator(),
      //         )
      //       : PDFViewer(
      //           document: doc,
      //         ),
      // ),
      body: Slider(),
    );
  }
}

class Slider extends StatefulWidget {
  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  bool isDark = false;
  CarouselSlider carouselSlider;
  CarouselController buttonCarouselController = CarouselController();
  // int _current = 0;
  List imgList = [
    'https://4ww1y37tl91gmoej12r01u1c-wpengine.netdna-ssl.com/wp-content/uploads/2019/08/TextDocument.png',
    'https://www.myperfectresume.com/wp-content/uploads/resume-templates/document-controller.png',
    'https://image.slidesharecdn.com/c9db7854-ebae-44f6-9de8-079b35c2e5d4-150502032517-conversion-gate01/95/professional-document-review-and-editing-services-1-638.jpg?cb=1430537895',
    // 'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    // 'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  int _currentPage = 1;

  void _showDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            initialIntegerValue: _currentPage,
            minValue: 1,
            maxValue: imgList.length,
            title: Text('Select Page'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (isDark == true)
              ? Expanded(
                  child: DarkNight(
                    child: PageSlider(
                      buttonCarouselController: buttonCarouselController,
                      imgList: imgList,
                      isDark: true,
                    ),
                  ),
                )
              : PageSlider(
                  buttonCarouselController: buttonCarouselController,
                  imgList: imgList,
                  isDark: false,
                ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Checkbox(
                  value: isDark,
                  onChanged: (val) {
                    setState(() {
                      isDark = val;
                    });
                  },
                ),
                Text('Night Mode'),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: BottomAppBar(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.first_page),
                      onPressed: () {
                        buttonCarouselController.jumpToPage(0);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () {
                        buttonCarouselController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                    ),
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.view_carousel),
                    onPressed: _showDialog,
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: () {
                        buttonCarouselController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.last_page),
                      onPressed: () {
                        buttonCarouselController.jumpToPage(imgList.length);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PageSlider extends StatelessWidget {
  const PageSlider({
    Key key,
    @required this.buttonCarouselController,
    @required this.imgList,
    this.isDark,
  }) : super(key: key);

  final CarouselController buttonCarouselController;
  final List imgList;
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselSlider(
        carouselController: buttonCarouselController,
        options: CarouselOptions(
          height: 370,
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: false,
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
        ),
        items: imgList.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: PhotoView(
                    backgroundDecoration: BoxDecoration(
                        color: (isDark) ? Colors.black : Colors.white),
                    loadFailedChild: CircularProgressIndicator(),
                    imageProvider: NetworkImage(url),
                    minScale: PhotoViewComputedScale.contained * 1.0,
                    maxScale: PhotoViewComputedScale.contained * 2.5,
                    initialScale: PhotoViewComputedScale.contained * 1.0,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}