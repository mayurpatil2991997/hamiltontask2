import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamilton/controllers/home/home_controller.dart';
import 'package:hamilton/core/strings.dart';
import 'package:hamilton/core/theme/app_color.dart';
import 'package:hamilton/core/theme/app_text_style.dart';
import 'package:hamilton/widgets/appBar/appBar.dart';
import 'package:hamilton/widgets/button/button_widget.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  DateTime? picked;
  DateTime? pickedDelivery;

  @override
  Widget build(BuildContext context) {
    // Ensure initialization of the now and nowDelivery values
    homeController.now.value ??= DateTime.now();
    homeController.nowDelivery.value ??= DateTime.now();

    return Scaffold(
      backgroundColor: AppColor.whiteColor.withOpacity(0.9),
      appBar: CustomAppBar(
        title: homeText,
        backgroundColor: AppColor.primaryColor,
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Text(
                selectCollection,
                style: AppTextStyle.bold
                    .copyWith(fontSize: 20, color: AppColor.blackColor),
              ),
            ),
            Container(
              height: 20.h,
              child: GridView.builder(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                itemCount: homeController.titleList.length,
                itemBuilder: (ctx, index) {
                  return Obx(() => InkWell(
                    onTap: () async {
                      homeController.selectedIndex.value = index;
                      if (index == 2) {
                        picked = await showDatePicker(
                          context: context,
                          initialDate: homeController.now.value!,
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 365)),
                          lastDate:
                          DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null &&
                            picked != homeController.now.value) {
                          homeController.selectDate(picked!);
                        }
                      }
                    },
                    child: Container(
                      height: 10.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: homeController.selectedIndex.value == index
                            ? AppColor.blueColor.withOpacity(0.5)
                            : AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                              color: AppColor.greyColor, //New
                              blurRadius: 25.0,
                              offset: Offset(0, 1))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              homeController.titleList[index],
                              style: AppTextStyle.regular.copyWith(
                                  color: homeController
                                      .selectedIndex.value ==
                                      index
                                      ? AppColor.whiteColor.withOpacity(0.8)
                                      : AppColor.blackColor
                                      .withOpacity(0.8),
                                  fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: 0.3.h,
                          ),
                          Center(
                            child: Text(
                              index == 2
                                  ? (homeController.now.value != null
                                  ? DateFormat('yyyy-MM-dd')
                                  .format(homeController.now.value!)
                                  : 'Select Date')
                                  : DateFormat('yyyy-MM-dd').format(
                                  homeController.dateList[index].value),
                              style: AppTextStyle.semiBold.copyWith(
                                color: homeController.selectedIndex.value ==
                                    index
                                    ? AppColor.whiteColor
                                    : AppColor.blackColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        morning,
                        style: AppTextStyle.semiBold.copyWith(
                            color: AppColor.blackColor, fontSize: 16),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<String>(
                          items: homeController.morningTime
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              homeController.selectedValue1.isEmpty
                                  ? selectTime
                                  : homeController.selectedValue1.value,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          underline: const SizedBox(),
                          isExpanded: true,
                          onChanged: (String? value) {
                            if (value != null) {
                              homeController.morningSlot(value);
                            }
                          },
                        ),
                      ),
                    ],
                  )),
                  Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        afternoon,
                        style: AppTextStyle.semiBold.copyWith(
                            color: AppColor.blackColor, fontSize: 16),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<String>(
                          items: homeController.eveningTime
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              homeController.selectedValue2.isEmpty
                                  ? selectTime
                                  : homeController.selectedValue2.value,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          underline: const SizedBox(),
                          isExpanded: true,
                          onChanged: (String? value) {
                            if (value != null) {
                              homeController.eveningSlot(value);
                            }
                          },
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Text(
                selectDelivery,
                style: AppTextStyle.bold
                    .copyWith(fontSize: 20, color: AppColor.blackColor),
              ),
            ),
            Container(
              height: 20.h,
              child: GridView.builder(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                itemCount: homeController.titleList.length,
                itemBuilder: (ctx, index) {
                  return Obx(() => InkWell(
                    onTap: () async {
                      homeController.selectedIndexDelivery.value = index;
                      if (index == 2) {
                        pickedDelivery = await showDatePicker(
                          context: context,
                          initialDate: homeController.nowDelivery.value!,
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 365)),
                          lastDate:
                          DateTime.now().add(const Duration(days: 365)),
                        );
                        if (pickedDelivery != null &&
                            pickedDelivery !=
                                homeController.nowDelivery.value) {
                          homeController.selectDateDelivery(
                              pickedDelivery!);
                        }
                      }
                    },
                    child: Container(
                      height: 10.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: homeController.selectedIndexDelivery.value ==
                            index
                            ? AppColor.blueColor.withOpacity(0.5)
                            : AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                              color: AppColor.greyColor, //New
                              blurRadius: 25.0,
                              offset: Offset(0, 1))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              homeController.titleList[index],
                              style: AppTextStyle.regular.copyWith(
                                  color: homeController
                                      .selectedIndexDelivery
                                      .value ==
                                      index
                                      ? AppColor.whiteColor.withOpacity(0.8)
                                      : AppColor.blackColor
                                      .withOpacity(0.8),
                                  fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: 0.3.h,
                          ),
                          Center(
                            child: Text(
                              index == 2
                                  ? (homeController.nowDelivery.value !=
                                  null
                                  ? DateFormat('yyyy-MM-dd').format(
                                  homeController
                                      .nowDelivery.value!)
                                  : 'Select Date')
                                  : DateFormat('yyyy-MM-dd').format(
                                  homeController.dateList[index].value),
                              style: AppTextStyle.semiBold.copyWith(
                                color: homeController
                                    .selectedIndexDelivery.value ==
                                    index
                                    ? AppColor.whiteColor
                                    : AppColor.blackColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        morning,
                        style: AppTextStyle.semiBold.copyWith(
                            color: AppColor.blackColor, fontSize: 16),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<String>(
                          items: homeController.morningTimeDelivery
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              homeController.selectedValue1Delivery.isEmpty
                                  ? selectTime
                                  : homeController
                                  .selectedValue1Delivery.value,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          underline: const SizedBox(),
                          isExpanded: true,
                          onChanged: (String? value) {
                            if (value != null) {
                              homeController.morningSlotDelivery(value);
                            }
                          },
                        ),
                      ),
                    ],
                  )),
                  Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        afternoon,
                        style: AppTextStyle.semiBold.copyWith(
                            color: AppColor.blackColor, fontSize: 16),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<String>(
                          items: homeController.eveningTimeDelivery
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              homeController.selectedValue2Delivery.isEmpty
                                  ? selectTime
                                  : homeController
                                  .selectedValue2Delivery.value,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          underline: const SizedBox(),
                          isExpanded: true,
                          onChanged: (String? value) {
                            if (value != null) {
                              homeController.eveningSlotDelivery(value);
                            }
                          },
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Center(
              child: ButtonWidget(
                text: continueText,
                textStyle: AppTextStyle.medium
                    .copyWith(color: AppColor.whiteColor, fontSize: 16),
                onTap: () {
                  // Add print statements to debug
                  print(
                      "Collection Date: ${homeController.now.value != null ? DateFormat('yyyy-MM-dd').format(homeController.now.value!) : 'null'}");
                  print(
                      "Delivery Date: ${homeController.nowDelivery.value != null ? DateFormat('yyyy-MM-dd').format(homeController.nowDelivery.value!) : 'null'}");

                  String? collectionDate = homeController.now.value != null
                      ? DateFormat('yyyy-MM-dd').format(homeController.now.value!)
                      : null;
                  String? deliveryDate =
                  homeController.nowDelivery.value != null
                      ? DateFormat('yyyy-MM-dd')
                      .format(homeController.nowDelivery.value!)
                      : null;

                  if (collectionDate == deliveryDate) {
                    print("dnkfnknfg");
                    Get.snackbar(
                      'Alert',
                      'Collection and Delivery Date Should not be the same',
                      backgroundColor: AppColor.primaryColor,
                      colorText: AppColor.whiteColor,
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 3),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
