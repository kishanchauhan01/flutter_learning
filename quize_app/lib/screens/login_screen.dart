import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quize_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obsecureText = true;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; //loader flag

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Trigger the Google authentication flow.
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If the user cancels the sign-in, googleUser will be null.
      if (googleUser == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // 2. Obtain the auth details from the request.
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3. Create a new credential for Firebase.
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Sign in to Firebase with the credential.
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // 5. Check if the user is new. If so, create a Firestore document.
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .set({
                'name': firebaseUser.displayName,
                'email': firebaseUser.email,
                'createdAt': Timestamp.now(),
                'profilePhotoUrl': firebaseUser.photoURL,
              });
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration successful!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
        print(
          "Google Sign-In successful for user: ${firebaseUser.displayName}",
        );
      }
    } catch (e) {
      print(e.toString());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google Sign-In failed. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _signUpWithEmailAndPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      print("Successfully created user: ${userCredential.user!.uid}");

      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(firebaseUser.uid)
            .set({
              "name": _emailController.text.trim().split("@")[0],
              "email": firebaseUser.email,
              "createdAt": Timestamp.now(),
            });
      }

      print("stored successful");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase auth errors
      String message = e.message ?? 'An error occurred.';
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildAppBar("Quiz App"),
                      const SizedBox(height: 48.0),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildEmailinput(),

                            const SizedBox(height: 16.0),

                            _buildPasswordInput(),

                            const SizedBox(height: 24.0),

                            _buildLoginBtn(_formKey),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      _buildDivder(),
                      const SizedBox(height: 16.0),
                      _buildGoogleSignInButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),

          if (_isLoading)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(
                    child: SpinKitPulse(color: Colors.white, size: 50.0),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Text _buildAppBar(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }

  TextFormField _buildEmailinput() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'your@example.com',
        prefixIcon: Icon(Icons.email_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your email";
        }

        //simple email regex
        const String pattern = r'^[^@]+@[^@]+\.[^@]+';
        RegExp regex = RegExp(pattern);
        if (!regex.hasMatch(value)) {
          return "Enter a valid email address";
        }

        return null;
      },
    );
  }

  TextFormField _buildPasswordInput() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obsecureText, // hides password
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: Icon(Icons.lock_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obsecureText = !_obsecureText;
            });
          },
          icon: Icon(_obsecureText ? Icons.visibility_off : Icons.visibility),
        ),
      ),

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );
  }

  ElevatedButton _buildLoginBtn(GlobalKey<FormState> formKey) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        padding: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: () {
        // _signUpWithEmailAndPassword();
        Get.off(HomeScreen());
      },
      child: Text("Login", style: TextStyle(fontSize: 16.0)),
    );
  }

  Row _buildDivder() {
    return Row(
      children: <Widget>[
        Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("OR", style: TextStyle(color: Colors.grey)),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildGoogleSignInButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        _signInWithGoogle();
      },
      icon: Image.asset("assets/images/google_login.png"),
    );
  }
}
