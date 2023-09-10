import 'package:flutter/material.dart';
import 'expense.dart';
import 'expense_list_screen.dart';

class ExpenseTrackerHomePage extends StatefulWidget {
  @override
  _ExpenseTrackerHomePageState createState() => _ExpenseTrackerHomePageState();
}

class _ExpenseTrackerHomePageState extends State<ExpenseTrackerHomePage> {
  double totalExpense = 0;
  List<Expense> expenses = [];

  void _showExpenseDialog(BuildContext context) {
    String expenseName = '';
    double expenseAmount = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          backgroundColor: const Color.fromRGBO(84, 83, 84, 1.0),
          title:
          const Text('Add Expense', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    labelText: 'Expense Name',
                    hintStyle: TextStyle(color: Colors.white)),
                onChanged: (value) {
                  expenseName = value;
                },
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: ('Expense Amount'),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  expenseAmount = double.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child:
              const Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Spent', style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (expenseName.isNotEmpty && expenseAmount > 0) {
                  setState(() {
                    expenses.add(Expense(expenseName, -expenseAmount));
                    totalExpense += expenseAmount;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child:
              const Text('Received', style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (expenseName.isNotEmpty && expenseAmount > 0) {
                  setState(() {
                    expenses.add(Expense(expenseName, expenseAmount));
                    totalExpense -= expenseAmount;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void removeExpense(int index) {
    if (expenses[index].amount > 0) {
      setState(() {
        totalExpense -= expenses[index].amount;
        expenses.removeAt(index);
      });
    } else {
      setState(() {
        totalExpense += expenses[index].amount;
        expenses.removeAt(index);
      });
    }
  }

  void _showExpenseListScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseListScreen(
          expenses: expenses,
          onExpenseRemoved: removeExpense,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
              'Expense Tracker',
              style: TextStyle(fontWeight: FontWeight.w400),
            )),
        backgroundColor: const Color.fromRGBO(84, 52, 104, 1.0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 5)],
                    color: Color.fromRGBO(84, 52, 104, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                height: screenWidth * 0.7,
                width: screenWidth * 0.9,
                child: Center(
                  child: Text(
                    totalExpense >= 0
                        ? 'You have spent: \u{20B9}${totalExpense.toStringAsFixed(2)}'
                        : 'You have earned: \u{20B9}${(-totalExpense).toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(84, 52, 104, 1.0)),
              onPressed: () {
                _showExpenseListScreen(context);
              },
              child: const Text('View Expense List'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showExpenseDialog(context);
        },
        tooltip: 'Add Expense',
        label: const Text(
          "Add expense",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        icon: const Icon(Icons.add),
        elevation: 5,
        backgroundColor: const Color.fromRGBO(84, 52, 104, 1.0),
      ),
    );
  }
}
