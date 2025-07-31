import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeeDetailScreen extends StatefulWidget {
  final String studentId;
  const FeeDetailScreen({super.key, required this.studentId});

  @override
  State<FeeDetailScreen> createState() => _FeeDetailScreenState();
}

class _FeeDetailScreenState extends State<FeeDetailScreen> {
  final TextEditingController _feeController = TextEditingController();
  final TextEditingController _depositController = TextEditingController();
  String selectedMonth = 'January';

  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  Future<void> updateStudentTotals(double newFee, double newDeposit) async {
    final studentDoc = FirebaseFirestore.instance.collection('students').doc(widget.studentId);
    final subDocs = await studentDoc.collection('fee_detail').get();

    double totalFee = 0;
    double totalDeposit = 0;

    for (var doc in subDocs.docs) {
      final data = doc.data();
      totalFee += double.tryParse(data['amount'].toString()) ?? 0;
      totalDeposit += double.tryParse(data['depositamount'].toString()) ?? 0;
    }

    final studentSnapshot = await studentDoc.get();
    double oldArrears = double.tryParse(studentSnapshot.data()?['arrears']?.toString() ?? '0') ?? 0;
    double newArrear = newFee - newDeposit;
    double updatedArrears = oldArrears + newArrear;

    await studentDoc.update({
      'fee': totalFee.toStringAsFixed(0),
      'deposit': totalDeposit.toStringAsFixed(0),
      'arrears': updatedArrears.toStringAsFixed(0),
    });
  }

  Future<void> payNewMonthFee() async {
    final newFee = double.tryParse(_feeController.text.trim()) ?? 0;
    final newDeposit = double.tryParse(_depositController.text.trim()) ?? 0;

    final docRef = FirebaseFirestore.instance.collection('students').doc(widget.studentId);

    await docRef.collection('fee_detail').add({
      'month': selectedMonth,
      'amount': newFee.toStringAsFixed(0),
      'depositamount': newDeposit.toStringAsFixed(0),
    });

    await updateStudentTotals(newFee, newDeposit);

    _feeController.clear();
    _depositController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fee Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .doc(widget.studentId)
            .collection('fee_detail')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No fee records found.'));
          }

          final records = snapshot.data!.docs;
          double totalFee = 0;
          double totalDeposit = 0;

          final cards = records.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final fee = double.tryParse(data['amount'].toString()) ?? 0;
            final deposit = double.tryParse(data['depositamount'].toString()) ?? 0;
            totalFee += fee;
            totalDeposit += deposit;

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text("Month: ${data['month']}",
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Fee: Rs. ${fee.toStringAsFixed(0)}",
                          style: theme.textTheme.bodyLarge),
                      Text("Deposit: Rs. ${deposit.toStringAsFixed(0)}",
                          style: theme.textTheme.bodyLarge),
                    ],
                  ),
                ),
              ),
            );
          }).toList();

          double arrears = totalFee - totalDeposit;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...cards,
                const SizedBox(height: 20),
                Card(
                  color: Colors.deepPurple.shade50,
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Fee: Rs. ${totalFee.toStringAsFixed(0)}",
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text("Total Deposit: Rs. ${totalDeposit.toStringAsFixed(0)}",
                            style: theme.textTheme.titleMedium),
                        const SizedBox(height: 6),
                        Text("Arrears: Rs. ${arrears.toStringAsFixed(0)}",
                            style: theme.textTheme.titleMedium?.copyWith(color: Colors.red)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text("Add New Month Fee", style: theme.textTheme.headlineSmall),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedMonth,
                  items: months
                      .map((month) => DropdownMenuItem(value: month, child: Text(month)))
                      .toList(),
                  onChanged: (value) {
                    selectedMonth = value!;
                  },
                  decoration: _inputDecoration('Select Month'),
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
                    onPressed: payNewMonthFee,
                    icon: const Icon(Icons.payment, color: Colors.white),
                    label: const Text('Pay Fee of New Month', style: TextStyle(color: Colors.white)),
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
