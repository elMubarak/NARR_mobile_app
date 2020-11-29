import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/dark_mode_reader.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:photo_view/photo_view.dart';

String singleResearchUrl = 'https://narr.ng/api/v1/research';

class Reader extends StatefulWidget {
  final String id;
  Reader(this.id);
  @override
  _ReaderState createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  bool isLoading;
  PDFDocument doc;

  void initState() {
    super.initState();
    getQuestionPdf();
    print(widget.id);
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
      body: Slider(widget.id),
    );
  }
}

class Slider extends StatefulWidget {
  final String id;
  Slider(this.id);
  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  bool isDark = false;
  CarouselSlider carouselSlider;
  CarouselController buttonCarouselController = CarouselController();
  // int _current = 0;

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
            maxValue: 2,
            title: Text('Select Page'),
          );
        });
    print(_currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          NetworkHelper(url: singleResearchUrl).getSingleResearch(widget.id),
      builder: (context, research) {
        if (!research.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (isDark == true)
                  ? Expanded(
                      child: DarkNight(
                        child: PageSlider(
                          buttonCarouselController: buttonCarouselController,
                          imgList: [
                            'https://narr.ng${research.data['payload']['readPath']}$_currentPage.jpg'
                          ],
                          isDark: true,
                        ),
                      ),
                    )
                  : PageSlider(
                      buttonCarouselController: buttonCarouselController,
                      imgList: [
                        'https://narr.ng${research.data['payload']['readPath']}$_currentPage.jpg'
                      ],
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
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.chevron_left),
                          onPressed: () {
                            setState(() {
                              if (_currentPage < 2) {
                                _currentPage = 1;
                              } else {
                                _currentPage--;
                              }
                            });
                            print(_currentPage);
                          },
                        ),
                      ),
                      FloatingActionButton(
                        child: Icon(Icons.view_carousel),
                        onPressed: () {
                          _showDialog.call();
                          print(_currentPage);
                        },
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: () {
                            setState(() {
                              _currentPage++;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
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
