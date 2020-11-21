import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:narr/screens/research_grants_proposal.dart';
import 'package:narr/widgets/grants_outlined_container.dart';
import 'package:narr/widgets/research_grants_content.dart';

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
        child: GrantsOutlinedContainer(
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ResearchGrantsProposal.id);
                      },
                      child: ResearchGrantsContent(
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
