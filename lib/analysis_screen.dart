import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;



class AnalysisScreen extends StatefulWidget {
  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final List<ExpenseData> _expenseData = [
    ExpenseData('Jan', 200, [
      CategoryExpense('Food', 100),
      CategoryExpense('Entertainment', 50),
      CategoryExpense('Transportation', 50),
    ]),
    ExpenseData('Feb', 300, [
      CategoryExpense('Food', 150),
      CategoryExpense('Entertainment', 80),
      CategoryExpense('Transportation', 70),
    ]),
    ExpenseData('Mar', 150, [
      CategoryExpense('Food', 70),
      CategoryExpense('Entertainment', 40),
      CategoryExpense('Transportation', 40),
    ]),
    ExpenseData('Apr', 400, [
      CategoryExpense('Food', 200),
      CategoryExpense('Entertainment', 100),
      CategoryExpense('Transportation', 100),
    ]),
  ];

  final List<ExpenseData> _savingsData = [
    ExpenseData('Jan', 10, [
      CategoryExpense('Investment', 5),
      CategoryExpense('Emergency Fund', 3),
      CategoryExpense('Retirement', 2),
    ]),
    ExpenseData('Feb', 15, [
      CategoryExpense('Investment', 7),
      CategoryExpense('Emergency Fund', 5),
      CategoryExpense('Retirement', 3),
    ]),
    ExpenseData('Mar', 7.5, [
      CategoryExpense('Investment', 3),
      CategoryExpense('Emergency Fund', 2),
      CategoryExpense('Retirement', 2.5),
    ]),
    ExpenseData('Apr', 20, [
      CategoryExpense('Investment', 10),
      CategoryExpense('Emergency Fund', 6),
      CategoryExpense('Retirement', 4),
    ]),
  ];

  bool _showExpenses = true; // Initially show expenses
  List<CategoryExpense>? _selectedCategoryExpenses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis'),
      ),
      body: Column(
        children: [
          // Toggle expenses/savings
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Show:'),
              SizedBox(width: 10),
              DropdownButton<bool>(
                value: _showExpenses,
                items: [
                  DropdownMenuItem<bool>(
                    value: true,
                    child: Text('Expenses'),
                  ),
                  DropdownMenuItem<bool>(
                    value: false,
                    child: Text('Savings'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _showExpenses = value!;
                  });
                },
              ),
            ],
          ),
          // Chart
          Expanded(
            child: GestureDetector(
              onTapDown: (details) {
                _onBarTap(details.localPosition.dx);
              },
              child: charts.BarChart(
                _showExpenses ? _createExpenseSeries() : _createSavingsSeries(),
                animate: true,
              ),
            ),
          ),
          // Selected category expenses pie chart
          _selectedCategoryExpenses != null
              ? Expanded(
            child: DelayedPieChart(
              selectedCategoryExpenses: _selectedCategoryExpenses!,
              createSelectedCategorySeries: _createSelectedCategorySeries,
            ),
          )
              : Text('No data selected for pie chart'),
        ],
      ),
    );
  }

  void _onBarTap(double tapPositionX) {
    final barWidth = (MediaQuery.of(context).size.width / 5); // 5 bars in total
    final selectedBarIndex = (tapPositionX / barWidth).floor();
    final selectedData = _showExpenses ? _expenseData[selectedBarIndex] : _savingsData[selectedBarIndex];
    setState(() {
      _selectedCategoryExpenses = selectedData.categoryExpenses;
    });
  }

  List<charts.Series<ExpenseData, String>> _createExpenseSeries() {
    return [
      charts.Series<ExpenseData, String>(
        id: 'Expense',
        data: _expenseData,
        domainFn: (ExpenseData expense, _) => expense.month,
        measureFn: (ExpenseData expense, _) => expense.amount,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        labelAccessorFn: (ExpenseData expense, _) => '\$${expense.amount}',
      ),
    ];
  }

  List<charts.Series<ExpenseData, String>> _createSavingsSeries() {
    return [
      charts.Series<ExpenseData, String>(
        id: 'Savings',
        data: _savingsData,
        domainFn: (ExpenseData savings, _) => savings.month,
        measureFn: (ExpenseData savings, _) => savings.amount,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        labelAccessorFn: (ExpenseData savings, _) => '\$${savings.amount}',
      ),
    ];
  }

  List<charts.Series<CategoryExpense, String>> _createSelectedCategorySeries() {
    return [
      charts.Series<CategoryExpense, String>(
        id: 'Category',
        data: _selectedCategoryExpenses!,
        domainFn: (CategoryExpense category, _) => category.category,
        measureFn: (CategoryExpense category, _) => category.amount,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.blue),
        labelAccessorFn: (CategoryExpense category, _) => '\$${category.amount}',
      ),
    ];
  }
}

class ExpenseData {
  final String month;
  final double amount;
  final List<CategoryExpense>? categoryExpenses;

  ExpenseData(this.month, this.amount, [this.categoryExpenses]);
}

class CategoryExpense {
  final String category;
  final double amount;

  CategoryExpense(this.category, this.amount);
}

class DelayedPieChart extends StatefulWidget {
  final List<CategoryExpense> selectedCategoryExpenses;
  final Function createSelectedCategorySeries;

  DelayedPieChart({
    required this.selectedCategoryExpenses,
    required this.createSelectedCategorySeries,
  });

  @override
  _DelayedPieChartState createState() => _DelayedPieChartState();
}

class _DelayedPieChartState extends State<DelayedPieChart> {
  Size? _chartSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final size = renderBox.size;
          setState(() {
            _chartSize = size;
          });
        });

        return _chartSize != null
            ? Container(
          width: _chartSize!.width,
          height: _chartSize!.height,
          child: charts.PieChart(
            widget.createSelectedCategorySeries(),
            animate: true,
            defaultRenderer: charts.ArcRendererConfig(
              arcWidth: 60,
              arcRendererDecorators: [
                charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.inside,
                ),
              ],
            ),
          ),
        )
            : SizedBox(); // Return a SizedBox if _chartSize is null
      },
    );
  }
}
