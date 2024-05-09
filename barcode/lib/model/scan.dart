import 'package:barcodee/model/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQR extends StatefulWidget {
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  String qrCodeResult = "Not Yet Scanned";

  Future<void> scanQR() async {
    try {
      final qrcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      if (qrcode == '-1') {
        // User canceled scanning
        setState(() {
          qrCodeResult = "Scan canceled";
        });
      } else {
        // Scanned successfully
        setState(() {
          qrCodeResult = qrcode;
          _saveDataToFirestore(qrCodeResult);
        });
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
      }
    } on PlatformException catch (e) {
      // Handle platform exceptions
      setState(() {
        qrCodeResult = "Failed to scan: ${e.message}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Message displayed over here
            Text(
              "Result",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),

            //Button to scan QR code
            ElevatedButton(
              onPressed: scanQR,
              child: Text(
                "Open Scanner",
                style: TextStyle(color: Colors.indigo[900]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _saveDataToFirestore(String data) async {
  final User? user = FirebaseAuth.instance.currentUser;
  List<String> parts = data.split(',');
  Map<String, int> materialPoints = {};
  parts.forEach((part) {
    List<String> item = part.trim().split(':');
    materialPoints[item[0].trim()] = int.parse(item[1].trim());
  });
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('scanned_data')
        .add({
      'data': materialPoints,
      'timestamp': FieldValue.serverTimestamp(),
    });

    int totalPoints = 0;
    materialPoints.forEach((key, value) {
      totalPoints += value;
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .update({'total_points': FieldValue.increment(totalPoints)});
  } catch (e) {
    print(e);
  }
}
