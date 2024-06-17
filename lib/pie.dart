import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

/*void main() {
  runApp(MyApp());
}*/

class Charts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Analysis',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Analysis'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/'); // Navigate back to the previous screen
            },
          ),
        ),
        body: Center(
          child: ExpenseBarChart(),
        ),
      ),
    );
  }
}

class ExpenseBarChart extends StatefulWidget {
  @override
  _ExpenseBarChartState createState() => _ExpenseBarChartState();
}

class _ExpenseBarChartState extends State<ExpenseBarChart> {
  String _selectedGranularity = 'Yearly';
  String _selectedType = 'Expenses';
  String _selectedYear = '2021'; // Default year
  String _selectedMonth = 'Jan'; // Default month

  List<Map<String, dynamic>> _expenseData = [
    {'date': '2021-01-01', 'day': 'Mon', 'month': 'Jan', 'expenses': 100, 'savings': 50, 'area': 'Food'},
    {'date': '2021-02-02', 'day': 'Tue', 'month': 'Feb', 'expenses': 120, 'savings': 60, 'area': 'Entertainment'},
    {'date': '2021-01-03', 'day': 'Wed', 'month': 'Jan', 'expenses': 80, 'savings': 40, 'area': 'Transportation'},
    {'date': '2022-01-01', 'day': 'Mon', 'month': 'Jan', 'expenses': 150, 'savings': 70, 'area': 'Food'},
    {'date': '2022-03-02', 'day': 'Tue', 'month': 'Mar', 'expenses': 90, 'savings': 50, 'area': 'Entertainment'},
    {'date': '2022-01-03', 'day': 'Wed', 'month': 'Jan', 'expenses': 110, 'savings': 60, 'area': 'Transportation'},
    {'date': '2023-05-05', 'day': 'Mon', 'month': 'May', 'expenses': 130, 'savings': 60, 'area': 'Food'},
    {'date': '2023-01-02', 'day': 'Tue', 'month': 'Jan', 'expenses': 100, 'savings': 50, 'area': 'Entertainment'},
    {'date': '2023-06-03', 'day': 'Wed', 'month': 'Jun', 'expenses': 70, 'savings': 40, 'area': 'Transportation'},
  ];


