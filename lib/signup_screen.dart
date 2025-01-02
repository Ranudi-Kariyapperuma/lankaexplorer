import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _username = '';
  String _name = '';
  bool _isFirebaseInitialized = false;

  // Firebase initialization
  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _isFirebaseInitialized = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to initialize Firebase: $e")),
      );
    }
  }

  // Sign up method
Future<void> _signUp() async {
  if (_formKey.currentState!.validate()) {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User signed up successfully")),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      if (e.code == 'weak-password') {
        message = 'The password is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for that email';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is invalid';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')), // Add this for debugging
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_isFirebaseInitialized
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Background Image Section
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/signup.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Sign-Up Form Section
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.7,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          // Subtitle
                          Text(
                            "Hello user,\ndo have a great journey.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 20),
                          // Name Field
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) => _name = value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          // Username Field
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Username",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) => _username = value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a username';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          // Email Field
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) => _email = value,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          // Password Field
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) => _password = value,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          // Confirm Password Field
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Confirm password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) => _confirmPassword = value,
                            validator: (value) {
                              if (value != _password) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          // Sign-Up Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _signUp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Already Have an Account
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Login",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Navigate to Login Page
                                        Navigator.pushNamed(context, '/signin');
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
