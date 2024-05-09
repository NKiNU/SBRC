import 'package:barcodee/feature/login.dart';
import 'package:barcodee/model/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

// import 'firebase_options.dart';


// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   // @override
//   // Widget build(BuildContext context) {
//   //   return MaterialApp(
//   //     title: 'QR',
//   //     theme: ThemeData(
//   //     ),
//   //     initialRoute: '/ Login',
//   //     routes: {
//   //       '/': (context) => const LoginPage()

//   //     },
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return _buildMobileLayout();
//         },
//       ),
//     );
//   }

//   // Widget _buildMobileLayout() {
//   //   return Column(
//   //     children: [
//   //       Expanded(
//   //         child: Container(
//   //           color: Colors.white,
//   //           child: Column(
//   //             mainAxisAlignment: MainAxisAlignment.center,
//   //             children: [
//   //               Row(
//   //                 mainAxisAlignment: MainAxisAlignment.center,
//   //                 children: [
//   //                   Image.asset(
//   //                     'images/1.png',
//   //                     width: 60,
//   //                     height: 60,
//   //                   ),
//   //                   Text(
//   //                     'RajaMark',
//   //                     style: GoogleFonts.poppins(
//   //                       fontSize: 24,
//   //                       fontWeight: FontWeight.bold,
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //               const SizedBox(height: 20),
//   //               Expanded(
//   //                 child: FractionallySizedBox(
//   //                   widthFactor: 1.0,
//   //                   child: FittedBox(
//   //                     fit: BoxFit.fitHeight,
//   //                     child: SvgPicture.asset(
//   //                       'images/examIllustration.svg',
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //       Expanded(
//   //         child: Container(
//   //           color: const Color.fromARGB(255, 255, 255, 255),
//   //           child: Center(
//   //             child: Container(
//   //               width: MediaQuery.of(BuildContext as BuildContext).size.width,
//   //               height: 700,
//   //               color: Colors.white,
//   //               child: const Padding(
//   //                 padding: EdgeInsets.only(left: 16.0, right: 16.0),
//   //                 child: Center(child: LoginModule()),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }
// }

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(

  options: DefaultFirebaseOptions.currentPlatform,

);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LoginPage(),
    );
  }
}
