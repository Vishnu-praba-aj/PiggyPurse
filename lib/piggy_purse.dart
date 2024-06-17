import 'package:flutter/material.dart';
import 'login_page.dart'; // Import the login page
//import 'package:google_fonts/google_fonts.dart';

class PiggyPurseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piggy Purse',
      theme: ThemeData(
        primaryColorLight: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: PiggyPurseHomePage(),
    );
  }
}

class PiggyPurseHomePage extends StatefulWidget {
  @override
  _PiggyPurseHomePageState createState() => _PiggyPurseHomePageState();
}

class _PiggyPurseHomePageState extends State<PiggyPurseHomePage> {
  List<String> tags = ['Food', 'Shopping', 'Transport', 'Entertainment'];
  String selectedTag = 'Food'; // Default selected tag

  // For demonstration, let's assume some initial expense values for each tag
  Map<String, double> expenses = {
    'Food': 0.0,
    'Shopping': 0.0,
    'Transport': 0.0,
    'Entertainment': 0.0,
  };

  void _showExpenseInputDialog(BuildContext context) {
    TextEditingController expenseController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Expense'),
          content: TextField(
            controller: expenseController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: 'Enter amount'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your expense logic here
                double expenseAmount =
                    double.tryParse(expenseController.text) ?? 0.0;
                _addExpense(selectedTag, expenseAmount);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addExpense(String tag, double amount) {
    // Here you can handle adding the expense to your application logic
    setState(() {
      expenses[tag] = (expenses[tag] ?? 0.0) + amount;
      print(
          'Expense of \$$amount added for $tag'); // Increment the expense amount for the selected tag
    }); // Print the message with the expense amount and tag
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Piggy Purse'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                'Piggy Purse',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('About the App'),
              onTap: () {
                // Navigate to the About the App page
              },
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {
                // Navigate to the Help page
              },
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {
                // Navigate to the About Us page
              },
            ),
            ListTile(
              title: Text('Login/Sign up',
                         // style: GoogleFonts.lato(),
              ),

              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginPage()), // Navigate to the Login page
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'lib/backpic.jpeg'), // Replace 'assets/background_image.jpg' with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hello, World!',
                style: TextStyle(
                  fontFamily:
                  'Roboto', // Use the font family name defined in pubspec.yaml
                  fontWeight:
                  FontWeight.bold, // Adjust font weight as necessary
                  fontSize: 16, // Adjust font size as necessary
                ),
              ),
              DropdownButton<String>(
                value: selectedTag,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedTag = newValue;
                    });
                  }
                },
                items: tags.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showExpenseInputDialog(context); // Show expense input dialog
                },
                child: Text('Add Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}