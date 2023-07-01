import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:music_brains/core/color/colors.dart';
import 'package:xml/xml.dart' as xml;
import '../../Domain/Details.dart';
import '../../core/constant/test_style.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> images = [
    "assets/images/pop.jpeg",
    "assets/images/lap.webp",
    "assets/images/alterm.jpeg"
  ];

  TextEditingController searchController = TextEditingController();

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
          return Scaffold(
            backgroundColor: backgroundcolor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 270,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CupertinoSearchTextField(
                              controller: searchController,
                              backgroundColor: Colors.grey,
                              prefixIcon: Icon(
                                CupertinoIcons.search,
                                color: Colors.grey[900],
                              ),
                              suffixIcon: const Icon(
                                CupertinoIcons.xmark_circle_fill,
                                color: Colors.black45,
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const Icon(
                          Ionicons.notifications,
                          color: Colors.white,
                        ),
                        const CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              AssetImage("assets/images/image01.jpg"),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recent Search",
                            style: ktextHome,
                          ),
                          Container(
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.purple[600],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 17, top: 5),
                              child: Text(
                                "Clear",
                                style: kCardtext,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
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
                                    Ionicons.chevron_forward_outline,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Popular Geners",
                        style: ktextHome,
                      ),
                    ),
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: details.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 4.0),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 150,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.purple.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(15),
                                  // image: DecorationImage(
                                  //   image: AssetImage(images[index]),
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    // Container(
                                    //   margin: const EdgeInsets.only(bottom: 0.0),
                                    //   // alignment: Alignment.topCenter,
                                    //   height: 250.0,
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: const BorderRadius.only(
                                    //       topLeft: Radius.elliptical(25, 8),
                                    //       topRight: Radius.elliptical(25, 8),
                                    //       bottomLeft: Radius.elliptical(25, 8),
                                    //       bottomRight: Radius.elliptical(25, 8),
                                    //     ),
                                    //     color: Colors.purple.withOpacity(0.4),
                                    //   ),
                                    // ),
                                    Center(
                                      child: Text(
                                        details[index].name,
                                        style: kCardtext,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                    ),

                    // Expanded(
                    //   child: isSearchidle
                    //       ? SearchIdleWidget(
                    //           tvShowList: tvShowList,
                    //         )
                    //       : SearchResult(
                    //           searchResultFrom: searchList,
                    //         ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
