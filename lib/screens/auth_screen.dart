import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = true;
      });
    } catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: AuthForm(_submitAuthForm, _isLoading)),
    );
  }
}

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);

  final bool isLoading;

  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = false;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/Login_b.png",
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Hello buddy!',
                      style: TextStyle(
                        fontFamily: GoogleFonts.arimaMadurai().fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    ),
                    Text(
                      _isLogin
                          ? 'welcome back, we missed you'
                          : 'Register below with your details!',
                      style: TextStyle(
                        fontFamily: GoogleFonts.arimaMadurai().fontFamily,
                        fontSize: 26,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color.fromARGB(255, 221, 215, 215),
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                            key: ValueKey('email'),
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            enableSuggestions: false,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                            style: TextStyle(
                                fontFamily:
                                    GoogleFonts.arimaMadurai().fontFamily,
                                color: Colors.black87),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                            ),
                            onSaved: (value) {
                              _userEmail = value!;
                            },
                          ),
                        ),
                      ),
                    ),
                    if (!_isLogin)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(255, 221, 215, 215),
                              ),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              key: ValueKey('username'),
                              autocorrect: true,
                              textCapitalization: TextCapitalization.words,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 4) {
                                  return 'Please enter at least 4 characters';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  fontFamily:
                                      GoogleFonts.arimaMadurai().fontFamily,
                                  color: Colors.black87),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Username',
                              ),
                              onSaved: (value) {
                                _userName = value!;
                              },
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color.fromARGB(255, 221, 215, 215),
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                            key: ValueKey('password'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Password must be at least 7 characters long.';
                              }
                              return null;
                            },
                            obscureText: true,
                            style: TextStyle(
                                fontFamily:
                                    GoogleFonts.arimaMadurai().fontFamily,
                                color: Colors.black87),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                            ),
                            onSaved: (value) {
                              _userPassword = value!;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(12)),
                          child: GestureDetector(
                            child: Center(
                              child: Text(
                                _isLogin ? "Login" : "Sign Up",
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.arimaMadurai().fontFamily,
                                    color: Colors.white,
                                    fontSize: 15),
                              ),
                            ),
                            onTap: _trySubmit,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    if (!widget.isLoading)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isLogin
                                ? "Don't have an Account?"
                                : "Already have an Account",
                            style: TextStyle(
                              fontFamily: GoogleFonts.arimaMadurai().fontFamily,
                            ),
                          ),
                          GestureDetector(
                            child: Text(_isLogin ? ' Sign Up' : 'Sign in',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                      GoogleFonts.arimaMadurai().fontFamily,
                                )),
                            onTap: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                          )
                        ],
                      )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
