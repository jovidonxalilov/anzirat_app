import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationProvider with ChangeNotifier {
  double?  lat;
  double?  saveLat;
  double? long;
  double? saveLong;
  String saveCountry = "yuklanmoqda";
  String country = "yuklanmoqda";
  String city = "yuklanmoqda";
  String saveCity = "yuklanmoqda";
  String locality = "Yuklanmoqda...";
  String saveLocality = "Yuklanmoqda...";
  bool isWorking = false;
  bool isLoading = true;

  void startListening() {
    FirebaseFirestore.instance
        .collection('location')
        .doc('shipiyon')
        .snapshots()
        .listen((doc) {
      if (doc.exists) {
        lat = (doc.data()?['lat'] as num?)?.toDouble();
        long = (doc.data()?['long'] as num?)?.toDouble();
        isWorking = doc.data()?['isWorking'] ?? false;

        if (lat != null && long != null) {
          _fetchLocationName(lat!, long!);
        }

        notifyListeners();
      }
    });
  }
  Future<void> saveLocation() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('location_history')
        .doc('shipiyon')
        .collection('positions')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      saveLat = (doc.data()['lat'] as num?)?.toDouble();
      saveLong = (doc.data()['long'] as num?)?.toDouble();
      isWorking = doc.data()['isWorking'] ?? false;

      if (lat != null && long != null) {
        _fetchLocationName(lat!, long!);
      }

      notifyListeners();
    }
  }

  Future<void> _fetchLocationName(double lat, double long) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
      'https://www.gps-coordinates.net/geoproxy?q=$lat+$long&key=9416bf2c8b1d4751be6a9a9e94ea85ca&no_annotations=1&language=en',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        country = data['results'][0]['components']['country'] ?? "Noma'lum joy";
        saveCountry = data['results'][0]['components']['country'] ?? "Noma'lum joy";
        city = data['results'][0]['components']['city'] ?? "Noma'lum joy";
        saveCity = data['results'][0]['components']['city'] ?? "Noma'lum joy";
        locality = data['results'][0]['components']['locality'] ?? "Noma'lum joy";
        saveLocality = data['results'][0]['components']['locality'] ?? "Noma'lum joy";
      } else {
        locality = "API xato: ${response.statusCode}";
      }
    } catch (e) {
      locality = "Joy nomini olishda xato";
    }

    isLoading = false;
    notifyListeners();
  }
}
