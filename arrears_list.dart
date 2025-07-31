import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArrearsListScreen extends StatelessWidget {
  const ArrearsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students with Arrears', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('students').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No student records found.'));
          }

          final students = snapshot.data!.docs;
          final arrearStudents = students.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final arrears = double.tryParse(data['arrears']?.toString() ?? '0') ?? 0;
            return arrears > 0;
          }).toList();

          if (arrearStudents.isEmpty) {
            return const Center(child: Text('All students are clear.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: arrearStudents.length,
            itemBuilder: (context, index) {
              final data = arrearStudents[index].data() as Map<String, dynamic>;
              final name = data['name'] ?? 'Unnamed';
              final arrears = double.tryParse(data['arrears'].toString()) ?? 0;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: const Icon(Icons.person, color: Colors.deepPurple),
                  title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  subtitle: Text("Arrears: Rs. ${arrears.toStringAsFixed(0)}",
                      style: const TextStyle(color: Colors.red, fontSize: 15)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
