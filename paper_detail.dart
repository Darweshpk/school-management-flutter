import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaperDetailScreen extends StatefulWidget {
  final String studentId;
  const PaperDetailScreen({super.key, required this.studentId});

  @override
  State<PaperDetailScreen> createState() => _PaperDetailScreenState();
}

class _PaperDetailScreenState extends State<PaperDetailScreen> {
  final TextEditingController _feeController = TextEditingController();
  final TextEditingController _depositController = TextEditingController();
  String selectedTerm = 'Term 1';

  final List<String> terms = ['Term 1', 'Term 2', 'Final Term'];

  Future<void> payNewPaperFee() async {
    final newFee = double.tryParse(_feeController.text.trim()) ?? 0;
    double newDeposit = double.tryParse(_depositController.text.trim()) ?? 0;

    if (newDeposit > newFee) {
      newDeposit = newFee;
    }

    final docRef = FirebaseFirestore.instance.collection('students').doc(widget.studentId);

    // Add paper_detail record
    await docRef.collection('paper_detail').add({
      'term': selectedTerm,
      'amount': newFee.toStringAsFixed(0),
      'depositamount': newDeposit.toStringAsFixed(0),
    });

    // Update arrears in students collection
    final docSnapshot = await docRef.get();
    final data = docSnapshot.data();

    if (data != null) {
      double currentArrears = double.tryParse(data['arrears'].toString()) ?? 0;
      if (newFee > newDeposit) {
        double extra = newFee - newDeposit;
        double updatedArrears = currentArrears + extra;
        await docRef.update({
          'arrears': updatedArrears.toStringAsFixed(0),
        });
      }
    }

    _feeController.clear();
    _depositController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paper Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .doc(widget.studentId)
            .collection('paper_detail')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No paper records found.'));
          }

          final records = snapshot.data!.docs;

          final cards = records.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final fee = double.tryParse(data['amount'].toString()) ?? 0;
            final deposit = double.tryParse(data['depositamount'].toString()) ?? 0;

            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text("Term: ${data['term']}",
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Fee: Rs. ${fee.toStringAsFixed(0)}", style: theme.textTheme.bodyLarge),
                      Text("Deposit: Rs. ${deposit.toStringAsFixed(0)}", style: theme.textTheme.bodyLarge),
                    ],
                  ),
                ),
              ),
            );
          }).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...cards,
                const SizedBox(height: 24),
                Text("Add New Paper Record", style: theme.textTheme.headlineSmall),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedTerm,
                  items: terms.map((term) => DropdownMenuItem(value: term, child: Text(term))).toList(),
                  onChanged: (value) => setState(() => selectedTerm = value!),
                  decoration: _inputDecoration('Select Term'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _feeController,
                  decoration: _inputDecoration('Fee Amount'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _depositController,
                  decoration: _inputDecoration('Deposit Amount'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: payNewPaperFee,
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('Add Paper Record', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.deepPurple.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}
