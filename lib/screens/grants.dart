import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Grants extends StatefulWidget {
  static String id = '/grants';
  @override
  _GrantsState createState() => _GrantsState();
}

class _GrantsState extends State<Grants> {
  bool buttonPressed = false;
  String loremIpsum =
      'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Reiciendis, dolores? Mollitia animi numquam, repellendus deserunt ab quasi cum dicta! Nesciunt laudantium beatae saepe, reprehenderit fugit similique, veritatis quisquam illum aut officia nihil dolores';
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Research Grants'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.1),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 8.0, left: 15),
                child: Text(
                  'Research Grants Feed',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
              Divider(
                thickness: 1.0,
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  children: [
                    ResearchGrantsContent(
                      loremIpsum: loremIpsum,
                      iconButtonOnPressed: () {
                        setState(() {
                          buttonPressed = !buttonPressed;
                        });
                      },
                      iconButtonIcon: buttonPressed == false
                          ? FontAwesomeIcons.heart
                          : FontAwesomeIcons.solidHeart,
                      iconButtonIconColor:
                          buttonPressed == false ? Colors.green : Colors.red,
                    ),
                    SizedBox(height: 12),
                    Divider(
                      thickness: 1.0,
                    ),
                    SizedBox(height: 12),
                    ResearchGrantsContent(
                      loremIpsum: loremIpsum,
                      iconButtonOnPressed: () {
                        setState(() {
                          buttonPressed = !buttonPressed;
                        });
                      },
                      iconButtonIcon: buttonPressed == false
                          ? FontAwesomeIcons.heart
                          : FontAwesomeIcons.solidHeart,
                      iconButtonIconColor:
                          buttonPressed == false ? Colors.green : Colors.red,
                    ),
                    SizedBox(height: 12),
                    Divider(
                      thickness: 1.0,
                    ),
                    SizedBox(height: 12),
                    ResearchGrantsContent(
                      loremIpsum: loremIpsum,
                      iconButtonOnPressed: () {
                        setState(() {
                          buttonPressed = !buttonPressed;
                        });
                      },
                      iconButtonIcon: buttonPressed == false
                          ? FontAwesomeIcons.heart
                          : FontAwesomeIcons.solidHeart,
                      iconButtonIconColor:
                          buttonPressed == false ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Manage'),
        onPressed: null,
      ),
    );
  }
}

class ResearchGrantsContent extends StatelessWidget {
  const ResearchGrantsContent(
      {Key key,
      @required this.loremIpsum,
      this.iconButtonOnPressed,
      this.iconButtonIcon,
      this.iconButtonIconColor})
      : super(key: key);

  final String loremIpsum;
  final Function iconButtonOnPressed;
  final IconData iconButtonIcon;
  final Color iconButtonIconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                'Undertake research on the possiblity of life on Mars',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            RoundedSocialButton(
              icon: iconButtonIcon,
              onPressed: iconButtonOnPressed,
              iconColor: iconButtonIconColor,
            ),
            RoundedSocialButton(
              icon: Icons.thumb_down_outlined,
              iconColor: Colors.green,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
            text: 'Research Budget - ',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'N1,210,000',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RichText(
          text: TextSpan(
            text: 'Estimated Project Duration - ',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '3 months',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          loremIpsum,
          style: TextStyle(wordSpacing: 2.0),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Tag(
              tagTitle: 'Space',
            ),
            Tag(
              tagTitle: 'Physics',
            ),
            Tag(
              tagTitle: 'Astronomy',
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.person,
              color: Colors.grey[600],
            ),
            Text(
              'Clients:',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              'Space X',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: Colors.grey[600],
            ),
            Text(
              'Location:',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              'Kaduna, Nigeria',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Tag extends StatelessWidget {
  final String tagTitle;
  const Tag({this.tagTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Color(0xffE6E6E6),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(tagTitle),
    );
  }
}

class RoundedSocialButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final Color iconColor;
  const RoundedSocialButton({this.icon, this.onPressed, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      elevation: 4.0,
      disabledElevation: 4.0,
      fillColor: Colors.white,
      constraints: BoxConstraints(minWidth: 34.0, minHeight: 34.0),
      child: Icon(
        icon,
        size: 18,
        color: iconColor,
      ),
      onPressed: onPressed,
    );
  }
}
