import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookDetailScreen extends StatefulWidget {
  final String studentId;
  const BookDetailScreen({super.key, required this.studentId});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _depositController = TextEditingController();
  String selectedCondition = 'Initial';

  final List<String> bookConditions = ['Initial', 'Mid-Year', 'Final'];

  Future<void> addNewBookRecord() async {
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    final deposit = double.tryParse(_depositController.text.trim()) ?? 0;
    final finalDeposit = deposit > amount ? amount : deposit;

    final docRef = FirebaseFirestore.instance
        .collection('students')
        .doc(widget.studentId);

    // Add new book detail
    await docRef.collection('books_detail').add({
      'condition': selectedCondition,
      'amount': amount.toStringAsFixed(0),
      'depositamount': finalDeposit.toStringAsFixed(0),
    });

    // Only update arrears if deposit is less than amount
    if (amount > finalDeposit) {
      final snapshot = await docRef.get();
      final data = snapshot.data();

      double currentArrears = 0;
      if (data != null && data.containsKey('arrears')) {
        currentArrears = double.tryParse(data['arrears'].toString()) ?? 0;
      }

      final newArrears = currentArrears + (amount - finalDeposit);
      await docRef.update({
        'arrears': newArrears.toStringAsFixed(0),
      });
    }

    _amountController.clear();
    _depositController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Books Detail', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .doc(widget.studentId)
            .collection('books_detail')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No book records found.'));
          }

          final records = snapshot.data!.docs;

          final cards = records.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final amount = double.tryParse(data['amount'].toString()) ?? 0;
            final deposit = double.tryParse(data['depositamount'].toString()) ?? 0;

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text("Condition: ${data['condition']}",
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Amount: Rs. ${amount.toStringAsFixed(0)}",
                          style: theme.textTheme.bodyLarge),
                      Text("Deposit: Rs. ${deposit.toStringAsFixed(0)}",
                          style: theme.textTheme.bodyLarge),
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
                Text("Add New Book Record", style: theme.textTheme.headlineSmall),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedCondition,
                  items: bookConditions
                      .map((condition) => DropdownMenuItem(value: condition, child: Text(condition)))
                      .toList(),
                  onChanged: (value) => setState(() => selectedCondition = value!),
                  decoration: _inputDecoration('Book Condition'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _amountController,
                  decoration: _inputDecoration('Amount'),
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
                    onPressed: addNewBookRecord,
                    icon: const Icon(Icons.library_books, color: Colors.white),
                    label: const Text('Add Book Record', style: TextStyle(color: Colors.white)),
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
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}
