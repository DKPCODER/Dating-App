import 'package:dating_app/controller/searchController.dart';
import 'package:dating_app/tabScreens/viewprofile.dart';
import 'package:dating_app/widgets/filter_person.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SearchPerson extends StatefulWidget {
  const SearchPerson({super.key});

  @override
  State<SearchPerson> createState() => SearchPersonState();
}

class SearchPersonState extends State<SearchPerson> {
  SearchPersonController searchController = Get.put(SearchPersonController());
  @override
  void initState() {
    searchController.fetchDataFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          leading: SizedBox(),
          title: Text('Search Person'),
          backgroundColor: Colors.blue,
        ),
        body: Obx(() => searchController.isLoading.value == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Column(
                children: [
                  Container(
                    width: size.width * 0.9,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              searchController.filterbyname(
                                  name: value.toLowerCase().trim());
                            },
                            decoration: InputDecoration(
                              hintText: 'Search',
                              helperStyle: TextStyle(color: Colors.white),
                              labelText: 'Search',
                              prefixIcon: Icon(Icons.search,
                                  color: Colors.white, size: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                            onPressed: () {
                              Get.to(Filters());
                            },
                            icon: Icon(Icons.filter_list,
                                color: Colors.white, size: 35)),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: searchController.filteredList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(ViewUserdetails(
                              id: searchController.filteredList[index].id!));
                        },
                        child: ListTile(
                          title: Text(
                              '${searchController.filteredList[index].name ?? ''}',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          subtitle: Text(
                              '${searchController.filteredList[index].age ?? ''} yr old ${searchController.filteredList[index].city ?? ''}, ${searchController.filteredList[index].country ?? ''}, ${searchController.filteredList[index].martialStatus} ',
                              style: TextStyle(fontSize: 15)),
                          leading: CircleAvatar(
                            radius: 30,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(searchController
                                          .filteredList[index].imageProfile ??
                                      ''),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          trailing:
                              Icon(Icons.favorite, color: Colors.red, size: 35),
                        ),
                      );
                    },
                  ))
                ],
              )));
  }
}
