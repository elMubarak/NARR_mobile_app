import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/store/hive_store.dart';
import 'package:narr/widgets/dark_mode_reader.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:photo_view/photo_view.dart';

String singleResearchUrl = 'https://api.narr.ng/api/v1/research';

class Reader extends StatefulWidget {
  final String id;
  Reader(this.id);
  @override
  _ReaderState createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
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
  HiveBox _box = HiveBox();

  var token;
  getToken() async {
    String savedToken = await _box.getUser('token');
    print("token from store $savedToken");
    token = savedToken;
    print("token from store $token");
  }
  // int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    getToken();
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
                            'https://api.narr.ng${research.data['payload']['readPath']}$_currentPage.jpg?token=$token'
                          ],
                          isDark: true,
                        ),
                      ),
                    )
                  : PageSlider(
                      buttonCarouselController: buttonCarouselController,
                      imgList: [
                        'https://api.narr.ng${research.data['payload']['readPath']}$_currentPage.jpg?token=$token'
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
                          onPressed: () {
                            setState(() {
                              _currentPage = 1;
                            });
                          },
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
                          void _showDialog() {
                            showDialog<int>(
                              context: context,
                              builder: (BuildContext context) {
                                return NumberPickerDialog.integer(
                                  initialIntegerValue:
                                      (_currentPage != null) ? _currentPage : 1,
                                  minValue: 1,
                                  maxValue: research.data['payload']['nPages'],
                                  // onChanged: (value) {

                                  // },
                                );
                              },
                            ).then(
                              (value) => setState(() {
                                _currentPage = value;
                              }),
                            );
                          }

                          _showDialog.call();
                        },
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: () {
                            setState(() {
                              if (_currentPage ==
                                  research.data['payload']['nPages']) {
                                _currentPage =
                                    research.data['payload']['nPages'];
                              } else {
                                _currentPage++;
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {
                            setState(() {
                              _currentPage = research.data['payload']['nPages'];
                            });
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
                    loadingBuilder: (context, loadingProgress) {
                      if (loadingProgress == null)
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      print(error);
                      return Text('Some errors occurred!');
                    },
                    loadFailedChild: Container(
                      height: 100,
                      width: 100,
                      child: Center(child: CircularProgressIndicator()),
                    ),
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
