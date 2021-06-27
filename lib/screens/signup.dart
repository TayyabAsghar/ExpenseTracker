import '../components/roundButton.dart';
//import '../components/userData.dart';
//import '../databaseSchema.dart';
//import '../screens/home.dart';
import '../theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  String name = '';
  String email = '';
  String password = '';
  String amount = '0';

  @override
  Widget build(BuildContext context) {
    // void onSignup() async {
    //   Database db;
    //   try {
    //     // Get device path of the database
    //     var path = join((await getDatabasesPath()), 'expenses.db');
    //     // Initialize DB UserTable static method
    //     db = await initializeDB(path);
    //     // Insert Record using helper function
    //     var id = await db.insert(UserTable.tableName, {
    //       UserTable.columnName: name,
    //       UserTable.columnEmail: email,
    //       UserTable.columnPassword: password,
    //       UserTable.columnAmount: int.parse(amount)
    //     });
    //     db.close();
    //     // record creation returns a rowid as the primary key
    //     print(id.toString());
    //     setState(() {
    //       showSpinner = false;
    //       FocusScope.of(context).unfocus();
    //       Navigator.of(context).pushNamed(HomeScreen.ROUTE,
    //           arguments: UserData(email: email, name: name));
    //     });
    //   } catch (e) {
    //     setState(() {
    //       showSpinner = false;
    //     });
    //     ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Email Address Already Exists.')));
    //     print(e);
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('SIGN UP'),
        // backgroundColor: Colors.blueAccent,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 48.0),
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 150,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(height: 44.0),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: kTextFieldDecoration.copyWith(
                    prefixIcon: Icon(Icons.badge),
                    labelText: 'Name',
                    hintText: 'Enter your name',
                  ),
                  onChanged: (value) => name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please Enter your Name';
                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: kTextFieldDecoration.copyWith(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email Address',
                    hintText: 'Enter your email address',
                  ),
                  onChanged: (value) => email = value,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please Enter Email Address';
                    else if (!RegExp(
                            r'^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$')
                        .hasMatch(value.toString()))
                      return 'Please Enter a valid Email Address.';
                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  obscureText: true,
                  decoration: kTextFieldDecoration.copyWith(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                  onChanged: (value) => password = value,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please Enter Password';
                    else if (value.toString().length < 6)
                      return 'Password length must be greater than 5.';
                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: kTextFieldDecoration.copyWith(
                    prefixIcon: Icon(Icons.attach_money),
                    labelText: 'Initial Amount',
                    hintText: 'Enter initial deposit',
                  ),
                  onChanged: (value) => amount = value,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please Enter an Amount';
                    else if (!RegExp(r'^[0-9]+$').hasMatch(value.toString()))
                      return 'Please Enter a valid Amount.';
                    return null;
                  },
                ),
                SizedBox(height: 24.0),
                Hero(
                  tag: 'sign-up',
                  child: RoundButton(
                    color: Colors.green.shade600,
                    title: 'SIGN UP',
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                      // if (_formKey.currentState!.validate()) {
                      //   setState(() => showSpinner = true);
                      //   //onSignup();
                      // }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
