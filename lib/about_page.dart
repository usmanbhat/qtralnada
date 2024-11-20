import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Me'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "!اسلام عليكم \r Mohammad Usman Bhat",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "A passionate full-stack developer and Android app developer from Kashmir. "
              "I love creating intuitive web and mobile applications.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _launchURL('https://usman-bhat.github.io/home/'),
              child: Text('View My Portfolio'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.linkedin),
                  onPressed: () =>
                      _launchURL('https://www.linkedin.com/in/usman-bhat/'),
                  tooltip: 'LinkedIn',
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.github),
                  onPressed: () => _launchURL('https://github.com/Usman-bhat'),
                  tooltip: 'GitHub',
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.twitter),
                  onPressed: () =>
                      _launchURL('https://twitter.com/m_usmanbhat'),
                  tooltip: 'Twitter/X',
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _launchURL(
                  'https://play.google.com/apps/publish/?account=7820612022916724487'), // Replace with actual Play Store URL
              child: Text('Visit My Play Store Profile'),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
