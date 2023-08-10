import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';
import 'package:users/home.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _phoneController = TextEditingController();

  Future<UserCredential> _signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    if (userCredential != null && userCredential.user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    }
    return userCredential;
  }

  Future<void> _verifyPhoneNumber(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhoneVerificationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screensize=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Container(
                width:screensize.width,
                height: 32,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    "Welcome Back!",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
                  ),
                ),
              ),
              Container(
                height: 14,
                width:screensize.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    'Make it work,make it right,make it fast',
                    textAlign: TextAlign.start,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                width:screensize.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0,right: 24.0),
                  child: TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'E-Mail',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ), // icon is 48px widget.
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                width:screensize.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0,right: 24.0),
                  child: PasswordField(),
                ),
              ),
              Container(

                width:screensize.width,
                child: TextButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0,right: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forget Password?",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    )),
              ),



              Container(
                margin: EdgeInsets.only(top: 15),
                width:screensize.width,
                height: 55,
                child:
                Padding(
                  padding: const EdgeInsets.only(left: 24.0,right: 24.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Login",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),
              Text("OR",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),

              Container(
                margin: EdgeInsets.only(top: 30),
                width:screensize.width,
                height: 55,
                child:
                Padding(
                  padding: const EdgeInsets.only(left: 24.0,right: 24.0),
                  child:
                  ElevatedButton(
                    onPressed: () => _signInWithGoogle(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue.shade50,
                        side: BorderSide(color: Colors.black, width: 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/google.png',
                          width: 40,
                          height: 30,
                        ),
                        Text(
                          '  Login With Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.only(top: 30),
                width:screensize.width,
                height: 55,
                child:
                Padding(
                  padding: const EdgeInsets.only(left: 24.0,right: 24.0),
                  child:
                  ElevatedButton(
                    onPressed: () => _verifyPhoneNumber(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue.shade50,
                        side: BorderSide(color: Colors.black, width: 1)),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/phone.png',
                          width: 40,
                          height: 30,
                        ),
                        Text(
                          '  Login With Phone',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),


                  ),
                ),
              ),

              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({Key? key}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;
  var ctrlrr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If  focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  bool s = false;
  validateStructure() {
    print("listner called");
    if (ctrlrr.text.length == 8) {
      setState(() {
        s = true;
        _formKey.currentState?.validate();
      });
    } else if (ctrlrr.text.length > 8) {
      setState(() {
        s = false;
        _formKey.currentState?.validate();
      });
    } else {
      setState(() {
        s = false;
      });
    }
    print("validating");
    _formKey.currentState?.validate();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init_ state");
    ctrlrr.addListener(validateStructure);
    print("listner added");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        // maxLength: 8,
        controller: ctrlrr,
        keyboardType: TextInputType.number,
        obscureText: _obscured,
        focusNode: textFieldFocusNode,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          prefixIcon: Padding(
            padding: EdgeInsets.all(0.0),
            child: Icon(
              Icons.fingerprint_outlined,
              color: Colors.grey,
            ), // icon is 48px widget.
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: GestureDetector(
              onTap: _toggleObscured,
              child: Icon(
                _obscured
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                size: 24,
              ),
            ),
          ),
        ),

        validator: (value) {
          return !s ? "atleast 8 char" : null;
        },
      ),
    );
  }
}

class PhoneVerificationScreen extends StatefulWidget {
  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();
  TextEditingController otpCode = TextEditingController();

  bool isLoading = false;

  String _verificationId = '';

  Future<void> phoneSignIn({required String phoneNumber}) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      this.otpCode.text = authCredential.smsCode!;
    });
    if (authCredential.smsCode != null) {
      try {
        UserCredential credential =
            await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await _auth.signInWithCredential(authCredential);
        }
      }
      setState(() {
        isLoading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      showMessage("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this._verificationId = verificationId;
    print(forceResendingToken);
    print("code sent");
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

  void showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _smsCodeController.text,
    );
    await _auth.signInWithCredential(credential);
    Navigator.pop(context);
  }

  bool touched = false;
  FocusNode focusNode = FocusNode();
  textlistner() {
    focusNode.requestFocus();
    setState(() {
      touched = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneNumberController.addListener(textlistner);
  }

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    var h2=800;
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      body:OrientationBuilder(
        builder: (context, orientation){
          if(orientation == Orientation.portrait){
            return SafeArea(
              top: true,
              child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      height: h2/2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0,right: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width:w,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Enter Your Mobile\nNumber",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                                )),
                            Container(
                                width:w,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("We have sent Verification code to\nyour Mobile Number",textAlign: TextAlign.center,),
                                )),

                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: h2/2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0,right: 24),
                        child: Stack(

                          children: [
                            Positioned(
                              top: 0,
                              left: 8,
                              child: Container(
                                  width:w,
                                  child: Text("Phone number")),
                            ),
                            Positioned(
                              top: 24,
                              child: Container(

                                width: w-48,
                                child: IntlPhoneField(

                                  focusNode: focusNode,
                                  controller: _phoneNumberController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20))),
                                  showDropdownIcon: false,
                                  showCountryFlag: false,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 75,
                              bottom: 128,
                              child: Container(

                                width: w-48,
                                color: Colors.transparent,
                                child: Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight, child: Container(color: Colors.transparent,),
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 64,
                              child: Container(
                                  height: 55,
                                  width: w-48,
                                  child:ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      //foregroundColor: Colors.pinkAccent,
                                      backgroundColor: Color(0xffefefef),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(27))),

                                    ),
                                    onPressed: (){},
                                    child: Text("send otp",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],)

              ),
            );
          }else{
            return SafeArea(
              top: true,
              child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      height: h2/2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0,right: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width:w,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Enter Your Mobile\nNumber",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                                )),
                            Container(
                                width:w,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("We have sent Verification code to\nyour Mobile Number",textAlign: TextAlign.center,),
                                )),

                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: h2/2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0,right: 24),
                        child: Stack(

                          children: [
                            Positioned(
                              top: 0,
                              left: 8,
                              child: Container(
                                  width:w,
                                  child: Text("Phone number")),
                            ),
                            Positioned(
                              top: 24,
                              child: Container(

                                width: w-48,
                                child: IntlPhoneField(

                                  focusNode: focusNode,
                                  controller: _phoneNumberController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20))),
                                  showDropdownIcon: false,
                                  showCountryFlag: false,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 75,
                              bottom: 128,
                              child: Container(

                                width: w-48,
                                color: Colors.transparent,
                                child: Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight, child: Container(color: Colors.transparent,),
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 64,
                              child: Container(
                                  height: 55,
                                  width: w-48,
                                  child:ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        //foregroundColor: Colors.pinkAccent,
                                      backgroundColor: Color(0xffefefef),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(27))),

                                    ),
                                    onPressed: (){},
                                    child: Text("send otp",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],)

              ),
            );
          }
        },
      ),


    );
  }
}
