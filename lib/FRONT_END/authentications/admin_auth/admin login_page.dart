// import 'package:bethel_app_final/FRONT_END/authentications/auth_classes/my_button.dart';
// import 'package:bethel_app_final/FRONT_END/authentications/auth_classes/my_textfield.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class AdminLogin extends StatefulWidget {
//   final void Function()? onTap;
//
//   const AdminLogin({
//     super.key,
//     this.onTap,
//   });
//
//   @override
//   State<AdminLogin> createState() => _AdminLoginState();
// }
//
// class _AdminLoginState extends State<AdminLogin> {
//   // text editing controllers
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   bool _obscurePassword = true;
//
//   // sign user in method
//   void signUserIn() async {
//     try {
//       String email = emailController.text.trim();
//       String password = passwordController.text.trim();
//
//       if (email.isEmpty && password.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please enter both email and password.'),
//             duration: Duration(seconds: 3),
//           ),
//         );
//         return;
//       }
//       if (email.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please enter your email.'),
//             duration: Duration(seconds: 3),
//           ),
//         );
//         return;
//       }
//       if (password.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please enter your password.'),
//             duration: Duration(seconds: 3),
//           ),
//         );
//         return;
//       }
//
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on FirebaseAuthException catch (e) {
//       print('FirebaseAuthException occurred: ${e.message}');
//       if (e.code == 'wrong-password') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content:
//                 Text('Incorrect password. Please double-check and try again.'),
//             duration: Duration(seconds: 3),
//           ),
//         );
//       } else if (e.code == 'user-not-found') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Email address not found. Please create an account.'),
//             duration: Duration(seconds: 3),
//           ),
//         );
//       }
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         title: const Text(''),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // logo
//                 Image.asset(
//                   'assets/images/churchmain.png',
//                   width: 300,
//                   height: 300,
//                 ),
//                 const SizedBox(height: 40),
//                 const Padding(
//                   padding: EdgeInsets.only(
//                       right: 200), // Adjust the left padding as needed
//                   child: Text(
//                     'Admin Login',
//                     style: TextStyle(
//                       color: Colors.black87,
//                       fontSize: 26,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // username textfield
//                 MyTextField(
//                   controller: emailController,
//                   hintText: 'Email',
//                   obscureText: false,
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // password textfield
//                 MyTextField(
//                   controller: passwordController,
//                   hintText: 'Password',
//                   obscureText: _obscurePassword,
//                   suffixIcon: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _obscurePassword = !_obscurePassword;
//                       });
//                     },
//                     child: Icon(
//                       _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//
//
//                 const SizedBox(height: 20),
//
//                 // sign in button
//                 MyButton(
//                   onTap: signUserIn,
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // not a member? register now
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     Text(
//                 //       "Don't have an account?",
//                 //       style: TextStyle(color: Colors.grey[700]),
//                 //     ),
//                 //     const SizedBox(width: 4),
//                 //     GestureDetector(
//                 //       onTap: widget.onTap,
//                 //       child: const Text(
//                 //         'Register now',
//                 //         style: TextStyle(
//                 //           color: appGreen,
//                 //           fontWeight: FontWeight.bold,
//                 //         ),
//                 //       ),
//                 //     )
//                 //   ],
//                 // )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
