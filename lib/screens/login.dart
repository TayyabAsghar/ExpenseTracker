import '../components/roundButton.dart';
//import '../components/userData.dart';
//import '../DatabaseSchema.dart';
//import '../screens/home.dart';
import '../theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    // void onLogin() async {
    //   Database db;
    //   try {
    //     var path = join((await getDatabasesPath()), 'expenses.db');
    //     db = await initializeDB(path);
    //     var name = await db.query(
    //       UserTable.tableName,
    //       columns: [UserTable.columnName],
    //       where:
    //           '${UserTable.columnEmail} = ? AND ${UserTable.columnPassword} = ?',
    //       whereArgs: [email, password],
    //     );
    //     db.close();
    //     print(name);
    //     if (name.length < 1)
    //       throw Exception();
    //     else {
    //       setState(() {
    //         showSpinner = false;
    //         FocusScope.of(context).unfocus();

    //         Navigator.of(context).pushNamed(
    //           HomeScreen.ROUTE,
    //           arguments: UserData(
    //               email: email, name: name[0][UserTable.columnName].toString()),
    //         );
    //       });
    //     }
    //   } catch (e) {
    //     setState(() {
    //       showSpinner = false;
    //     });
    //     FocusScope.of(context).unfocus();

    //     ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Email and Password do not match.')));
    //     print(e);
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOGIN',
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
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
                SizedBox(height: 48.0),
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
                SizedBox(height: 8.0),
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
                    else if (value.toString().length < 8)
                      return 'Password length must be greater than 8.';
                  },
                ),
                SizedBox(height: 24.0),
                Hero(
                  tag: 'login',
                  child: RoundButton(
                    color: Colors.lightGreen.shade900,
                    title: 'LOGIN',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => showSpinner = true);
                        //onLogin();
                      }
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
