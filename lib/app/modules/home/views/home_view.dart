import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

import 'package:dropdown_search/dropdown_search.dart';

import '../../../data/models/province_model.dart';
import '../../../data/models/city_model.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: const Text(
          'CEK ONGKIR',
          style: TextStyle(color: Colors.limeAccent),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "DAERAH ASAL",
            style: TextStyle(color: Colors.limeAccent, fontSize: 25),
          ),
          DropdownSearch<Province>(
            popupProps: PopupProps.menu(
              menuProps: const MenuProps(backgroundColor: Colors.lime),
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.province}"),
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Provinsi asal",
                fillColor: Colors.lime,
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/province",
                queryParameters: {
                  "key": "c1e42a2aee22fb56cc2532b9ae115f90",
                },
              );

              return Province.fromJsonList(
                  response.data["rajaongkir"]["results"]);
            },
            onChanged: (value) =>
                controller.provAsalID.value = value?.provinceId ?? "0",
          ),
          const SizedBox(height: 10),
          DropdownSearch<City>(
            popupProps: PopupProps.menu(
              menuProps: const MenuProps(backgroundColor: Colors.lime),
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.type} ${item.cityName}"),
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Kota/Kabupaten asal",
                fillColor: Colors.lime,
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/city?province=${controller.provAsalID}",
                queryParameters: {
                  "key": "c1e42a2aee22fb56cc2532b9ae115f90",
                },
              );

              return City.fromJsonList(response.data["rajaongkir"]["results"]);
            },
            onChanged: (value) =>
                controller.kotaAsalID.value = value?.cityId ?? "0",
          ),
          const SizedBox(height: 25),
          const Text(
            "DAERAH TUJUAN",
            style: TextStyle(color: Colors.limeAccent, fontSize: 25),
          ),
          DropdownSearch<Province>(
            popupProps: PopupProps.menu(
              menuProps: const MenuProps(backgroundColor: Colors.lime),
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.province}"),
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Provinsi Tujuan",
                fillColor: Colors.lime,
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/province",
                queryParameters: {
                  "key": "c1e42a2aee22fb56cc2532b9ae115f90",
                },
              );

              return Province.fromJsonList(
                  response.data["rajaongkir"]["results"]);
            },
            onChanged: (value) =>
                controller.provTujuanID.value = value?.provinceId ?? "0",
          ),
          const SizedBox(height: 10),
          DropdownSearch<City>(
            popupProps: PopupProps.menu(
              menuProps: const MenuProps(backgroundColor: Colors.lime),
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.type} ${item.cityName}"),
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Kota/Kabupaten Tujuan",
                fillColor: Colors.lime,
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/city?province=${controller.provTujuanID}",
                queryParameters: {
                  "key": "c1e42a2aee22fb56cc2532b9ae115f90",
                },
              );

              return City.fromJsonList(response.data["rajaongkir"]["results"]);
            },
            onChanged: (value) =>
                controller.kotaTujuanID.value = value?.cityId ?? "0",
          ),
          const SizedBox(height: 25),
          const Text(
            "BERAT PAKET",
            style: TextStyle(color: Colors.limeAccent, fontSize: 25),
          ),
          TextField(
            controller: controller.beratC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: "Berat (gram)",
              fillColor: Colors.lime,
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "PILIH KURIR",
            style: TextStyle(color: Colors.limeAccent, fontSize: 25),
          ),
          DropdownSearch<Map<String, dynamic>>(
            items: const [
              {
                "code": "jne",
                "name": "JNE",
              },
              {
                "code": "pos",
                "name": "POS Indonesia",
              },
              {
                "code": "tiki",
                "name": "TIKI",
              },
            ],
            popupProps: PopupProps.menu(
              menuProps: const MenuProps(backgroundColor: Colors.lime),
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item["name"]}"),
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Pilih Kurir",
                fillColor: Colors.lime,
              ),
            ),
            dropdownBuilder: (context, selectedItem) =>
                Text("${selectedItem?["name"] ?? "Pilih Kurir"}"),
            onChanged: (value) => controller.codeKurir.value = value?['code'],
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lime,
            ),
            onPressed: () {
              if (controller.isLoading.isFalse) {
                controller.cekOngkir();
              }
            },
            child: Obx(() => Text(
                  controller.isLoading.isFalse ? "CEK ONGKIR" : "Loading....",
                  style: const TextStyle(color: Colors.black),
                )),
          ),
        ],
      ),
    );
  }
}
