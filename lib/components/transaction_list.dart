import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Nenhuma Transação Cadastrada!!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            padding: EdgeInsets.only(bottom: 100),
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(child: Text('R\$${tr.value}'))),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                  trailing: MediaQuery.of(context).size.width > 480
                      ? TextButton.icon(
                          onPressed: () => deleteTransaction(tr.id),
                          icon: const Icon(Icons.delete),
                          label: const Text('Excluir'),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).errorColor),
                          ))
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteTransaction(tr.id),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
          );
  }
}
