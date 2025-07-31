// import statements
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditStudentScreen extends StatefulWidget {
  final String studentId;
  final Map<String, dynamic> studentData;

  const EditStudentScreen({
    super.key,
    required this.studentId,
    required this.studentData,
  });

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController fatherNameController;
  late TextEditingController dobController;
  late TextEditingController contactController;
  late TextEditingController feeController;
  late TextEditingController booksController;
  late TextEditingController stationaryController;
  late TextEditingController paperController;
  late TextEditingController homeTaskController;
  late TextEditingController depositController;

  String selectedClass = '1';
  double arrears = 0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.studentData['name']);
    fatherNameController = TextEditingController(text: widget.studentData['fatherName']);
    dobController = TextEditingController(text: widget.studentData['dob']);
    contactController = TextEditingController(text: widget.studentData['contact']);
    selectedClass = widget.studentData['class'];
    feeController = TextEditingController(text: widget.studentData['fee'].toString());
    booksController = TextEditingController(text: widget.studentData['books'].toString());
    stationaryController = TextEditingController(text: widget.studentData['stationary'].toString());
    paperController = TextEditingController(text: widget.studentData['paper'].toString());
    homeTaskController = TextEditingController(text: widget.studentData['homeTask'].toString());
    depositController = TextEditingController(text: widget.studentData['deposit'].toString());
    _calculateArrears();
  }

  void _calculateArrears() {
    double fee = double.tryParse(feeController.text) ?? 0;
    double books = double.tryParse(booksController.text) ?? 0;
    double stationary = double.tryParse(stationaryController.text) ?? 0;
    double paper = double.tryParse(paperController.text) ?? 0;
    double homeTask = double.tryParse(homeTaskController.text) ?? 0;
    double deposit = double.tryParse(depositController.text) ?? 0;

    setState(() {
      arrears = (fee + books + stationary + paper + homeTask) - deposit;
    });
  }

  Future<void> _updateStudent() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('students').doc(widget.studentId).update({
        'name': nameController.text,
        'fatherName': fatherNameController.text,
        'dob': dobController.text,
        'contact': contactController.text,
        'class': selectedClass,
        'fee': double.tryParse(feeController.text) ?? 0,
        'books': double.tryParse(booksController.text) ?? 0,
        'stationary': double.tryParse(stationaryController.text) ?? 0,
        'paper': double.tryParse(paperController.text) ?? 0,
        'homeTask': double.tryParse(homeTaskController.text) ?? 0,
        'deposit': double.tryParse(depositController.text) ?? 0,
        'arrears': arrears,
      });

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Success", style: TextStyle(color: Colors.green)),
          content: const Text("Student record updated successfully."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Student", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(nameController, 'Student Name'),
                _buildTextField(fatherNameController, 'Father Name'),
                _buildTextField(dobController, 'Date of Birth', hint: 'DD-MM-YYYY'),
                _buildTextField(contactController, 'Contact Number', keyboardType: TextInputType.phone),

                // Updated Class dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField<String>(
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
                    onChanged: (value) {
                      setState(() {
                        selectedClass = value!;
                      });
                    },
                  ),
                ),

                _buildTextField(feeController, 'Monthly Fee', onChanged: (_) => _calculateArrears()),
                _buildTextField(booksController, 'Books Fee', onChanged: (_) => _calculateArrears()),
                _buildTextField(stationaryController, 'Stationary Fee', onChanged: (_) => _calculateArrears()),
                _buildTextField(paperController, 'Paper Money', onChanged: (_) => _calculateArrears()),
                _buildTextField(homeTaskController, 'Home Task Fee', onChanged: (_) => _calculateArrears()),
                _buildTextField(depositController, 'Deposit Amount', onChanged: (_) => _calculateArrears()),
                const SizedBox(height: 10),
                Text('Arrears: Rs. ${arrears.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _updateStudent,
                    icon: const Icon(Icons.update, color: Colors.white),
                    label: const Text('Update Record',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label, {
        TextInputType keyboardType = TextInputType.text,
        String? hint,
        Function(String)? onChanged,
      }) {
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
}
