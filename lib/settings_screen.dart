import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lankaexplorer/welcome_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

import 'favorites_list_screen.dart';
import 'home_screen.dart';
import 'itinerary_planner_screen.dart';
import 'review_and_rating_screen.dart';



class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {


  
  String savedFullName = '';
  String savedEmail = '';
  bool notificationsEnabled = false;
  bool dataSharingEnabled = false;
  File? savedImageFile;
  
   @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  // Load profile data 
  void _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedFullName = prefs.getString('fullName') ?? '';
      savedEmail = prefs.getString('email') ?? '';
      String? imagePath = prefs.getString('imagePath');
      if (imagePath != null) {
        savedImageFile = File(imagePath);
      }
      dataSharingEnabled = prefs.getBool('dataSharingEnabled') ?? false; 
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? false; 
    });
  }

  // Save profile data 
  void _saveProfile(String fullName, String email, File? imageFile, bool dataSharing, bool notifications) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('fullName', fullName);
    prefs.setString('email', email);
    if (imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = basename(imageFile.path);
      final newPath = '${directory.path}/$fileName';
      imageFile.copySync(newPath);
      prefs.setString('imagePath', newPath);
    }
    prefs.setBool('dataSharingEnabled', dataSharing);  
    prefs.setBool('notificationsEnabled', notifications);
  
  }

  void _showBottomSheet(BuildContext context, Widget content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          color: const Color.fromARGB(255, 48, 47, 47),
          child: DraggableScrollableSheet(
            expand: false,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: content,
              );
              
            },
          ),
        );
      },
    );
  }

 void _logOut(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); 

  
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
}


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Row(
          children: [
            Icon(Icons.settings, size: 40, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Settings',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.white),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          if (savedFullName.isNotEmpty && savedEmail.isNotEmpty) ...[
            ListTile(
              leading: CircleAvatar(
                radius: 40,
                backgroundImage: savedImageFile == null
                    ? const AssetImage('images/Setting_Profile.jpg') as ImageProvider
                    : FileImage(savedImageFile!),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  savedFullName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  savedEmail,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            const Divider(color: Colors.grey),
          ],
          _buildSettingsContainer(
            icon: Icons.person_outline,
            iconColor: Colors.white,
            title: 'Profile',
            subtitle: 'Manage your account',
            backgroundColor: Colors.blue,
            onTap: () => _showBottomSheet(
              context,
              ProfileSettings(
                initialFullName: savedFullName,
                initialEmail: savedEmail,
                initialImageFile: savedImageFile,
                onSave: (fullName, email, imageFile) {
                  setState(() {
                    savedFullName = fullName;
                    savedEmail = email;
                    savedImageFile = imageFile;
                  });
                   _saveProfile(fullName, email, imageFile, dataSharingEnabled, notificationsEnabled);
                   // Show notification 
                  if (notificationsEnabled) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile updated'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.teal,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          _buildSettingsContainer(
            icon: Icons.notifications_outlined,
            iconColor: Colors.white,
            title: 'Notifications',
            subtitle: 'Customize notification preferences',
            backgroundColor: Colors.green,
            onTap: () => _showBottomSheet(
              context,
              NotificationSettings(
                notificationsEnabled: notificationsEnabled,
                onToggle: (bool value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                  _saveProfile(savedFullName, savedEmail, savedImageFile, dataSharingEnabled, notificationsEnabled);
                },
              ),
            ),
          ),
          _buildSettingsContainer(
            icon: Icons.lock_outline,
            iconColor: Colors.white,
            title: 'Privacy',
            subtitle: 'Manage your privacy settings',
            backgroundColor: Colors.purple,
            onTap: () => _showBottomSheet(
              context,
              PrivacySettings(
                dataSharingEnabled: dataSharingEnabled,
                onToggle: (bool value) {
                  setState(() {
                    dataSharingEnabled = value;
                  });
                  _saveProfile(savedFullName, savedEmail, savedImageFile, dataSharingEnabled, notificationsEnabled);

                   // Show notification 
                  if (notificationsEnabled) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(dataSharingEnabled ? 'Privacy button is turned on' : 'Privacy button is turned off'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.teal,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          _buildSettingsContainer(
            icon: Icons.help_outline,
            iconColor: Colors.white,
            title: 'Help & Support',
            subtitle: 'Get help and support',
            backgroundColor: Colors.orange,
            onTap: () => _showBottomSheet(
              context,
              const HelpSupportSettings(),
            ),
          ),
          _buildSettingsContainer(
            icon: Icons.info_outline,
            iconColor: Colors.white,
            title: 'About',
            subtitle: 'Learn more about the app',
            backgroundColor: Colors.red,
            onTap: () => _showBottomSheet(
              context,
              const AboutPage(),
            ),
          ),


          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Log Out',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () => _logOut(context),  
          ),
        ],
      ),
    );
  }
}

  

  
  Widget _buildSettingsContainer({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white70),
        ),
        onTap: onTap,
      ),
    );
  }


class ProfileSettings extends StatefulWidget {
  final String initialFullName;
  final String initialEmail;
  final File? initialImageFile;
  final Function(String fullName, String email, File? imageFile) onSave;

  const ProfileSettings({
    required this.initialFullName,
    required this.initialEmail,
    required this.initialImageFile,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _imageFile = widget.initialImageFile;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController fullNameController =
        TextEditingController(text: widget.initialFullName);
    final TextEditingController emailController =
        TextEditingController(text: widget.initialEmail);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageProfile(context),
          const SizedBox(height: 20),
          const Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Color.fromARGB(255, 63, 228, 217),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: fullNameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal, width: 2),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal, width: 2),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              widget.onSave(fullNameController.text, emailController.text, _imageFile);
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.teal, width: 2),
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              'Save',
              style: TextStyle(color: Color.fromARGB(255, 239, 241, 241)),
            ),
          ),
        ],
      ),
    );
  }


  Widget imageProfile(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            backgroundImage: _imageFile == null
                ? const AssetImage('images/Setting_Profile.jpg') as ImageProvider
                : FileImage(_imageFile!),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => bottomSheet(context),
                );
              },
              child: const Icon(
                Icons.camera_alt,
                color: Colors.teal,
                size: 28.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose profile photo",
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                  Navigator.pop(context); 
                },
                label: const Text("Camera"),
              ),
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                  Navigator.pop(context); 
                },
                label: const Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }
}