  @override
  Widget build(BuildContext context) {

    return Column(

      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: _selectedGranularity,
              items: ['Yearly', 'Monthly', 'Daily']
                  .map((granularity) => DropdownMenuItem<String>(
                value: granularity,
                child: Text(granularity),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGranularity = value!;
                });
              },
            ),
            SizedBox(width: 20),
            if (_selectedGranularity != 'Yearly')
              DropdownButton<String>(
                value: _selectedYear,
                items: _getYearDropdownItems(),
                onChanged: (value) {
                  setState(() {
                    _selectedYear = value!;
                  });
                },
              ),
            SizedBox(width: 20),
            if (_selectedGranularity == 'Monthly' || _selectedGranularity == 'Daily')
              DropdownButton<String>(
                value: _selectedMonth,
                items: _getMonthDropdownItems(),
                onChanged: (value) {
                  setState(() {
                    _selectedMonth = value!;
                  });
                },
              ),
            SizedBox(width: 20),
            DropdownButton<String>(
              value: _selectedType,
              items: ['Expenses', 'Savings']
                  .map((type) => DropdownMenuItem<String>(
                value: type,
                child: Text(type),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
            ),
          ],
        ),
        SizedBox(
          width: 300,
          height: 300,
          child: Echarts(
            option: '''
              {
                tooltip: {
                  trigger: 'axis',
                  axisPointer: {
                    type: 'shadow'
                  }
                },
                grid: {
                  left: '3%',
                  right: '4%',
                  bottom: '3%',
                  containLabel: true
                },
                xAxis: [
                  {
                    type: 'category',
                    data: ${_xAxisLabels().map((label) => '"$label"').toList()},
                    axisTick: {
                      alignWithLabel: true
                    }
                  }
                ],
                yAxis: [
                  {
                    type: 'value'
                  }
                ],
                series: [
                  {
                    name: '$_selectedType',
                    type: 'bar',
                    barWidth: '80%',
                    itemStyle: {
                      color: '$_selectedType' == 'Expenses' ? '#ff7f0e' : '#1f77b4',
                    },
                    data: ${jsonEncode(_getBarChartData())}
                  }
                ]
              }
            ''',
          ),
        ),
        SizedBox(height: 20),
        PieChart(selectedGranularity: _selectedGranularity, expenseData: _expenseData),
      ],
    );
  }

  List<String> _xAxisLabels() {
    switch (_selectedGranularity) {
      case 'Yearly':
        return ['2021', '2022', '2023'];
      case 'Monthly':
        return List.generate(12, (index) => _monthName(index + 1));
      case 'Daily':
        return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
      default:
        return [];
    }
  }


  List<Map<String, dynamic>> _getBarChartData() {
    String selectedDate = _selectedYear + '-' + _getMonthNumber(_selectedMonth).toString().padLeft(2, '0');
    List<Map<String, dynamic>> filteredData = _expenseData.where((entry) => entry['date'].startsWith(selectedDate)).toList();
    return filteredData.map((entry) => {'value': entry[_selectedType.toLowerCase()], 'name': entry['day']}).toList();
  }

  List<String> _getDaysInMonth() {
    int year = int.parse(_selectedYear);
    int month = _getMonthNumber(_selectedMonth);
    int daysInMonth = DateTime(year, month + 1, 0).day;
    return List.generate(daysInMonth, (index) => (index + 1).toString());
  }

  int _getMonthNumber(String monthName) {
    switch (monthName) {
      case 'Jan':
        return 1;
      case 'Feb':
        return 2;
      case 'Mar':
        return 3;
      case 'Apr':
        return 4;
      case 'May':
        return 5;
      case 'Jun':
        return 6;
      case 'Jul':
        return 7;
      case 'Aug':
        return 8;
      case 'Sep':
        return 9;
      case 'Oct':
        return 10;
      case 'Nov':
        return 11;
      case 'Dec':
        return 12;
      default:
        return 0;
    }
  }

  String _monthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }


  List<DropdownMenuItem<String>> _getYearDropdownItems() {
    List<String> years = ['2021', '2022', '2023'];
    return years
        .map((year) => DropdownMenuItem<String>(
      value: year,
      child: Text(year),
    ))
        .toList();
  }

  List<DropdownMenuItem<String>> _getMonthDropdownItems() {
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    if (_selectedGranularity == 'Monthly') {
      // If granularity is Daily, don't show the month dropdown
      return [];
    }

    return months
        .map((month) => DropdownMenuItem<String>(
      value: month,
      child: Text(month),
    ))
        .toList();
  }
}

class PieChart extends StatelessWidget {
  final String selectedGranularity;
  final List<Map<String, dynamic>> expenseData;

  const PieChart({Key? key, required this.selectedGranularity, required this.expenseData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> categories;
    switch (selectedGranularity) {
      case 'Yearly':
        categories = ['Food', 'Entertainment', 'Transportation'];
        break;
      case 'Monthly':
        categories = ['Food', 'Entertainment', 'Transportation']; // Modify as needed
        break;
      case 'Daily':
        categories = ['Food', 'Entertainment', 'Transportation']; // Modify as needed
        break;
      default:
        categories = [];
        break;
    }

    List<double> categoryExpenses = List.filled(categories.length, 0);

    // Aggregate expenses by category
    for (var entry in expenseData) {
      var expense = entry['expenses'];
      var area = entry['area'];
      var index = categories.indexOf(area);
      if (index != -1) {
        categoryExpenses[index] += expense;
      }
    }

    List<Map<String, dynamic>> pieChartData = List.generate(categories.length, (index) {
      return {'value': categoryExpenses[index], 'name': categories[index]};
    });

    return SizedBox(
      width: 300,
      height: 300,
      child: Echarts(
        option: '''
          {
            tooltip: {
              trigger: 'item',
              formatter: '{a} <br/>{b}: {c} ({d}%)'
            },
            series: [
              {
                name: 'Categories',
                type: 'pie',
                radius: ['50%', '70%'],
                avoidLabelOverlap: false,
                label: {
                  show: false,
                  position: 'center'
                },
                emphasis: {
                  label: {
                    show: true,
                    fontSize: '20',
                    fontWeight: 'bold'
                  }
                },
                labelLine: {
                  show: false
                },
                data: ${jsonEncode(pieChartData)}
              }
            ]
          }
        ''',
      ),
    );
  }
}