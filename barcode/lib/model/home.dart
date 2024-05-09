import 'package:barcodee/model/generate.dart';
import 'package:barcodee/model/history.dart';
import 'package:barcodee/model/scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      // width: 500,
      // height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: TotalPointsWidget(),
            alignment: Alignment.center,
          ),
          const Image(
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQyYwscUPOH_qPPe8Hp0HAbFNMx-TxRFubpg&usqp=CAU")),

          //First Button
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ScanQR()));
            },
            child: Text(
              "Scan QR Code",
              style: TextStyle(color: Colors.indigo[900]),
            ),
          ),
          const SizedBox(height: 10),

          //Second Button
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HistoryPage()));
            },
            child: Text(
              "History",
              style: TextStyle(color: Colors.indigo[900]),
            ),
          ),
        ],
      ),
    ));
  }
}

class TotalPointsWidget extends StatelessWidget {
  const TotalPointsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        int totalPoints = snapshot.data?.get('total_points') ?? 0;

        return Text(
          'Total Points: $totalPoints',
          style: TextStyle(fontSize: 20),
        );
      },
    );
  }
}
