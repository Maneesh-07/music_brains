// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

import 'package:music_brains/Domain/details.dart';
import 'package:music_brains/core/constant/test_style.dart';

class CardWidget extends StatelessWidget {
  CardWidget({
    Key? key,
  }) : super(key: key);

  List<String> images = [
    "assets/images/pop.jpeg",
    "assets/images/lap.webp",
    "assets/images/alterm.jpeg"
  ];

  Future<List<Details>> getContactsFromXml(BuildContext context) async {
    String xmlString =
        await DefaultAssetBundle.of(context).loadString("assets/data/name.xml");
    var raw = xml.XmlDocument.parse(xmlString);
    var elements = raw.findAllElements("details");

    List<Details> detailsList = [];

    for (var element in elements) {
      var genreElement = element.findElements("genre").first;
      var nameElement = genreElement.findElements("name").first;

      var genreName = nameElement.text;
      var genreId = genreElement.getAttribute("id");

      var details = Details(genreName, genreId.toString());
      detailsList.add(details);
    }

    return detailsList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Details>>(
      future: getContactsFromXml(context),
      builder: (context, data) {
        if (data.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (data.hasError) {
          return Text("Error: ${data.error}");
        } else {
          List<Details> details = data.data as List<Details>;

          return SizedBox(
            width: double.infinity,
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: details.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // image: DecorationImage(
                    //   image: AssetImage(images[index]),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 0.0),
                        height: 250.0,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.elliptical(25, 8),
                            topRight: Radius.elliptical(25, 8),
                            bottomLeft: Radius.elliptical(25, 8),
                            bottomRight: Radius.elliptical(25, 8),
                          ),
                          color: Colors.purple.withOpacity(0.2),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              details[index].name,
                              style: kCardtext,
                            ),
                            Text(
                              "Country",
                              style: kCardtext,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
