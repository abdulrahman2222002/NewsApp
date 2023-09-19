// ignore_for_file: file_names

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/screens/Apple.dart';
import 'package:news_app/screens/popular.dart';
import 'package:news_app/screens/business.dart';
import 'package:news_app/screens/tech.dart';

import 'package:flutter/material.dart';

class API extends StatefulWidget {
  const API({Key? key}) : super(key: key);
  @override
  State<API> createState() => _APIState();
}

class _APIState extends State<API> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xff38393B),
        appBar: AppBar(
          backgroundColor: const Color(0xff28292B),
          title: Row(
            children: const [
              Text(
                'News',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 40
                ),
              ),
              SizedBox(width: 10,),
              Icon(FontAwesomeIcons.bookOpen,color: Colors.orange,size: 25,),
              SizedBox(width: 3,),
              Icon(FontAwesomeIcons.pencil,color: Colors.orange,size: 20,),

            ],
          ),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Text('Popular'),
              Text('Business'),
              Text('Tech'),
              Text('Apple'),
            ],
            indicatorColor: Colors.orange,
          ),
        ),
        body: const TabBarView(
          children: [
            PopularScreen(),
            BusinessScreen(),
            TechScreen(),
            AppleScreen(),
          ],
        ),
      ),
    );
  }
}
