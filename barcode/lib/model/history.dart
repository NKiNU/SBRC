import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
    );
  }

  Widget _buildHistoryList() {
    final User? user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .collection('scanned_data')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

         return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            var scannedData = snapshot.data?.docs[index].data() as Map<String, dynamic>;
            var timestamp = (scannedData['timestamp'] as Timestamp).toDate();
            var formattedDate =
                '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute}';
            return ListTile(
              title: Text('Scanned Data: ${scannedData['data']}'),
              subtitle: Text('Scanned At: $formattedDate'),
            );
          },
        );
      },
    );
  }
}