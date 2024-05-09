import 'package:barcodee/model/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginModule extends StatefulWidget {
  const LoginModule({Key? key}) : super(key: key);

  @override
  _LoginModuleState createState() => _LoginModuleState();
}

class _LoginModuleState extends State<LoginModule> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          _signInWithEmailAndPassword();
                        }
                      },
                      child: Text('Login'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      setState(() {
        _isLoading = false;
      });
      // Navigate to QR Scan page after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('No user found for that email.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Wrong password provided for that user.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SizedBox(height: 32.0),
//           Text(
//             'Login to start',
//             style: GoogleFonts.poppins(
//               fontSize: 24.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 32.0),
//           TextField(
//             controller: _emailController,
//             decoration: InputDecoration(
//               labelText: 'Email',
//               labelStyle: GoogleFonts.poppins(),
//               filled: true,
//               fillColor: const Color(0xFFF5F5F5),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//             style: GoogleFonts.poppins(),
//           ),
//           const SizedBox(height: 16.0),
//           TextField(
//             controller: _passwordController,
//             obscureText: true,
//             decoration: InputDecoration(
//               labelText: 'Password',
//               labelStyle: GoogleFonts.poppins(),
//               filled: true,
//               fillColor: const Color(0xFFF5F5F5),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//             style: GoogleFonts.poppins(),
//           ),
//           const SizedBox(height: 32.0),
//           ElevatedButton(
//             onPressed: () {
//               // TODO: Implement login functionality
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color.fromARGB(255, 49, 114, 178),
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//             ),
//             child: Text(
//               'Login',
//               style: GoogleFonts.poppins(
//                 fontSize: 18.0,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           const SizedBox(height: 16.0),
//           // TextButton(
//           //   onPressed: () {
//           //     // TODO: Implement forgot password functionality
//           //   },
//           //   child: Text(
//           //     'Forgot Password?',
//           //     style: GoogleFonts.poppins(
//           //       color: const Color.fromARGB(255, 0, 0, 0),
//           //       decoration: TextDecoration.underline,
//           //     ),
//           //   ),
//           // ),
          
//           const SizedBox(height: 16.0),
//           TextButton(
//             onPressed: () {
//               // TODO: Navigate to sign up page
//             },
//             child: Text(
//               'Don\'t have an account? Sign Up',
//               style: GoogleFonts.poppins(
//                 color: const Color.fromARGB(255, 0, 0, 0),
//                 decoration: TextDecoration.underline,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }
