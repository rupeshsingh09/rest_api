import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ✅ Import the UserModel class that matches the /users API
import 'Models/UserModel.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  // ✅ List to store all users fetched from API
  List<UserModel> userList = [];

  // ✅ Function to call the API and get user data
  Future<List<UserModel>> getUserApi() async {
    // ✅ Make GET request to JSONPlaceholder /users API
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    // ✅ Decode the response body into a List of dynamic
    var data = jsonDecode(response.body.toString());

    // ✅ Check if API call was successful
    if (response.statusCode == 200) {
      // ✅ Clear previous data to avoid duplicates when widget rebuilds
      userList.clear();

      // ✅ Loop through each item in data and convert to UserModel
      for (var i in data) {
        userList.add(UserModel.fromJson(i as Map<String, dynamic>));
      }

      // ✅ Return the list of users
      return userList;
    } else {
      // ✅ If API fails, return empty list
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Api lec 10'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              // ✅ Call the API function
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                // ✅ While waiting for data, show loader
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator()); // loader at center
                } else {
                  // ✅ Once data is received, build ListView
                  return ListView.builder(
                    itemCount: userList.length, // total users
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            children: [
                              // ✅ Reusable row to show Name
                              ReusbalRow(
                                  title: 'Name',
                                  value: snapshot.data![index].name.toString()),
                              // ✅ Reusable row to show Username
                              ReusbalRow(
                                  title: 'Username',
                                  value:
                                  snapshot.data![index].username.toString()),
                              // ✅ Reusable row to show Email
                              ReusbalRow(
                                  title: 'Email',
                                  value: snapshot.data![index].email.toString()),
                              // ✅ Optional extra row showing Name (can remove if not needed)
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Name'),
                                  Text(snapshot.data![index].name.toString()),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

// ✅ Reusable row widget to display a title and value pair
class ReusbalRow extends StatelessWidget {
  String title, value;

  ReusbalRow({key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ✅ Title text
          Text(title),
          // ✅ Value text
          Text(value),
        ],
      ),
    );
  }
}
