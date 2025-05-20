import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../common/bottom_navigation_bar_widget.dart';
import '../navigation/routes.dart';
import '../provider.dart';

class FlutterMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, provider, _) {
        final lat = provider.lat;
        final long = provider.long;

        if (lat == null || long == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text("Google Map")),
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, long),
              zoom: 16,
            ),
            markers: {
              Marker(
                markerId: MarkerId("current_location"),
                position: LatLng(lat, long),
                infoWindow: InfoWindow(title: provider.locality),
              ),
            },
            onMapCreated: (controller) {
            },
          ),
          bottomNavigationBar: BottomNavigationBarMap(selectedIndex: 0,
            onTap: (index) {
              switch (index) {
                case 0:
                  context.push(Routes.home);
                  break;
                case 1:
                  context.push(Routes.map);
                  break;
              }
            },),
        );
      },
    );
  }
}
