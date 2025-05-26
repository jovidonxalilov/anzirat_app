import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapPage extends StatefulWidget {
  const YandexMapPage({super.key});

  @override
  State<YandexMapPage> createState() => _YandexMapPageState();
}

class _YandexMapPageState extends State<YandexMapPage> {
  late YandexMapController _mapController;

  final List<Map<String, dynamic>> _markerData = [
    {
      'id': '1',
      'point': const Point(latitude: 41.3111, longitude: 69.2797),
      'title': 'Toshkent markazi',
    },
    {
      'id': '2',
      'point': const Point(latitude: 41.3275, longitude: 69.2814),
      'title': 'Chorsu bozori',
    },
  ];

  final Map<String, PlacemarkMapObject> _placemarks = {};

  @override
  void initState() {
    super.initState();
    for (var data in _markerData) {
      _placemarks[data['id']] = PlacemarkMapObject(
        mapId: MapObjectId(data['id']),
        point: data['point'],
        onTap: (_, __) {
          _showInfoBottomSheet(data['title']);
        },
      );
    }
  }

  void _showInfoBottomSheet(String title) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _onMapTap(Point point) async {
    await _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: 15),
      ),
      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yandex Map')),
      body: YandexMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        onMapTap: _onMapTap,
        mapObjects: _placemarks.values.toList(),
      ),
    );
  }
}