// Notification

class NotificationSettings extends StatefulWidget {
  final bool notificationsEnabled;
  final Function(bool) onToggle;

  const NotificationSettings({
    required this.notificationsEnabled,
    required this.onToggle,
    Key? key,
  }) : super(key: key);

  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  late bool _notificationsEnabled;

  @override
  void initState() {
    super.initState();
    _notificationsEnabled = widget.notificationsEnabled; 
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notification Settings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Color.fromARGB(255, 63, 228, 217)),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Enable Notifications',
                style: TextStyle(color: Colors.white),
              ),
              Switch(
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value; 
                  });
                  widget.onToggle(value); 
                },
                activeColor: Colors.teal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}




// Privacy
class PrivacySettings extends StatefulWidget {
  final bool dataSharingEnabled;
  final Function(bool) onToggle;

  const PrivacySettings({
    required this.dataSharingEnabled,
    required this.onToggle,
    Key? key,
  }) : super(key: key);

  @override
  _PrivacySettingsState createState() => _PrivacySettingsState();
}

class _PrivacySettingsState extends State<PrivacySettings> {
  late bool _dataSharingEnabled;

  @override
  void initState() {
    super.initState();
    _dataSharingEnabled = widget.dataSharingEnabled; 
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Privacy Settings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Color.fromARGB(255, 63, 228, 217)),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Data Sharing',
                style: TextStyle(color: Colors.white),
              ),
              Switch(
                value: _dataSharingEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _dataSharingEnabled = value; 
                  });
                  widget.onToggle(value); 
                },
                activeColor: Colors.teal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}









// Help & Support Section
class HelpSupportSettings extends StatelessWidget {
  const HelpSupportSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [
            const Text(
              'Help & Support',  
              style: TextStyle(
                fontSize: 20,  
                fontWeight: FontWeight.bold,  
                fontStyle: FontStyle.italic, 
                color: Color.fromARGB(255, 63, 228, 217), 
              ),
            ),
            const SizedBox(height: 20),  
            ListTile(
              leading: const Icon(Icons.email, color: Colors.white),
              title: const Text(
                'Contact Us',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                
                showModalBottomSheet(
                  backgroundColor: Colors.black,
                  context: context,
                  builder: (context) => const ContactUsScreen(),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bug_report, color: Colors.white),
              title: const Text(
                'Report a Problem',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
             
                showModalBottomSheet(
                  backgroundColor: Colors.black,
                  context: context,
                  builder: (context) => const ReportProblemScreen(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}




// Contact Us Bottom Sheet
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 3, 73, 94),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Contact us at: support200@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.teal, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Report a Problem Bottom Sheet
class ReportProblemScreen extends StatelessWidget {
  const ReportProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 3, 73, 94),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'To report a problem, email us at: bugs123@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.teal, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// About Page
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'About this App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Color.fromARGB(255, 63, 228, 217),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'This app allows you to manage your profile, notifications,Help & Support, '
            'and more. Stay connected and customize your experience.',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 10),  
          const Text(
            'Current version of the app - version 1.0.0',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.teal, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],

       
      
      ),
      
    );
    
  }
}

