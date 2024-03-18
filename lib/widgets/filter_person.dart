import 'package:dating_app/controller/searchController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  SearchPersonController controller = Get.find<SearchPersonController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: 50,
          leading: InkWell(
              onTap: () => Get.back(),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: const Icon(Icons.arrow_back_ios, size: 20),
              )),
          title: const Text("Filters"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 9),
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xff7F01FC)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    minimumSize: MaterialStateProperty.all<Size>(Size(60, 20)),
                  ),
                  onPressed: () {
                    controller.filterData();
                    Get.back();
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.white),
                  )),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Container(
              // height: MediaQuery.of(context).size.height * 2.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" Your preference for meetup",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      )),
                  const SizedBox(height: 8),
                  const SizedBox(height: 22),
                  Text(
                    " Age",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: RangeSlider(
                                  values: controller.ageRange
                                      .value, // Set initial values within the range
                                  min: 15,
                                  max: 100,
                                  onChanged: (value) {
                                    controller.ageRange.value = value;
                                  },
                                  divisions: 5,
                                )),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.ageRange.value.start.toInt()}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                Text(
                                  "${controller.ageRange.value.end.toInt()}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    " Distance",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Slider(
                                  value:
                                      controller.distanceValue.value == (-1.0)
                                          ? 0.0
                                          : controller.distanceValue.value,
                                  onChanged: (newValue) {
                                    controller.distanceValue.value = newValue;
                                  },
                                  min: 0.0,
                                  max:
                                      30, // Set the min and max values as needed
                                )),
                          ),
                          Text(
                              'Distance: ${controller.distanceValue.value.toInt()}')
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    " Height",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Height",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Center(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Slider(
                                  value: controller.heightValue.value == (-1.0)
                                      ? 50.0
                                      : controller.heightValue.value,
                                  onChanged: (newValue) {
                                    controller.heightValue.value = newValue;
                                  },
                                  min: 50.0,
                                  max:
                                      200, // Set the min and max values as needed
                                )),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Height ${controller.heightValue.value.toInt()}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    " Weight",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Slider(
                                  value: controller.weightValue.value == (-1.0)
                                      ? 0.0
                                      : controller.weightValue.value,
                                  onChanged: (newValue) {
                                    controller.weightValue.value = newValue;
                                  },
                                  min: 0.0,
                                  max:
                                      100, // Set the min and max values as needed
                                )),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Weight ${controller.weightValue.value.toInt()}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Gender",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: "male",
                            groupValue: controller.genderValue.value,
                            onChanged: (value) {
                              controller.genderValue.value = value!;
                            },
                          ),
                          Text("Male"),
                          Radio(
                            value: "female",
                            groupValue: controller.genderValue.value,
                            onChanged: (value) {
                              controller.genderValue.value = value!;
                            },
                          ),
                          Text("Female"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Religion",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: controller.religionValue.value,
                      onChanged: (String? newValue) {
                        controller.religionValue.value = newValue!;
                      },
                      items: <String>[
                        "Select Religion",
                        "Christianity",
                        "Islam",
                        "Hinduism",
                        "Buddhism",
                        "Judaism",
                        "Sikhism",
                        "Other"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        )));
  }
}
