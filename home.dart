import 'package:aqsa_school/add_record.dart';
import 'package:aqsa_school/arrears_list.dart';
import 'package:aqsa_school/contact.dart';
import 'package:aqsa_school/faq.dart';
import 'package:aqsa_school/login.dart';
import 'package:aqsa_school/privacy_policy.dart';
import 'package:aqsa_school/settings.dart';
import 'package:aqsa_school/view_records.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about.dart' show AboutSchoolScreen;
class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  int _selectedIndex = 1;
  String fullMessage = "Welcome Dear !";
  int currentLength = 0;
  String searchQuery = "";

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTypingAnimation();
  }

  void startTypingAnimation() async {
    while (mounted) {
      for (int i = 0; i <= fullMessage.length; i++) {
        await Future.delayed(const Duration(milliseconds: 250));
        setState(() {
          currentLength = i;
        });
      }
      await Future.delayed(const Duration(seconds: 10));
      setState(() {
        currentLength = 0;
      });
    }
  }

  void _navigateAndCloseDrawer(VoidCallback navigationAction) {
    Navigator.pop(context);
    navigationAction();
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const FixedLoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.deepPurple),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/aqsda.jpeg'),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'AqsA Model School',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Sattoki, Kasur',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.home, 'Home', () => _navigateAndCloseDrawer(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeDashboard())))),
            _buildDrawerItem(Icons.person_add, 'Add Record', () => _navigateAndCloseDrawer(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddStudentScreen())))),
            _buildDrawerItem(Icons.list, 'View Records', () => _navigateAndCloseDrawer(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewRecordsScreen())))),
            _buildDrawerItem(Icons.money_off, 'Arrears List', () => _navigateAndCloseDrawer(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const ArrearsListScreen())))),
            const Divider(),
            _buildDrawerItem(Icons.info, 'About', () => _navigateAndCloseDrawer(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutSchoolScreen())))),
            _buildDrawerItem(Icons.lock, 'Privacy Policy', () => _navigateAndCloseDrawer(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen())))),
            _buildDrawerItem(Icons.settings, 'Settings', () => _navigateAndCloseDrawer(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())))),
            _buildDrawerItem(Icons.contact_mail, 'Contact Us', () => _navigateAndCloseDrawer(() => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactUsScreen())))),
            _buildDrawerItem(Icons.help_outline, 'FAQs', () => _navigateAndCloseDrawer(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const FAQScreen())))),
            const Divider(),
            _buildDrawerItem(Icons.logout, 'Logout', () {
              Navigator.pop(context); // drawer band karne k liye
              _logout();
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'AqsA Model School',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullMessage.substring(0, currentLength),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search student by name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ViewRecordsScreen(searchName: value.trim()),
                    ),
                  );
                  _searchController.clear();
                }
              },
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildDashboardTile(Icons.person_add, 'Add Record', Colors.pink, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddStudentScreen()))),
                  _buildDashboardTile(Icons.list, 'View Records', Colors.green, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewRecordsScreen()))),
                  _buildDashboardTile(Icons.money_off, 'Arrears List', Colors.cyan, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ArrearsListScreen()))),
                  _buildDashboardTile(Icons.settings, 'Settings', Colors.deepPurple, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
                  _buildDashboardTile(Icons.help_outline, 'FAQs', Colors.green, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FAQScreen()))),
                  _buildDashboardTile(Icons.info, 'About', Colors.pink, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutSchoolScreen()))),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
          if (index == 1) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeDashboard()));
          if (index == 2) Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutSchoolScreen()));
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
      ),
    );
  }

  Widget _buildDashboardTile(IconData icon, String label, Color color, VoidCallback onTap) {
    final Color finalColor = color is MaterialColor ? color.shade700 : color;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(2, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: finalColor),
            const SizedBox(height: 10),
            Text(label,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }
}
