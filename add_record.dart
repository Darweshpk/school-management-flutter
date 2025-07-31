import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController feeController = TextEditingController();
  final TextEditingController booksController = TextEditingController();
  final TextEditingController paperController = TextEditingController();
  final TextEditingController depositController = TextEditingController();

  String selectedClass = '1';
  String selectedFeeMonth = 'January';
  String selectedBookCondition = 'Initial';
  String selectedPaperTerm = 'Term 1';

  double arrears = 0;

  void _calculateArrears() {
    double fee = double.tryParse(feeController.text) ?? 0;
    double books = double.tryParse(booksController.text) ?? 0;
    double paper = double.tryParse(paperController.text) ?? 0;
    double deposit = double.tryParse(depositController.text) ?? 0;

    setState(() {
      arrears = (fee + books + paper) - deposit;
    });
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2010),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  Future<void> _saveStudentRecord() async {
    try {
      double feeAmount = double.tryParse(feeController.text.trim()) ?? 0;
      double booksAmount = double.tryParse(booksController.text.trim()) ?? 0;
      double paperAmount = double.tryParse(paperController.text.trim()) ?? 0;
      double depositAmount = double.tryParse(depositController.text.trim()) ?? 0;

      final docRef = await FirebaseFirestore.instance.collection('students').add({
        'name': nameController.text.trim(),
        'fatherName': fatherNameController.text.trim(),
        'dob': dobController.text.trim(),
        'contact': contactController.text.trim(),
        'class': selectedClass,
        'fee': feeAmount.toStringAsFixed(0),
        'books': booksAmount.toStringAsFixed(0),
        'paper': paperAmount.toStringAsFixed(0),
        'deposit': depositAmount.toStringAsFixed(0),
        'arrears': arrears.toStringAsFixed(0),
      });

      double feeDeposit = depositAmount >= feeAmount ? feeAmount : depositAmount;

      await docRef.collection("fee_detail").add({
        "month": selectedFeeMonth,
        'amount': feeAmount.toStringAsFixed(0),
        'depositamount': feeDeposit.toStringAsFixed(0),
      });

      double remainingAfterFee = depositAmount - feeAmount;
      double paperDeposit = remainingAfterFee >= paperAmount ? paperAmount : (remainingAfterFee > 0 ? remainingAfterFee : 0);

      await docRef.collection("paper_detail").add({
        "term": selectedPaperTerm,
        'amount': paperAmount.toStringAsFixed(0),
        'depositamount': paperDeposit.toStringAsFixed(0),
      });

      double remainingAfterPaper = remainingAfterFee - paperAmount;
      double bookDeposit = remainingAfterPaper >= booksAmount ? booksAmount : (remainingAfterPaper > 0 ? remainingAfterPaper : 0);

      await docRef.collection("books_detail").add({
        "condition": selectedBookCondition,
        'amount': booksAmount.toStringAsFixed(0),
        'depositamount': bookDeposit.toStringAsFixed(0),
      });

      nameController.clear();
      fatherNameController.clear();
      dobController.clear();
      contactController.clear();
      feeController.clear();
      booksController.clear();
      paperController.clear();
      depositController.clear();
      setState(() {
        arrears = 0;
        selectedClass = '1';
      });

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text("Success 🎉"),
          content: const Text("Student record has been saved successfully!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving record: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student Record', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(nameController, 'Student Name'),
                _buildTextField(fatherNameController, 'Father Name'),
                GestureDetector(
                  onTap: _pickDate,
                  child: AbsorbPointer(
                    child: _buildTextField(dobController, 'Date of Birth (Tap to pick)', hint: 'DD-MM-YYYY'),
                  ),
                ),
                _buildTextField(contactController, 'Contact Number', keyboardType: TextInputType.phone),
                DropdownButtonFormField<String>(
                  value: selectedClass,
                  decoration: InputDecoration(
                    labelText: "Class",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.deepPurple.shade50,
                  ),
                  items: [
                    const DropdownMenuItem(value: 'PG', child: Text("PG")),
                    const DropdownMenuItem(value: 'Nursery', child: Text("Nursery")),
                    const DropdownMenuItem(value: 'Prep', child: Text("Prep")),
                    for (var i = 1; i <= 10; i++)
                      DropdownMenuItem(value: i.toString(), child: Text("Class $i")),
                  ],
                  onChanged: (value) => setState(() => selectedClass = value!),
                ),
                _buildTextField(feeController, 'Fee Amount', onChanged: (_) => _calculateArrears()),
                DropdownButtonFormField<String>(
                  value: selectedFeeMonth,
                  decoration: _dropdownDecoration('Fee Month'),
                  items: [
                    for (var month in [
                      'January', 'February', 'March', 'April', 'May', 'June',
                      'July', 'August', 'September', 'October', 'November', 'December'
                    ]) DropdownMenuItem(value: month, child: Text(month)),
                  ],
                  onChanged: (value) => setState(() => selectedFeeMonth = value!),
                ),
                _buildTextField(booksController, 'Books', onChanged: (_) => _calculateArrears()),
                DropdownButtonFormField<String>(
                  value: selectedBookCondition,
                  decoration: _dropdownDecoration('Book Condition'),
                  items: ['Initial', 'Mid-Year', 'Final']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => selectedBookCondition = value!),
                ),
                _buildTextField(paperController, 'Paper', onChanged: (_) => _calculateArrears()),
                DropdownButtonFormField<String>(
                  value: selectedPaperTerm,
                  decoration: _dropdownDecoration('Paper Term'),
                  items: ['Term 1', 'Term 2', 'Final Term']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => selectedPaperTerm = value!),
                ),
                _buildTextField(depositController, 'Deposit Amount', onChanged: (_) => _calculateArrears()),
                const SizedBox(height: 10),
                Text('Arrears: Rs. ${arrears.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveStudentRecord();
                      }
                    },
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: const Text('Save Record',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text, String? hint, Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.deepPurple.shade50,
        ),
        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.deepPurple.shade50,
    );
  }
}
