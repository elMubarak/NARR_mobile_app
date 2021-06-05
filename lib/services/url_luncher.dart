import 'package:url_launcher/url_launcher.dart';

void launchURL(linkUrl) async => await canLaunch(linkUrl)
    ? await launch(linkUrl)
    : throw 'Could not launch $linkUrl';
