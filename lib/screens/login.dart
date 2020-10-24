
import 'package:flutter/material.dart';
import 'package:flutter_generalshop/api/authentication.dart';
import 'package:flutter_generalshop/customer/user.dart';
import 'package:flutter_generalshop/screens/home_page.dart';
import 'package:flutter_generalshop/screens/utilities/screen_utilities.dart';
import 'package:flutter_generalshop/screens/utilities/size_config.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  double screenHeight;
  ScreenConfig screenConfig;
  WidgetSize widgetSize;
  double screenWidth;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Authentication authentication = Authentication();

  var _formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    screenConfig = ScreenConfig(context);
    widgetSize = WidgetSize(screenConfig);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16.0, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'sing in ',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontSize: 32),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Login to continue to your account ',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontSize: 16, color: Colors.grey.shade700),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            _loginForm(context),
            SizedBox(height: 16),
            SizedBox(
              width: screenWidth * 0.90,
              height: widgetSize.buttonHeight,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                onPressed: (_loading) ? null : _logInUser,
                child: (_loading)
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.orangeAccent),
                          backgroundColor: Colors.deepPurple,
                          strokeWidth: 1.3,
                        ),
                      )
                    : Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: widgetSize.buttonFontSize,
                            letterSpacing: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                color: ScreenUtilities.mainBlue,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account ?",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(color: Colors.grey.shade500),
                ),
                FlatButton(
                  child: Text(
                    'Sing up',
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(fontSize: 15),
                  ),
                  onPressed: () {
                    //send to sing up screen
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value.isEmpty) {
                return "Email is required";
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: "Email",
                hintStyle: Theme.of(context)
                    .textTheme
                    .subtitle
                    .copyWith(fontSize: 18, color: Colors.grey.shade500)),
          ),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) {
                return "Password is required";
              }
              return null;
            },
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              hintStyle: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(fontSize: 18, color: Colors.grey.shade500),
            ),
          )
        ],
      ),
    );
  }

  void _logInUser() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      String email = _emailController.text;
      String password = _passwordController.text;
      User user = await authentication.login(email, password);
      if (user.user_id != null) {
        setState(() {
          _loading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (cobtext) => HomePage()));
      } else {
        _loading = false;
      }
    }
  }
}
