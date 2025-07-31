import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'AqsA Model School Sattoki Kasur values the privacy and protection of our students, parents, and faculty. This application is designed to manage and monitor essential school operations while respecting the confidentiality and integrity of all data stored within.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 12),
              Text(
                '1. Data Collection:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'We collect necessary data such as student name, guardian information, class, contact number, and fee-related entries solely for academic and financial recordkeeping. No personal data is sold, shared, or disclosed to third parties.'
              ),
              SizedBox(height: 12),
              Text(
                '2. Data Usage:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'All collected information is used strictly within the domain of AqsA Model School to ensure smooth academic, fee management, and communication processes. The app helps in maintaining monthly fees, book details, arrears, and student progress.'
              ),
              SizedBox(height: 12),
              Text(
                '3. Data Security:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'We store all data in a secure cloud database (Firebase) protected by authentication and secure access policies. Only the assigned admin is granted login access. No student or unauthorized person can log in or access school records.'
              ),
              SizedBox(height: 12),
              Text(
                '4. Third-Party Integrations:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'This app does not use third-party advertisements or services that may access your personal information.'
              ),
              SizedBox(height: 12),
              Text(
                '5. Responsibility:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'While utmost care is taken to maintain privacy, AqsA Model School holds the right to update, modify or revise this policy at any time to meet academic or legal requirements.'
              ),
              SizedBox(height: 12),
              Text(
                '6. Consent:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'By using this application, you agree to the terms and conditions of this privacy policy. Continued usage of the app indicates your acceptance of how we manage and use data.'
              ),
              SizedBox(height: 20),
              Text(
                'If you have any concerns regarding our policy, feel free to contact us at AqsA Model School Sattoki, Kasur.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
