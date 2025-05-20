import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../common/bottom_navigation_bar_widget.dart';
import '../navigation/routes.dart';
import '../provider.dart';

class SottiDetail extends StatelessWidget {
  const SottiDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [Expanded(
          child: ListView.builder(
            itemCount: provider.saveLocality.length,
            itemBuilder: (context, index) =>  ListTile(
              title: Text(provider.saveLocality, style: TextStyle(color: Colors.black, fontSize: 15),),
            ),
          ),
        ),
        ],
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
  }
}
