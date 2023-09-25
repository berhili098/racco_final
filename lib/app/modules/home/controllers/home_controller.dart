import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racco_final/app/data/services.dart';
import 'package:racco_final/models/affectation.dart';
import 'package:racco_final/models/sav_ticket.dart';
import 'package:racco_final/models/t_notification.dart';
import 'package:racco_final/models/t_user.dart';
import 'package:http/http.dart' as http;

import '../../../data/network.dart';
import '../../../data/vars.dart';

class HomeController extends GetxController {
  TUser? user;
  bool loading = false;
  bool loadingFind = false;
  List<SavTicket> tickets = [];
  List<SavTicket> plannedTickets = [];
  List<TNotication> notifications = [];
  List<Affectations> affectations = [];
  List<Affectations> plannedAffectations = [];

  @override
  void onInit() {
    super.onInit();
    loading = true;

    update();

    getUserFromMemory().then((value) async {
      user = value;
      update();
      await getAllNotifications();
      await getPlanifiedTicket();
      await getAffectations();
      await getPlanifiedAffectations();
      getSavTickets().then((value2) {
        loading = false;
        update();
      });
    });
  }

  getPlanifiedAffectations() async {
    loadingFind = true;
    update();
    await http
        .get(
      Uri.parse('$baseUrl/getPlannedAffectations/${user!.technicien!.id}'),
      headers: await Network.headers(),
    )
        .then((response) {
      print(response.body);
      print(response.statusCode);

      switch (response.statusCode) {
        case 200:
          plannedAffectations = [];
          List<dynamic> data = jsonDecode(response.body)['Affectations'];
          for (var element in data) {
            plannedAffectations.add(Affectations.fromJson(element));
          }
          print(plannedAffectations.length);
          loadingFind = false;
          update();

          break;
        case 401:
          Get.snackbar('Erreur', jsonDecode(response.body)['Affectations'],
              colorText: Colors.white, backgroundColor: Colors.red);
          loadingFind = false;
          update();
          break;
        default:
          Get.snackbar('Erreur', jsonDecode(response.body)['Affectations'],
              colorText: Colors.white, backgroundColor: Colors.red);
          loadingFind = false;
          update();
          break;
      }
    });
  }

  getSavTickets() async {
    loadingFind = true;
    update();
    await http
        .get(
      Uri.parse('$baseUrl/getSavTickets/${user!.technicien!.id}'),
      headers: await Network.headers(),
    )
        .then((response) async {
      switch (response.statusCode) {
        case 200:
          tickets = [];
          List<dynamic> data = jsonDecode(response.body)['tickets'];
          for (var element in data) {
            tickets.add(SavTicket.fromJson(element));
          }
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

  getAffectations() async {
    loadingFind = true;
    update();
    await http
        .get(
      Uri.parse('$baseUrl/getAffectations/${user!.technicien!.id}'),
      headers: await Network.headers(),
    )
        .then((response) {
      switch (response.statusCode) {
        case 200:
          affectations = [];
          List<dynamic> data = jsonDecode(response.body)['Affectations'];
          for (var element in data) {
            affectations.add(Affectations.fromJson(element));
          }

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
    });
  }

  getPlanifiedTicket() async {
    loadingFind = true;
    update();
    await http
        .get(
      Uri.parse('$baseUrl/getPlanifiedTicket/${user!.technicien!.id}'),
      headers: await Network.headers(),
    )
        .then((response) async {
      switch (response.statusCode) {
        case 200:
          plannedTickets = [];
          List<dynamic> data = jsonDecode(response.body)['tickets'];
          for (var element in data) {
            plannedTickets.add(SavTicket.fromJson(element));
          }
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

  getAllNotifications() async {
    loadingFind = true;
    update();
    await http
        .get(
      Uri.parse('$baseUrl/notifications/${user!.id}'),
      headers: await Network.headers(),
    )
        .then((response) async {
      switch (response.statusCode) {
        case 200:
          notifications = [];
          List<dynamic> data = jsonDecode(response.body)['notifications'];
          for (var element in data) {
            notifications.add(TNotication.fromJson(element));
          }
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
      switch (response.statusCode) {
        case 200:
          Get.snackbar("Success", ' Clients importés avec succès',
              colorText: Colors.white, backgroundColor: Colors.green);
          loadingFind = false;
          update();

          break;
        case 401:
          Get.snackbar("Erreur", jsonDecode(response.body)['message'],
              colorText: Colors.white, backgroundColor: Colors.red);
          loadingFind = false;
          update();
          logoutApi();
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

  reload() async {
    loading = true;
    update();

    getUserFromBd().then((value) async {
      getSavTickets().then((value2) async {
        resaveUserToSessionFromBd(value);

        if (value.id != null) {
          user = value;
          await getAllNotifications();
          await getAffectations();
          await getPlanifiedAffectations();
          await getPlanifiedTicket();
        }
      });

      loading = false;
      update();
    });
  }
}
