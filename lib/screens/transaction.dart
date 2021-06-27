import 'package:path/path.dart';
import '../components/userData.dart';
import 'package:sqflite/sqflite.dart';
import '../components/navDrawer.dart';
import 'package:flutter/material.dart';
import '../database/databaseSchema.dart';
import '../components/addExpenseTab.dart';
import '../components/addRevenueTab.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String amount = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = ModalRoute.of(context)!.settings.arguments as UserData;

    void getUserAmount() async {
      var path = join((await getDatabasesPath()), 'expenses.db');

      Database db = await initializeDB(path);

      var userAmount = await db.query(
        UserTable.tableName,
        columns: [UserTable.columnAmount],
        where: '${UserTable.columnEmail} = ?',
        whereArgs: [userData.email],
      );

      setState(() => amount = userAmount[0]['amount'].toString());
    }

    if (amount.length == 0) getUserAmount();

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Operations'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: amount.length > 0
                  ? Text(
                      '\$$amount',
                      style: TextStyle(
                        fontSize: 25,
                        color: double.parse(amount) < 0
                            ? Colors.redAccent[700]
                            : Colors.greenAccent[400],
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : CircularProgressIndicator(
                      color: Colors.greenAccent[400],
                    ),
            ),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Expenses'),
            Tab(text: 'Revenue'),
          ],
        ),
      ),
      drawer: Drawer(child: NavDrawer(userData: userData)),
      body: TabBarView(
        controller: _tabController,
        children: [
          AddExpenseTab(
            email: userData.email,
            getAmountCallback: getUserAmount,
          ),
          AddRevenueTab(
            email: userData.email,
            getAmountCallback: getUserAmount,
          ),
        ],
      ),
    );
  }
}
