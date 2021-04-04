import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  final void Function({required String title, required double value}) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Titulo'),
                ),
                TextField(
                  controller: valueController,
                  decoration: InputDecoration(labelText: 'Valor (R\$)'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        final title = titleController.text;
                        final value =
                            double.tryParse(valueController.text) ?? 0.0;
                        onSubmit(title: title, value: value);
                      },
                      child: Text(
                        'nova transação',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
