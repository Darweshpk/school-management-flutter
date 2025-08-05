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
                'Darwesh School Management System values the privacy and protection of our students, parents, and faculty. This application is designed to manage and monitor essential school operations while respecting the confidentiality and integrity of all data stored within our secure systems.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 12),
              Text(
                '1. Data Collection:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'We collect necessary data such as student information, guardian details, academic records, contact information, and fee-related entries solely for educational and administrative purposes. No personal data is sold, shared, or disclosed to unauthorized third parties.'
              ),
              SizedBox(height: 12),
              Text(
                '2. Data Usage:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'All collected information is used strictly within the domain of Darwesh School Management to ensure smooth academic operations, fee management, attendance tracking, and communication processes. The system helps in maintaining comprehensive student records, academic progress, and administrative efficiency.'
              ),
              SizedBox(height: 12),
              Text(
                '3. Data Security:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'We store all data in secure cloud databases protected by advanced authentication and encryption protocols. Only authorized school administrators and designated staff have access to student records. Multi-layer security measures ensure data protection and system integrity.'
              ),
              SizedBox(height: 12),
              Text(
                '4. Third-Party Integrations:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'Our application uses trusted third-party services only for essential functions such as secure data storage and system analytics. We do not use third-party advertisements or services that may compromise your personal information.'
              ),
              SizedBox(height: 12),
              Text(
                '5. Access Control:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'Access to the management system is strictly controlled through secure authentication. Only authorized personnel with proper credentials can access student records and administrative functions. Regular access audits ensure system security.'
              ),
              SizedBox(height: 12),
              Text(
                '6. Data Rights:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'Parents and students have the right to request information about their stored data and can request corrections to inaccurate information through proper channels. We are committed to maintaining accurate and up-to-date records.'
              ),
              SizedBox(height: 12),
              Text(
                '7. Policy Updates:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'Darwesh School Management reserves the right to update, modify, or revise this policy as needed to meet educational, technological, or legal requirements. Users will be notified of significant policy changes.'
              ),
              SizedBox(height: 12),
              Text(
                '8. Consent:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'By using this application, you agree to the terms and conditions of this privacy policy. Continued usage indicates your acceptance of how we collect, manage, and protect your data.'
              ),
              SizedBox(height: 20),
              Text(
                'For any concerns regarding our privacy policy, please contact us at Darwesh School Management System. We are committed to addressing your privacy concerns promptly and transparently.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}