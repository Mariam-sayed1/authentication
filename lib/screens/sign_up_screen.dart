import 'package:auth_form/widgets/text_field.dart';
import 'package:flutter/material.dart';
import '../responsive/uiComponanets/infowidget.dart';
import '../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _authService.signUp(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        
        Navigator.pushReplacementNamed(context, "Home_screen");
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Infowidget(builder: (context,deviceInfo){
      return  Scaffold(
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal:  deviceInfo.screenWidth * 0.01),
                  alignment: Alignment.centerRight,
                  width: double.infinity,
                  height: deviceInfo.screenHeight * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "sign_in");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: deviceInfo.screenWidth * 0.3,
                      height: deviceInfo.screenHeight * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                      ),
                      child: Text(
                        "sign in",
                        style: TextStyle(color: Colors.blueAccent,fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: deviceInfo.screenWidth * 0.04,top:deviceInfo.screenWidth * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: deviceInfo.screenHeight * 0.06),
                      Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white, fontSize:  deviceInfo.screenWidth * 0.1),
                      ),
                      SizedBox(height: deviceInfo.screenHeight * 0.02),

                      Text(
                        "Welcome Back To sign wave",
                        style: TextStyle(color: Colors.white, fontSize:  deviceInfo.screenWidth * 0.06),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: deviceInfo.screenHeight * 0.02),
            Form(
              key:  _formKey,
              child: Padding(
                padding:  EdgeInsets.all(deviceInfo.screenWidth * 0.08),
                child: Column(
                  children: [
                    TexttField(
                      controller: fullNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a Full Name";
                        }
                        return null;
                      },
                      hintText: "Full Name",
                      keyboardType: TextInputType.text,
                      prefixIcon: Icon(Icons.person),
                    ),
                    SizedBox(height: deviceInfo.screenHeight * 0.02),
                    TexttField(
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a Username";
                        }
                        return null;
                      },
                      hintText: "Username",
                      keyboardType: TextInputType.text,
                      prefixIcon: Icon(Icons.person_pin),
                    ),
                    SizedBox(height: deviceInfo.screenHeight * 0.02),
                    TexttField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter an email";
                        } else if (!RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$",
                        ).hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    SizedBox(height: deviceInfo.screenHeight * 0.02),
                    TexttField(
                      controller: phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a Phone Number";
                        }
                        return null;
                      },
                      hintText: "Phone Number",
                      keyboardType: TextInputType.number,
                      prefixIcon: Icon(Icons.phone),
                    ),
                    SizedBox(height: deviceInfo.screenHeight * 0.02),
                    TexttField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a password";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters long";
                        }
                        if (!RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]',
                        ).hasMatch(value)) {
                          return "Password must contain at least one uppercase letter, one lowercase letter, and one number";
                        }
                        return null;
                      },
                      hintText: "Password",
                      keyboardType: TextInputType.text,
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: deviceInfo.screenWidth * 0.09),
              child: InkWell(
                onTap: _isLoading ? null : _signUp,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: deviceInfo.screenHeight * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _isLoading ? Colors.grey : Colors.blueAccent,
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: deviceInfo.screenWidth * 0.05,
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:  deviceInfo.screenWidth * 0.09),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have account ?",
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: deviceInfo.screenWidth * 0.04,),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "sign_in");
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold,fontSize: deviceInfo.screenWidth * 0.04,),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },

    );
  }
}
