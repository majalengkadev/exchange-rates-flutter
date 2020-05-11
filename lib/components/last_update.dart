import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class LastUpdate extends StatelessWidget {
  final String date;

  LastUpdate({this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 24, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.date_range,
                color: Colors.black26,
                size: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  "Last Update ${DateFormat('dd MMMM yyyy').format(DateTime.parse(date))}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black38),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text('MajalengkaDev', style: TextStyle(color: Colors.black54)),
              GestureDetector(
                onTap: () {
                  _launchURL('https://majalengkadev.github.io');
                },
                child: Text(
                  'https://majalengkadev.github.io',
                  style: TextStyle(fontSize: 13, color: Colors.lightBlueAccent),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
