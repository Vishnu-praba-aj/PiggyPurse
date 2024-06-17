import 'package:flutter/material.dart';

class PersonalizedSavingsPage extends StatefulWidget {
  const PersonalizedSavingsPage({Key? key}) : super(key: key);

  @override
  _PersonalizedSavingsPageState createState() => _PersonalizedSavingsPageState();
}

class _PersonalizedSavingsPageState extends State<PersonalizedSavingsPage> {
  String incomeType = '';

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(primary: const Color(0xFF17BEBB));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(colorScheme: colorScheme),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Personalized Savings Guide'),
          backgroundColor: colorScheme.primary,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/'); // Navigate back to the previous screen
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20.0),
              Text(
                'Hey there!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Let\'s personalize your savings journey!',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 20.0),
              Text(
                'How do you earn your cash?',
                style: TextStyle(fontSize: 18.0),
              ),
              _buildRadioButtons(),
              const SizedBox(height: 20.0),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: incomeType == 'salaried' ? 100 : 0,
                curve: Curves.easeInOut,
                child: incomeType == 'salaried'
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'What\'s your monthly salary?',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: colorScheme.primary.withOpacity(0.1),
                      ),
                    ),
                  ],
                )
                    : SizedBox.shrink(),
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What is your average monthly income?',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: colorScheme.primary),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: colorScheme.primary,
                            inactiveTrackColor: colorScheme.primary.withOpacity(0.3),
                            thumbColor: colorScheme.primary,
                            overlayColor: colorScheme.primary.withOpacity(0.3),
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                            overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                            valueIndicatorColor: colorScheme.primary,
                            valueIndicatorTextStyle: TextStyle(color: Colors.white),
                          ),
                          child: Slider(
                            value: 5000, // Set a default value or use state to manage it
                            min: 0,
                            max: 10000,
                            divisions: 20, // Set divisions to 20 for values 0 to 10000
                            label: 'Monthly Income', // You can use the selected value as label
                            onChanged: (double value) {
                              // Update the state with the selected value
                            },
                            onChangeEnd: (double value) {
                              // Callback when the slider movement ends
                            },
                            semanticFormatterCallback: (double value) {
                              // Format the value for accessibility features
                              return '${value.round()} rupees';
                            },
                          ),
                        ),
                      ),
                      Text(
                        '${5000.round()} rupees',
                        style: TextStyle(fontSize: 16.0, color: colorScheme.primary),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What percentage of your expenses do you want to save?',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.pie_chart, color: colorScheme.primary),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: colorScheme.primary,
                            inactiveTrackColor: colorScheme.primary.withOpacity(0.3),
                            thumbColor: colorScheme.primary,
                            overlayColor: colorScheme.primary.withOpacity(0.3),
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                            overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                            valueIndicatorColor: colorScheme.primary,
                            valueIndicatorTextStyle: TextStyle(color: Colors.white),
                          ),
                          child: Slider(
                            value: 20, // Set a default value or use state to manage it
                            min: 0,
                            max: 100,
                            divisions: 10, // Set divisions to 10 for values 0 to 100
                            label: 'Savings Percentage', // You can use the selected value as label
                            onChanged: (double value) {
                              // Update the state with the selected value
                            },
                            onChangeEnd: (double value) {
                              // Callback when the slider movement ends
                            },
                            semanticFormatterCallback: (double value) {
                              // Format the value for accessibility features
                              return '${value.round()}%';
                            },
                          ),
                        ),
                      ),
                      Text(
                        '20%', // Replace with the actual value from state
                        style: TextStyle(fontSize: 16.0, color: colorScheme.primary),
                      ),
                    ],
                  ),
                ],
              ),



              const SizedBox(height: 20.0),
              Text(
                'What are some of your favorite things to spend money on?',
                style: TextStyle(fontSize: 18.0),
              ),
              _buildExpenseOptions(),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Saving logic goes here
                },
                child: const Text(
                  'Let\'s Save!',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  //primary: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('I\'m a Salaried Savvy Saver! 💼'),
          leading: Radio(
            value: 'salaried',
            groupValue: incomeType,
            onChanged: (value) {
              setState(() {
                incomeType = value.toString();
              });
            },
          ),
        ),
        ListTile(
          title: const Text('I Make it Rain Irregularly! 💸'),
          leading: Radio(
            value: 'irregular',
            groupValue: incomeType,
            onChanged: (value) {
              setState(() {
                incomeType = value.toString();
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Pocket Money is my Jam! 🤑'),
          leading: Radio(
            value: 'pocket_money',
            groupValue: incomeType,
            onChanged: (value) {
              setState(() {
                incomeType = value.toString();
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseOptions() {
    final List<String> options = [
      'Food 🍔',
      'Clothing 👕',
      'Travel ✈️',
      'Stationary 📝',
      'Cosmetics 💄',
      'Self care 🛀',
      'Rent 🏠',
      'Utilities 💡',
      'Entertainment 🎬',
      'Healthcare 🩺',
      'Education 📚',
    ];

    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: options.map((option) {
        return ChoiceChip(
          label: Text(option),
          selected: false,
          onSelected: (_) {},
        );
      }).toList(),
    );
  }
}

