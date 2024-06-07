import 'dart:convert';
import 'package:get/get.dart';
import 'package:hamilton/core/strings.dart';

class HomeController extends GetxController {
  final RxList titleList = [
    todayText,
    tomorrowText,
    selectDate1,
  ].obs;

  List<String> morningTime = [
    "7am - 8am",
    "8am - 9am",
    "9am - 10am",
    "10am - 1am",
  ].obs;

  List<String> morningTimeDelivery = [
    "7am - 8am",
    "8am - 9am",
    "9am - 10am",
    "10am - 1am",
  ].obs;

  List<String> eveningTime = [
    "4pm - 5pm",
    "5pm - 6pm",
    "6pm - 7pm",
    "7pm - 8pm",
  ].obs;

  List<String> eveningTimeDelivery = [
    "4pm - 5pm",
    "5pm - 6pm",
    "6pm - 7pm",
    "7pm - 8pm",
  ].obs;

  void morningSlot(String? value) {
    selectedValue1.value = value!;
    selectedValue2.value = ''; // Clear afternoon selection
  }
  void morningSlotDelivery(String? value) {
    selectedValue1Delivery.value = value!;
    selectedValue2Delivery.value = ''; // Clear afternoon selection
  }

  void eveningSlot(String? value) {
    selectedValue2.value = value!;
    selectedValue1.value = ''; // Clear morning selection
  }
  void eveningSlotDelivery(String? value) {
    selectedValue2Delivery.value = value!;
    selectedValue1Delivery.value = ''; // Clear morning selection
  }

  var selectedValue1 = ''.obs;
  var selectedValue1Delivery = ''.obs;
  var selectedValue2 = ''.obs;
  var selectedValue2Delivery = ''.obs;

  var selectedIndex = 0.obs;
  var selectedIndexDelivery = 0.obs;

  var now = DateTime.now().obs;
  var nowDelivery = DateTime.now().obs;


  void selectDate(DateTime date) {
    now.value = date;
  }

  void selectDateDelivery(DateTime date) {
    nowDelivery.value = date;
  }

  var tomorrow = DateTime.now().add(Duration(days: 1)).obs;

  var dateList = <Rx<DateTime>>[
      DateTime.now().obs,
      DateTime.now().add(Duration(days: 1)).obs,
      DateTime.now().obs,
    ].obs;
}
