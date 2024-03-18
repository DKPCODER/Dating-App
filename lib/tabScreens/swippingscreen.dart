import 'package:dating_app/controller/profilecontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwappingScreen extends StatefulWidget {
  SwappingScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SwappingScreenState createState() => _SwappingScreenState();
}

class Content {
  final String text;
  final Color color;
  final String image;
  final String heading;
  Content({
    required this.text,
    required this.color,
    required this.image,
    required this.heading,
  });
}

class _SwappingScreenState extends State<SwappingScreen> {
  FirebaseController firebaseController = Get.put(FirebaseController());

  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange",
    "Grey",
    "Purple",
    "Pink"
  ];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.grey,
    Colors.purple,
    Colors.pink
  ];

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  fetchdata() async {
    await firebaseController.fetchData();
    for (int i = 0; i < firebaseController.usersProfileList.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(
              text: firebaseController.usersProfileList[i].name ?? '',
              color: Colors.black,
              image: firebaseController.usersProfileList[i].imageProfile ?? '',
              heading:
                  firebaseController.usersProfileList[i].profileHeading ?? ''),
          likeAction: () {
            firebaseController.addLikedPerson(
                firebaseController.usersProfileList[i].id ?? '');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text("Liked ${firebaseController.usersProfileList[i].name}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            firebaseController.addDislikedPerson(
                firebaseController.usersProfileList[i].id ?? '');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Superliked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 90, 193, 237),
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          leading: SizedBox(),
          title: Text("Explore People"),
        ),
        body: Obx(() => firebaseController.isLoading.value == true
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Container(
                child: Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height - kToolbarHeight,
                  child: SwipeCards(
                    matchEngine: _matchEngine!,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          alignment: Alignment.center,
                          color: const Color.fromARGB(255, 168, 165, 165),
                          child: Container(
                            height: size.height * 0.8,
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      _swipeItems[index].content.image,
                                      height: size.height * 0.65,
                                      width: size.width * 0.9,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: size.height * 0.2,
                                  left: size.width * 0.3,
                                  child: Text(
                                    _swipeItems[index].content.text,
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Positioned(
                                    top: size.height * 0.1,
                                    left: size.width * 0.3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                          "${_swipeItems[index].content.heading ?? ''}",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          )),
                                    )),
                              ],
                            ),
                          ));
                    },
                    onStackFinished: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Stack Finished"),
                        duration: Duration(milliseconds: 500),
                      ));
                    },
                    itemChanged: (SwipeItem item, int index) {
                      print("item: ${item.content.text}, index: $index");
                    },
                    leftSwipeAllowed: true,
                    rightSwipeAllowed: true,
                    upSwipeAllowed: true,
                    fillSpace: true,
                    likeTag: Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green)),
                      child: Text('Like'),
                    ),
                    nopeTag: Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.red)),
                      child: Text('Nope'),
                    ),
                    superLikeTag: Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange)),
                      child: Text('Super Like'),
                    ),
                  ),
                ),
              ]))));
  }
}
