import 'package:flutter/material.dart';

class AboutSchoolScreen extends StatelessWidget {
  const AboutSchoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About AqsA School', style: TextStyle(color: Colors.white),),
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
                  'AqsA Model School Sattoki Kasur',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  'An Institute With All Educational Solutions',
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
                'AqsA Model School ....., located in the heart of ..... district, is a beacon of knowledge and excellence. Founded with the vision of providing quality education at an affordable cost, it has grown to become a trusted name among parents and students alike. From foundational early education to higher-level academic preparation, our institute delivers a comprehensive and balanced curriculum tailored to 21st-century needs.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'Our passionate and qualified teaching staff ensure that every student receives individual attention, emotional support, and academic growth. Our classrooms are equipped with modern facilities, and we constantly innovate using digital tools and personalized assessments. The goal is not just learning — but meaningful, value-driven learning.',
              ),

              SizedBox(height: 20),
              Text(
                '📌 Core Values:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text('- Quality education for every child'),
              Text('- Respect, integrity, and discipline'),
              Text('- A blend of modern and moral learning'),
              Text('- Active parent-teacher collaboration'),

              SizedBox(height: 20),
              Text(
                '📬 Contact Information:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text('📧 Email: ..........@gmail.com'),
              Text('📞 Phone: ............'),
              Text('📍 Location: ...............'),

              SizedBox(height: 20),
              Text(
                '🌟 Vision:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'To nurture young minds into responsible, confident, and productive citizens of tomorrow by instilling strong values, academic excellence, and creative problem-solving.'
              ),

              SizedBox(height: 20),
              Text(
                '📈 Future Goals:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  '- Launch digital classrooms and e-learning platforms\n- Expand subject choices in higher classes\n- Organize national-level competitions and seminars\n- Partner with tech & educational institutes for innovation'
              ),

              SizedBox(height: 30),
              Center(
                child: Text(
                  'Proud to serve the future of our nation — One Child at a Time.',
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
