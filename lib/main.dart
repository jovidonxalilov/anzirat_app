import 'package:anzirat/navigation/router.dart';
import 'package:anzirat/page/anzirat_detail.dart';
import 'package:anzirat/page/sotti_detail.dart';
import 'package:anzirat/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          final provider = LocationProvider();
          provider.startListening();
          return provider;
        },)
      ],
      child: ScreenUtilInit(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text("Anzirat buvi App"))),
        body: Consumer<LocationProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const CircularProgressIndicator();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 60, right: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Holat: ",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        provider.isWorking
                            ? "Shipiyon ishlayapti"
                            : "Shipiyon dam olayapti",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Row(
                    children: [
                      Text("Region:",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                      Text(provider.saveCountry,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Viloyat:",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                      Text(provider.city,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Manzil:",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                      Text(provider.locality,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Ma'ruza matni

//https://www.notion.so/Working-with-permissions-in-the-app-Location-package-1f5d69b6ee4b80ee9667e4650ee9b33c?pvs=4

// FirebaseStoredan foydalanib 2ta app yasaymiz.

// Bu app nomlari Anzirat buvi va Sotti

// Sotti appda location real yangilanib turadi va ma'lumotlar firestore orqali Anzirat buvi ilovasiga boradi.

// Anzirat buvi ilovasida ham long/lat ko'rinishi kerak.

/// Undan tashqari joy nomi ko'rinishi kerak

// Joylashuv nomini olish uchun API:

// https://www.gps-coordinates.net/geoproxy?q=[lat]+[long]&key=9416bf2c8b1d4751be6a9a9e94ea85ca&no_annotations=1&language=en

/// StreamBuilder orqali qilinmasin, Provider ishlatilsin.

// Endi sotti har 30 yurganda joylashuv yangilansin.

// Agar sotti ilovani ochib turgan bo'lsa Anzirat buvida shipiyon ishda/Shipyon dam olyapti.
