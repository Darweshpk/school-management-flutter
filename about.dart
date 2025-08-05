import 'package:flutter/material.dart';

class AboutSchoolScreen extends StatelessWidget {
  const AboutSchoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Darwesh School Management', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Center(
                child: Text(
                  'Darwesh School Management System',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  'Excellence in Education & Management',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(height: 30, thickness: 1.5),

              Text(
                '🏫 About the Institution',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Darwesh School Management System is designed to provide comprehensive educational solutions with modern management tools. Our institution focuses on delivering quality education while maintaining efficient administrative processes. We combine traditional educational values with contemporary management techniques to create an environment where students can thrive academically and personally.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'Our dedicated team of educators and administrators work tirelessly to ensure that every student receives personalized attention and support. With state-of-the-art facilities and innovative teaching methodologies, we prepare students for the challenges of the modern world while instilling strong moral values and character development.',
              ),

              SizedBox(height: 20),
              Text(
                '📌 Core Values:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text('- Excellence in education and management'),
              Text('- Student-centered approach to learning'),
              Text('- Innovation in teaching and administration'),
              Text('- Strong community partnerships'),
              Text('- Continuous improvement and development'),

              SizedBox(height: 20),
              Text(
                '📬 Contact Information:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text('📧 Email: info@darweshschool.edu'),
              Text('📞 Phone: +92-XXX-XXXXXXX'),
              Text('📍 Location: Educational District, Pakistan'),

              SizedBox(height: 20),
              Text(
                '🌟 Vision:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'To be a leading educational institution that combines academic excellence with innovative management practices, preparing students to become responsible global citizens and future leaders.'
              ),

              SizedBox(height: 20),
              Text(
                '📈 Future Goals:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  '- Implement advanced digital learning platforms\n- Expand STEM education programs\n- Strengthen international educational partnerships\n- Develop innovative assessment and management systems\n- Foster research and development initiatives'
              ),

              SizedBox(height: 30),
              Center(
                child: Text(
                  'Committed to Excellence in Education and Management',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}