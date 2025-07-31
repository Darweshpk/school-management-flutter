import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqList = [
      {
        'question': 'Where is AqsA Model School located?',
        'answer': 'AqsA Model School is located in ......r, Pakistan.'
      },
      {
        'question': 'Which grades are offered at the school?',
        'answer': 'The school offers education from Nursery to Matric level.'
      },
      {
        'question': 'Is moral education also part of the curriculum?',
        'answer': 'Yes, the school emphasizes both modern education and moral upbringing.'
      },
      {
        'question': 'What is the fee submission process?',
        'answer': 'Fees must be submitted at the school office between the 1st and 10th of every month.'
      },
      {
        'question': 'Is there a late fee fine?',
        'answer': 'Yes, a late fee is applicable if the fee is not submitted within the due date.'
      },
      {
        'question': 'Does the school provide computer education?',
        'answer': 'Yes, we have a fully equipped computer lab and offer basic to advanced IT training.'
      },
      {
        'question': 'Are online classes available?',
        'answer': 'We are planning to introduce online learning platforms in the near future.'
      },
      {
        'question': 'Does the school reward top-performing students?',
        'answer': 'Yes, students with outstanding performance receive certificates and awards annually.'
      },
      {
        'question': 'Are there parent-teacher meetings?',
        'answer': 'Yes, regular parent-teacher meetings are held for progress discussions.'
      },
      {
        'question': 'Are there extracurricular activities?',
        'answer': 'Yes, sports day, speech competitions, and other events are held yearly.'
      },
      {
        'question': 'What is the vision of the school?',
        'answer': 'To develop students into responsible, confident, and productive citizens.'
      },
      {
        'question': 'Are the teachers qualified?',
        'answer': 'All our teachers are well-trained and professionally experienced.'
      },
      {
        'question': 'Is homework monitored?',
        'answer': 'Yes, daily homework is checked regularly by teachers.'
      },
      {
        'question': 'Is there career guidance available?',
        'answer': 'Yes, we provide counseling sessions for academic and career guidance.'
      },
      {
        'question': 'Is there a library at the school?',
        'answer': 'Yes, our library is equipped with academic and non-academic books.'
      },
      {
        'question': 'Is student attendance recorded?',
        'answer': 'Yes, daily attendance is recorded and parents are informed of absences.'
      },
      {
        'question': 'Is fee payment available online?',
        'answer': 'This feature is under development and will be available soon.'
      },
      {
        'question': 'Are there special classes for weak students?',
        'answer': 'Yes, extra coaching is provided for students who need academic support.'
      },
      {
        'question': 'Does the school conduct summer camps?',
        'answer': 'Yes, summer camps are held during vacations with various activities.'
      },
      {
        'question': 'Is school transport available?',
        'answer': 'Currently not available, but it is under consideration.'
      },
      {
        'question': 'Is the school registered?',
        'answer': 'Yes, the school is officially registered and recognized by authorities.'
      },
      {
        'question': 'Is there an entrance test for new admissions?',
        'answer': 'Yes, new students are required to pass a basic entrance test.'
      },
      {
        'question': 'Are fee receipts provided?',
        'answer': 'Yes, official fee receipts are issued upon every payment.'
      },
      {
        'question': 'Can parents view student records online?',
        'answer': 'This feature is in progress and will be integrated in the future.'
      },
      {
        'question': 'What is the benefit of this mobile app?',
        'answer': 'The app helps with data entry, fee checking, and maintaining digital student records.'
      },
      {
        'question': 'Does the app have admin-only access?',
        'answer': 'Yes, only authorized admins with credentials can log in.'
      },
      {
        'question': 'Can students edit their information through the app?',
        'answer': 'No, only admins have edit access to student records.'
      },
      {
        'question': 'Does the school host academic competitions?',
        'answer': 'Yes, regular academic contests are held to boost student confidence.'
      },
      {
        'question': 'Is student feedback taken regularly?',
        'answer': 'Yes, we take feedback through periodic assessments and discussions.'
      },
      {
        'question': 'Are student progress reports available digitally?',
        'answer': 'Currently handled manually, digital reports are in development.'
      },
      {
        'question': 'Are study tours or field trips organized?',
        'answer': 'Yes, with parental consent and supervision, trips are organized annually.'
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs - AqsA School',style: TextStyle(color: Colors.white),),
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
