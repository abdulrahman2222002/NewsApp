// ignore_for_file: non_constant_identifier_names, must_call_super, avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class TechScreen extends StatefulWidget {
  const TechScreen({Key? key}) : super(key: key);

  @override
  State<TechScreen> createState() => _TechScreenState();
}

String apiKey = 'e8e6ff95b3694648a6312a7f2f661c1c';

class _TechScreenState extends State<TechScreen> {
  var url =
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey';
  var Tlist = [];

  Future getData() async {
    var response = await http.get(Uri.parse(url));
    var responseBody = await jsonDecode(response.body);

    setState(() {
      Tlist = responseBody['articles'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Tlist.length,
      itemBuilder: (BuildContext context, int index) {
        var uurl = Uri.parse(Tlist[index]["url"]);
        return GestureDetector(
          onTap: () async {
            if (await canLaunchUrl(uurl)) {
              await launchUrl(uurl);
            } else {
              print("failed");
            }
          },
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xff28292B),
                    ),
                    child: Row(
                      children: [
                        Tlist[index]["urlToImage"] != Null
                            ? Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  height: 120,
                                  child: Image.network(
                                      "${Tlist[index]["urlToImage"]}",
                                      fit: BoxFit.fill,
                                      height: 100,
                                      width: 120, errorBuilder:
                                      (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return SizedBox(
                                        width: 120,
                                        child: Image.asset(
                                          "assets/images/error.png",
                                          fit: BoxFit.fill,
                                        ));
                                  }),
                                ),
                              ),
                            ),
                          ),
                        )
                            : const SizedBox(),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${Tlist[index]["title"]}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Author: ${Tlist[index]["author"]}",
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 130.0),
                                  child: Text(
                                    "${Tlist[index]["publishedAt"]}",
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Colors.orange, fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 1,
                    ),
                  ),
                ],
              )
          ),
        );
      },
    );
  }
}
