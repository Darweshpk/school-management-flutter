import 'package:aqsa_school/about.dart';
import 'package:aqsa_school/faq.dart';
import 'package:aqsa_school/privacy_policy.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  String selectedLanguage = 'English';

  final List<String> languages = [
    'Arabic', 'Bengali', 'Chinese', 'Czech', 'Danish', 'Dutch', 'English',
    'Finnish', 'French', 'German', 'Greek', 'Gujarati', 'Hebrew', 'Hindi',
    'Hungarian', 'Indonesian', 'Italian', 'Japanese', 'Korean', 'Malay',
    'Marathi', 'Norwegian', 'Pashto', 'Persian', 'Polish', 'Portuguese',
    'Punjabi', 'Romanian', 'Russian', 'Saraiki', 'Sindhi', 'Slovak',
    'Spanish', 'Swedish', 'Tamil', 'Telugu', 'Thai', 'Turkish', 'Urdu',
    'Vietnamese'
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'App Preferences',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            secondary: const Icon(Icons.brightness_6, color: Colors.deepPurple),
            title: const Text('Dark Mode'),
            subtitle: const Text('Toggle between light and dark theme'),
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
              // TODO: Apply ThemeMode based on 'isDarkMode'
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language, color: Colors.deepPurple),
            title: const Text('Language'),
            subtitle: Text('Current: $selectedLanguage'),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              items: languages.map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.deepPurple),
            title: const Text('Help & FAQs'),
            subtitle: const Text('Find answers to common questions'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FAQScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.deepPurple),
            title: const Text('About School'),
            subtitle: const Text('Learn about AqsA Model School'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutSchoolScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined, color: Colors.deepPurple),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
              );     },
          ),
        ],
      ),
    );
  }
}
