import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racco_final/app/data/services.dart';
import 'package:racco_final/models/sav_ticket.dart';
import 'package:racco_final/models/t_user.dart';
import 'package:http/http.dart' as http;

import '../../../data/network.dart';
import '../../../data/vars.dart';

class HomeController extends GetxController {
  TUser? user;
  bool loading = false;
  bool loadingFind = false;
  List<SavTicket> tickets = [];

  @override
  void onInit() {
    super.onInit();
    loading = true;
    tickets = [
      SavTicket(
        id: 1,
        client: Client(
            address: 'adslfj',
            clientId: 'test',
            sip: 'test sip',
            name: "test test"),
        description: 'Description 1',
        status: 'En cours',
        type: 'Type 1',
      ),
      SavTicket(
        id: 1,
        client: Client(
            address: 'adslfj',
            clientId: 'test222',
            sip: 'test 2sip',
            name: "test 2test"),
        description: 'Description 1',
        status: 'En cours',
        type: 'Type 1',
      ),
    ];
    update();
    getUserFromMemory().then((value) async {
      user = value;
      loading = false;
      update();
    });
  }

  Future<void> demanderClients() async {
    loadingFind = true;
    update();
    String deviceKey = await getDeviceIdentifier();
    String buildNumber = await getBuild() ?? '0';
    await http.post(
      Uri.parse('$baseUrl/demanderClientsApi/${user!.id}'),
      headers: await Network.headers(),
      body: {'device_key': deviceKey, 'build_number': buildNumber},
    ).then((response) async {
      print(response.body);

      switch (response.statusCode) {
        case 200:
          loadingFind = false;
          update();

          break;
        case 401:
          Get.snackbar("Erreur", jsonDecode(response.body)['message'],
              colorText: Colors.white, backgroundColor: Colors.red);
          loadingFind = false;
          update();
          break;
        default:
          Get.snackbar('Erreur', jsonDecode(response.body)['message'],
              colorText: Colors.white, backgroundColor: Colors.red);
          loadingFind = false;
          update();
          break;
      }
    }).catchError((error) {
      loadingFind = false;
      update();
      throw error;
    });
  }

  reload() {
    loading = true;
    update();

    getUserFromBd().then((value) async {
      resaveUserToSessionFromBd(value);
      if (value.id != null) {
        user = value;
      }

      loading = false;
      update();
    });
  }
}
