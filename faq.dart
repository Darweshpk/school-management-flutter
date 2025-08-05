import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqList = [
      {
        'question': 'What is Darwesh School Management System?',
        'answer': 'Darwesh School Management is a comprehensive educational institution focused on providing quality education with modern management systems.'
      },
      {
        'question': 'Which grades are offered at the school?',
        'answer': 'The school offers education from Nursery to Matric level with comprehensive academic programs.'
      },
      {
        'question': 'What is the school\'s approach to education?',
        'answer': 'We emphasize excellence in both academic learning and character development with innovative teaching methods.'
      },
      {
        'question': 'What is the fee submission process?',
        'answer': 'Fees must be submitted at the school office between the 1st and 10th of every month through our management system.'
      },
      {
        'question': 'Is there a late fee fine?',
        'answer': 'Yes, a late fee is applicable if the fee is not submitted within the due date as per school policy.'
      },
      {
        'question': 'Does the school provide computer education?',
        'answer': 'Yes, we have modern computer labs and offer comprehensive IT training as part of our curriculum.'
      },
      {
        'question': 'Are online classes available?',
        'answer': 'Yes, we provide hybrid learning options with both in-person and online class facilities.'
      },
      {
        'question': 'How does the school recognize outstanding students?',
        'answer': 'Students with exceptional performance receive certificates, awards, and recognition through our merit system.'
      },
      {
        'question': 'Are there parent-teacher meetings?',
        'answer': 'Yes, regular parent-teacher meetings are scheduled for progress discussions and academic planning.'
      },
      {
        'question': 'What extracurricular activities are available?',
        'answer': 'We offer sports, competitions, cultural events, and various co-curricular activities throughout the year.'
      },
      {
        'question': 'What is the school\'s vision?',
        'answer': 'To develop students into responsible, confident, and productive global citizens with strong academic foundations.'
      },
      {
        'question': 'Are the teachers qualified?',
        'answer': 'All our teachers are highly qualified, professionally trained, and experienced in their respective subjects.'
      },
      {
        'question': 'How is homework monitored?',
        'answer': 'Daily homework is systematically checked and monitored by teachers with regular feedback to students.'
      },
      {
        'question': 'Is career guidance available?',
        'answer': 'Yes, we provide comprehensive counseling sessions for academic planning and career guidance.'
      },
      {
        'question': 'Does the school have a library?',
        'answer': 'Yes, our library is well-equipped with academic resources, reference books, and digital learning materials.'
      },
      {
        'question': 'How is student attendance tracked?',
        'answer': 'Daily attendance is digitally recorded and parents are promptly informed of any absences.'
      },
      {
        'question': 'Is online fee payment available?',
        'answer': 'Yes, our management system supports online fee payment options for parent convenience.'
      },
      {
        'question': 'Are there special support programs?',
        'answer': 'Yes, we provide additional academic support and coaching for students who need extra assistance.'
      },
      {
        'question': 'Does the school conduct summer programs?',
        'answer': 'Yes, we offer summer camps and enrichment programs during vacations with various educational activities.'
      },
      {
        'question': 'Is transportation available?',
        'answer': 'School transportation services are available with safe and reliable routes covering major areas.'
      },
      {
        'question': 'Is the school officially registered?',
        'answer': 'Yes, Darwesh School Management is officially registered and recognized by educational authorities.'
      },
      {
        'question': 'Is there an admission test?',
        'answer': 'Yes, new students are required to pass an age-appropriate assessment for appropriate class placement.'
      },
      {
        'question': 'Are fee receipts provided?',
        'answer': 'Yes, official digital and physical fee receipts are issued for every payment transaction.'
      },
      {
        'question': 'Can parents access student records online?',
        'answer': 'Yes, parents can access student information through our secure online parent portal.'
      },
      {
        'question': 'What are the benefits of the mobile app?',
        'answer': 'The app enables easy access to student records, fee management, attendance tracking, and school communications.'
      },
      {
        'question': 'Is the app secure?',
        'answer': 'Yes, the app uses advanced security measures with authorized access controls for data protection.'
      },
      {
        'question': 'Can students edit their information?',
        'answer': 'No, only authorized school administrators have edit access to maintain data integrity.'
      },
      {
        'question': 'Are academic competitions held?',
        'answer': 'Yes, regular academic contests and competitions are organized to encourage student participation and excellence.'
      },
      {
        'question': 'How is student feedback collected?',
        'answer': 'We regularly collect student feedback through assessments, surveys, and interactive sessions.'
      },
      {
        'question': 'Are digital progress reports available?',
        'answer': 'Yes, comprehensive digital progress reports are generated and shared with parents regularly.'
      },
      {
        'question': 'Are educational tours organized?',
        'answer': 'Yes, educational field trips and study tours are organized with proper supervision and parental consent.'
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs - Darwesh School',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          final faq = faqList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              title: Text(
                faq['question']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(faq['answer']!),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}