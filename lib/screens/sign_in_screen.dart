import 'package:flutter/material.dart';
import '../responsive/uiComponanets/infowidget.dart';
import '../widgets/text_field.dart';
import '../services/auth_service.dart';

class SignInScreen extends StatefulWidget {

  @override
  State<SignInScreen> createState() => _SignInScreenState();

}


class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String email = '', password = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isobscure = true;
  bool _isLoading = false;

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _authService.signIn(
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
      return Scaffold(
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: deviceInfo.screenWidth * 0.01),
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
                    onTap: () {
                      Navigator.pushNamed(context, "sign_up");
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
                        "sign up",
                        style: TextStyle(color: Colors.blueAccent,fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: deviceInfo.screenWidth * 0.04,top:deviceInfo.screenWidth * 0.1 ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: deviceInfo.screenHeight * 0.06),
                      Text(
                        "Sign in",
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
            SizedBox(height: deviceInfo.screenHeight * 0.06),
            Padding(
              padding:EdgeInsets.all(deviceInfo.screenWidth * 0.09),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TexttField(
                      controller:emailController ,
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
                      hintText: 'Enter Your Email',
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: Icon(Icons.email_outlined),
                    ),
                    SizedBox(height: deviceInfo.screenHeight * 0.02),
                    TexttField(
                      controller: passwordController,
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
                          return "Password must contain at least one uppercase letter, one lowercase letter, and one number"; // إذا كانت لا تحتوي على حرف كبير وصغير ورقم
                        }
                        return null;
                      },
                      obscureText: _isobscure,
                      hintText: "Enter Your Password",
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        _isobscure ? Icons.visibility : Icons.visibility_off,),
                      prefixIcon: Icon(Icons.password),
                    ),
                    Padding(
                      padding: EdgeInsets.all(deviceInfo.screenWidth * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "forget password?",
                            style: TextStyle(color: Colors.blue, fontSize:  deviceInfo.screenWidth * 0.04,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Sign up",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize:  deviceInfo.screenWidth * 0.04,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding:EdgeInsets.all(deviceInfo.screenWidth * 0.09),
              child: Column(
                children: [
                  InkWell(
                    onTap: _isLoading ? null : _signIn,
                    child: Container(
                      width: double.infinity,
                      height: deviceInfo.screenHeight * 0.07,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _isLoading ? Colors.grey : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: deviceInfo.screenWidth * 0.05,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: deviceInfo.screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont have an account?",
                        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: deviceInfo.screenWidth * 0.04, ),
                      ),
                      InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, "sign_up");
                          },
                          child: Text("sign up", style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: deviceInfo.screenWidth * 0.04,))),
                    ],
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
