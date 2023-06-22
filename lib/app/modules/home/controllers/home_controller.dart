// ignore_for_file: unrelated_type_equality_checks, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/ongkir_model.dart';

class HomeController extends GetxController {
  TextEditingController beratC = TextEditingController();

  RxString provAsalID = "0".obs;
  RxString kotaAsalID = "0".obs;
  RxString provTujuanID = "0".obs;
  RxString kotaTujuanID = "0".obs;
  List<Ongkir> ongkosKirim = [];
  RxBool isLoading = false.obs;

  RxString codeKurir = "".obs;

  void cekOngkir() async {
    if (provAsalID != 0 &&
        provTujuanID != 0 &&
        kotaAsalID != 0 &&
        kotaTujuanID != 0 &&
        codeKurir != "" &&
        beratC != "") {
      try {
        isLoading.value = true;
        var response = await http.post(
          Uri.parse("https://api.rajaongkir.com/starter/cost"),
          headers: {
            "key": "c1e42a2aee22fb56cc2532b9ae115f90",
            'content-type': 'application/x-www-form-urlencoded'
          },
          body: {
            "origin": kotaAsalID.value,
            "destination": kotaTujuanID.value,
            "weight": beratC.text,
            "courier": codeKurir.value,
          },
        );
        isLoading.value = false;
        List ongkir = json.decode(response.body)["rajaongkir"]["results"][0]
            ["costs"] as List;
        ongkosKirim = Ongkir.fromJsonList(ongkir);

        Get.defaultDialog(
          backgroundColor: Colors.teal,
          titlePadding: const EdgeInsets.all(25),
          title: "Ongkos Kirimnya...",
          titleStyle: const TextStyle(color: Colors.lime),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ongkosKirim
                .map(
                  (e) => ListTile(
                    title: Text(
                      e.description!.toUpperCase(),
                      style: const TextStyle(color: Colors.lime),
                    ),
                    subtitle: Text(
                      "Rp ${e.cost![0].value} --- Estimasi ${e.cost![0].etd!.replaceAll("HARI", "")} Hari",
                      style: const TextStyle(color: Colors.lime),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      } catch (e) {
        print(e);
        Get.defaultDialog(
            titlePadding: const EdgeInsets.all(25),
            title: "Terjadi Kesalahan",
            titleStyle: const TextStyle(color: Colors.lime),
            middleText: "Tidak Dapat Cek Ongkos Kirim",
            middleTextStyle: const TextStyle(color: Colors.lime),
            backgroundColor: Colors.teal);
      }
    } else {
      Get.defaultDialog(
          titlePadding: const EdgeInsets.all(25),
          title: "Data input belum lengkap",
          titleStyle: const TextStyle(color: Colors.lime),
          middleText: "Mohon Lengkapi Data",
          middleTextStyle: const TextStyle(color: Colors.lime),
          backgroundColor: Colors.teal);
    }
  }
}
