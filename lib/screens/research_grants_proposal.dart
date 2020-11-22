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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Submit a Proposal',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Fill out the form field below with the required information following these guidelines: ',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '1. Why are you the perfect candidate for the job?\n2. Have you worked on a similar research/project?\n3. How long will it take to complete? (estimate)',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write your Proposal in this form field',
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
