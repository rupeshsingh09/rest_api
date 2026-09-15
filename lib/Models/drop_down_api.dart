import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../dropdown_model.dart';

class DropDownApi extends StatefulWidget {
  const DropDownApi({super.key});

  @override
  State<DropDownApi> createState() => _DropDownApiState();
}

class _DropDownApiState extends State<DropDownApi> {
  Future<List<DropDownModel>> getPost() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      final body = jsonDecode(response.body) as List;

      if (response.statusCode == 200) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropDownModel(
            userId: map['userId'],
            id: map['id'],
            title: map['title'],
            body: map['body'],
          );
        }).toList();
      }
    } on SocketException {
      throw Exception('no internet');
    }
    throw Exception('Error fetching data');
  }

  var selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drop Down Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<DropDownModel>>(
              future: getPost(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButton(
                    hint: const Text('Select value'),
                    isExpanded: true,
                    value: selectedValue,
                    icon: const Icon(Icons.add_circle_outline),
                    items: snapshot.data!.map((e) {
                      return DropdownMenuItem(
                        value: e.id.toString(),
                        child: Text(e.title),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedValue = value;
                      setState(() {});
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error loading posts');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
