import '../theme/theme.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import '../database/databaseSchema.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ExpenseView extends StatefulWidget {
  const ExpenseView(
      {Key? key,
      required this.expensesList,
      required this.email,
      required this.userAmount,
      required this.getDataFromDB})
      : super(key: key);
  final List expensesList;
  final String email;
  final String userAmount;
  final Function getDataFromDB;

  @override
  _ExpenseViewState createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView> {
  DateTime? startingTime;
  DateTime? endingTime;

  @override
  Widget build(BuildContext context) {
    List filteredList = new List.from(widget.expensesList);

    if (startingTime != null)
      filteredList = filteredList
          .where(
            (element) =>
                element[ExpenseTable.columnTimestamp] >=
                startingTime!.millisecondsSinceEpoch,
          )
          .toList();

    if (endingTime != null)
      filteredList = filteredList
          .where(
            (element) =>
                element[ExpenseTable.columnTimestamp] <=
                endingTime!.millisecondsSinceEpoch,
          )
          .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  OutlinedButton(
                    child: Text('From', style: outlinedButtonTextStyle),
                    onPressed: () {
                      // DatePicker.showDateTimePicker(context,
                      //     showTitleActions: true, onConfirm: (date) {
                      //   setState(() {
                      //     startingTime = date;
                      //   });
                      // }, currentTime: DateTime.now());
                    },
                  ),
                  Text(
                    startingTime != null
                        ? DateFormat('yyyy-MM-dd – kk:mm').format(startingTime!)
                        : "",
                  )
                ],
              ),
              Column(
                children: [
                  OutlinedButton(
                    child: Text('To', style: outlinedButtonTextStyle),
                    onPressed: () {
                      // DatePicker.showDateTimePicker(context,
                      //     showTitleActions: true, onConfirm: (date) {
                      //   setState(() {
                      //     endingTime = date;
                      //   });
                      // }, currentTime: DateTime.now());
                    },
                  ),
                  Text(
                    endingTime != null
                        ? DateFormat('yyyy-MM-dd – kk:mm').format(endingTime!)
                        : "",
                  )
                ],
              )
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text('ID', style: kDataColumnTextStyle),
                ),
                DataColumn(
                  label: Text('TITLE', style: kDataColumnTextStyle),
                ),
                DataColumn(
                  numeric: true,
                  label: Text('AMOUNT', style: kDataColumnTextStyle),
                ),
                DataColumn(
                  numeric: true,
                  label: Text('TRANSACTION TIME', style: kDataColumnTextStyle),
                ),
                DataColumn(
                  label: Text('DELETE', style: kDataColumnTextStyle),
                ),
              ],
              rows: filteredList
                  .map(
                    (record) => DataRow(
                      cells: [
                        DataCell(
                          Text(record['rowid'].toString()),
                        ),
                        DataCell(
                          Text(record[ExpenseTable.columnTitle]),
                        ),
                        DataCell(
                          Text('\$ ' +
                              record[ExpenseTable.columnAmount].toString()),
                        ),
                        DataCell(
                          Text(
                            DateFormat('yyyy-MM-dd – kk:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                record[ExpenseTable.columnTimestamp],
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              try {
                                var path = join(
                                  (await getDatabasesPath()),
                                  'expenses.db',
                                );

                                Database db = await initializeDB(path);

                                await db.transaction(
                                  (txn) async {
                                    await txn.delete(
                                      ExpenseTable.tableName,
                                      where: 'rowid = ?',
                                      whereArgs: [record['rowid']],
                                    );
                                    double remainder =
                                        double.parse(widget.userAmount) +
                                            double.parse(
                                              record[ExpenseTable.columnAmount]
                                                  .toString(),
                                            );

                                    print(remainder.toString());

                                    await txn.update(
                                      UserTable.tableName,
                                      {UserTable.columnAmount: remainder},
                                      where: '${UserTable.columnEmail} = ?',
                                      whereArgs: [widget.email],
                                    );
                                  },
                                );

                                await widget.getDataFromDB();

                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Expense Transaction deleted successfully.'),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Could Not Delete the Transaction.'),
                                  ),
                                );

                                print(e);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
