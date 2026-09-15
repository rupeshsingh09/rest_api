import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/Models/Postsmodel.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // yh API get krne k liye h
  List<PostsModel> postList =
      []; // postman me class nh bna h esliye list bna rhe h nh to direct class ko call kr dete

  Future<List<PostsModel>> getPostApi() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    // 🔹 Debug print to check API ka response
    print('Status Code: ${response.statusCode}');
    print(
      'Response Body (first 100 chars): ${response.body.substring(0, 100)}',
    );

    // ab jo v data aayega usko decode krenge
    if (response.statusCode == 200) {
      // condition lga kr check kiye h ki stqtuscode ka response 200 aata h to value return krva denge
      try {
        var data = jsonDecode(response.body.toString());
        postList.clear();
        for (Map<String, dynamic> i in data) {
          postList.add(PostsModel.fromJson(i));
        }
        return postList;
      } catch (e) {
        print("JSON Decode Error: $e");
        throw Exception("Invalid JSON format");
      }
    } else {
      print("Error fetching data: ${response.statusCode}");
      throw Exception("Failed to load data"); // 🔹 error message improve kiya h
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('REST APIs')),
      body: Column(
        children: [
          // ab API get krne ke badd jb data ko show krne k liye
          Expanded(
            // 🔹 Fixed FutureBuilder logic below
            child: FutureBuilder<List<PostsModel>>(
              future:
                  getPostApi(), // getpostApi function ko call kiye h, yh call krne ke badd us function pe jayega fir wait krega kyuki future use kiye h upr
              builder: (context, snapshot) {
                // yha p condition lga kr check krenge ki snapshot k pass koi data h v ya nhh
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // yha p error show ho rha h agar data fetch nh ho pa rha
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No data found"));
                } else {
                  // listview ko esliye use krte h ki bahut data h to list form m aayega data
                  var posts = snapshot.data!;
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title\n' + posts[index].title.toString()),
                              SizedBox(height: 6),
                              Text(
                                'Description\n' + posts[index].body.toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
