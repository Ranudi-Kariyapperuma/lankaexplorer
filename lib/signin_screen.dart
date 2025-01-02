import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Sign-in method with Firebase Authentication
  Future<void> _signIn() async {
  setState(() {
    _isLoading = true; // Show loading spinner
  });

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    print("Signed in as: ${userCredential.user!.email}");
    
    // Navigate to the home screen upon successful sign-in
    Navigator.pushReplacementNamed(context, '/home'); // Example route for home screen
  } catch (e) {
    print("Error: $e");
    // Show error message on failed sign-in
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sign-in failed. Please check your credentials.')),
    );
  } finally {
    setState(() {
      _isLoading = false; // Hide loading spinner
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background Image with train view
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/signin.jpg'), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            // Sign-in form section
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.7, // Adjust as needed
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Subtitle
                  Text(
                    "Welcome Back,\nPlease enter your details.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Email/Phone/Username Field
                  TextField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.black), // Black text color
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // Password Field
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.black), // Black text color
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Sign-In Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _signIn, // Disable button when loading
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Forgot Password
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Navigate to Forgot Password Page
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Divider with "or"
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "or",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Register Now
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don’t have an account? ",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: "Register Now",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to Registration Page
                                Navigator.pushNamed(context, '/signup');
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
