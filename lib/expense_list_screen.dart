// expense_list_screen.dart

import 'package:flutter/material.dart';
import 'expense.dart';

class ExpenseListScreen extends StatefulWidget {
  final List<Expense> expenses;
  final Function(int) onExpenseRemoved;

  ExpenseListScreen({required this.expenses, required this.onExpenseRemoved});

  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense List'),
        backgroundColor: const Color.fromRGBO(84, 52, 104, 1.0),
      ),
      body: ListView.builder(
        itemCount: widget.expenses.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            shape: const RoundedRectangleBorder(
              side: BorderSide(width: 4, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            tileColor:
            widget.expenses[index].amount > 0 ? Colors.greenAccent : Colors.redAccent,
            title: Text(widget.expenses[index].name),
            subtitle: Text('\u{20B9}${widget.expenses[index].amount.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.onExpenseRemoved(index);
                setState(() {}); // Refresh the list
              },
            ),
          );
        },
      ),
    );
  }
}
