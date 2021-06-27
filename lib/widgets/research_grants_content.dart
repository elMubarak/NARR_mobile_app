import 'package:flutter/material.dart';
import 'package:narr/widgets/rounded_social_button.dart';
import 'package:narr/widgets/tags.dart';

class ResearchGrantsContent extends StatelessWidget {
  const ResearchGrantsContent(
      {Key? key,
      required this.loremIpsum,
      required this.iconButtonOnPressed,
      required this.iconButtonIcon,
      required this.iconButtonIconColor})
      : super(key: key);

  final String loremIpsum;
  final VoidCallback iconButtonOnPressed;
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
              onPressed: () {},
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
