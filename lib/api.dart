import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

final apiKey = 'AIzaSyAvzocdMuMuKX64sgGnUUQPzM802TdDkUI';
final searchEngineId = 'c54ee4552c3a347f6';
final query = 'savings policies';

class Api extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Savings Policies'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/'); // Navigate back to the previous screen
            },
          ),
        ),
        body: FutureBuilder(
          future: searchSavingsPolicies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Map<String, dynamic>> searchResults = snapshot.data as List<Map<String, dynamic>>;
              return ListView.builder(
                itemCount: searchResults.length > 10 ? 10 : searchResults.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.lightBlue, // Set the color of the Container
                    child: Card(
                      child: ListTile(
                        title: Text(searchResults[index]['title'] ?? ''),
                        subtitle: Text(searchResults[index]['snippet'] ?? ''),
                        onTap: () {
                          _launchUrl(Uri.parse(searchResults[index]['link']));
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

Future<List<Map<String, dynamic>>> searchSavingsPolicies() async {
  final url = 'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$searchEngineId&q=$query';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> items = data['items'];
    return items.map<Map<String, dynamic>>((item) {
      return {
        'title': item['title'],
        'link': item['link'],
        'snippet': item['snippet'],
      };
    }).toList();
  } else {
    throw Exception('Failed to load search results');
  }
}

void _launchURL(String? link) async {
  if (link != null && await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Could not launch $link';
  }
}

Future<void> _launchUrl(Uri _url) async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}