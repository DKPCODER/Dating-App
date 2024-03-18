import 'package:dating_app/controller/LikeController.dart';
import 'package:dating_app/tabScreens/viewprofile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  LikeController likeController = Get.put(LikeController());
  @override
  void initState() {
    likeController.fetchDataFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          centerTitle: true,
          title: Text('Who Likes You'),
          backgroundColor: Colors.blue,
        ),
        body: Obx(() => likeController.isLoading.value == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : likeController.mydata.value.likedBy!.length != 0
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              likeController.mydata.value.likedBy!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(ViewUserdetails(
                                    id: likeController
                                        .mydata.value.likedBy![index]['id']));
                              },
                              child: ListTile(
                                title: Text(
                                    '${likeController.mydata.value.likedBy![index]['name'] ?? ''}',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                subtitle: Text(
                                    '${likeController.mydata.value.likedBy![index]['age'] ?? ''} yr old ${likeController.mydata.value.likedBy![index]['city'] ?? ''}, ${likeController.mydata.value.likedBy![index]['country'] ?? ''}, ${likeController.mydata.value.likedBy![index]['martialStatus']} ',
                                    style: TextStyle(fontSize: 15)),
                                leading: CircleAvatar(
                                  radius: 30,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(likeController
                                                    .mydata
                                                    .value
                                                    .likedBy![index]
                                                ['imageProfile'] ??
                                            ''),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: Icon(Icons.favorite,
                                    color: Colors.red, size: 35),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No one liked you yet',
                      style: TextStyle(fontSize: 20),
                    ),
                  )));
  }
}
