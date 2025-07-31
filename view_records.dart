// ✅ Updated View Screen with Beautiful Buttons for
// Fee, Paper, and Books Details Navigation

import 'package:aqsa_school/book_detail.dart';
import 'package:aqsa_school/fee_detail.dart';
import 'package:aqsa_school/paper_detail.dart';
import 'package:aqsa_school/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ViewRecordsScreen extends StatelessWidget {
  final String? searchName;
  const ViewRecordsScreen({super.key, this.searchName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Records', style: TextStyle(color: Colors.white)),
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

          var allDocs = snapshot.data!.docs;

          if (searchName != null && searchName!.trim().isNotEmpty) {
            final lowerCaseSearch = searchName!.trim().toLowerCase();
            allDocs = allDocs.where((doc) {
              final name = doc['name']?.toString().toLowerCase() ?? '';
              return name.contains(lowerCaseSearch);
            }).toList();
          }

          if (allDocs.isEmpty) {
            return const Center(child: Text('No matching records found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: allDocs.length,
            itemBuilder: (context, index) {
              var data = allDocs[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Name: ${data['name']}",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => EditStudentScreen(
                                        studentId: data.id,
                                        studentData: data.data() as Map<String, dynamic>,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text("Confirm Delete"),
                                      content: const Text("Are you sure you want to delete this record?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(ctx).pop(),
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.of(ctx).pop();
                                            await FirebaseFirestore.instance
                                                .collection('students')
                                                .doc(data.id)
                                                .delete();
                                          },
                                          child: const Text("Delete", style: TextStyle(color: Colors.red)),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text("Father: ${data['fatherName']}", style: const TextStyle(fontSize: 16)),
                      Text("DOB: ${data['dob']}", style: const TextStyle(fontSize: 16)),
                      Text("Contact: ${data['contact']}", style: const TextStyle(fontSize: 16)),
                      Text("Class: ${data['class']}", style: const TextStyle(fontSize: 16)),
                      const Divider(),
                      Text("Arrears: Rs. ${data['arrears']}",
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.red)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildDetailButton(
                            label: 'Fee Details',
                            icon: Icons.receipt_long,
                            context: context,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => FeeDetailScreen(studentId: data.id)),
                            ),
                          ),
                          _buildDetailButton(
                            label: 'Paper Details',
                            icon: Icons.assignment,
                            context: context,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PaperDetailScreen(studentId: data.id)),
                            ),
                          ),
                          _buildDetailButton(
                            label: 'Books Details',
                            icon: Icons.book,
                            context: context,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BookDetailScreen(studentId: data.id)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDetailButton({
    required String label,
    required IconData icon,
    required BuildContext context,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
