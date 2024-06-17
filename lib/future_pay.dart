import 'package:flutter/material.dart';



class FuturePaymentsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future Payments',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FuturePaymentsScreen(),
    );
  }
}

class FuturePaymentsScreen extends StatefulWidget {
  @override
  _FuturePaymentsScreenState createState() => _FuturePaymentsScreenState();
}

class _FuturePaymentsScreenState extends State<FuturePaymentsScreen> {
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  List<Payment> _payments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Future Payments'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/'); // Navigate back to the previous screen
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _dataController,
                  decoration: InputDecoration(labelText: 'Data'),
                ),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                ),
                TextFormField(
                  controller: _reasonController,
                  decoration: InputDecoration(labelText: 'Reason'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _payments.add(
                        Payment(
                          data: _dataController.text,
                          amount: double.parse(_amountController.text),
                          reason: _reasonController.text,
                        ),
                      );
                      _dataController.clear();
                      _amountController.clear();
                      _reasonController.clear();
                    });
                  },
                  child: Text('Add '),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _payments.length,
              itemBuilder: (context, index) {
                return PaymentCard(
                  payment: _payments[index],
                  onDelete: () {
                    setState(() {
                      _payments.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Payment {
  final String data;
  final double amount;
  final String reason;

  Payment({
    required this.data,
    required this.amount,
    required this.reason,
  });
}

class PaymentCard extends StatelessWidget {
  final Payment payment;
  final VoidCallback onDelete;

  PaymentCard({required this.payment, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('Data: ${payment.data}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount: \$${payment.amount}'),
            Text('Reason: ${payment.reason}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}