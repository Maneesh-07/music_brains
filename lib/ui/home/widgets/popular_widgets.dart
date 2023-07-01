import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:music_brains/Domain/Details.dart';
import 'package:music_brains/core/constant/test_style.dart';
import 'package:xml/xml.dart' as xml;

class Popular_widget extends StatelessWidget {
  const Popular_widget({
    super.key,
  });

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

          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 50),
                  child: Text(
                    "Popular Songs",
                    style: ktextHome,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: details.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/image01.jpg"),
                        ),
                        title: Text(
                          details[index].name,
                          style: kCardtext,
                        ),
                        trailing: const Icon(
                          Ionicons.play,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
