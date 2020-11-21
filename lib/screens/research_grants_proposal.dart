import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:narr/widgets/grants_outlined_container.dart';
import 'package:narr/widgets/research_grants_content.dart';

class ResearchGrantsProposal extends StatefulWidget {
  static String id = '/grantsProposal';
  @override
  _ResearchGrantsProposalState createState() => _ResearchGrantsProposalState();
}

class _ResearchGrantsProposalState extends State<ResearchGrantsProposal> {
  String loremIpsum =
      'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Reiciendis, dolores? Mollitia animi numquam, repellendus deserunt ab quasi cum dicta! Nesciunt laudantium beatae saepe, reprehenderit fugit similique, veritatis quisquam illum aut officia nihil dolores Facere dolorum aliquam, harum quod quas officiis animi. Lorem ipsum dolor, sit amet consectetur adipisicing elit. Reiciendis, dolores? ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Research Grant Proposal'),
      ),
      body: SingleChildScrollView(
        child: GrantsOutlinedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: ResearchGrantsContent(
                  loremIpsum: loremIpsum,
                  iconButtonIcon: FontAwesomeIcons.heart,
                  iconButtonIconColor: Colors.green,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Divider(
                  thickness: 1.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
