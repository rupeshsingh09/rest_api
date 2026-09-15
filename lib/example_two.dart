import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  // List create kiye h and jo niche constructor bnaye h vh yha pe pass krenge
  List<Photos> photosList = [];

  // Future ka esliye kiye h ki wait krega and then list ko pass kiye h
  Future<List<Photos>> getPhotos() async {
    // API ka link denge jisse ki fata fetch kr ske
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );

    // Data ko decode krne k liye , mglb ki jo v data aayega uska response string m convert krke tb show krega hme
    var data = jsonDecode(response.body.toString());

    // Condition check krenge
    if (response.statusCode == 200) {
      // Agr status 200 rhega to loop lagayenge
      for (Map i in data) {
        Photos photos = Photos(
          title: i['title'],
          url: i['url'],
          id: i['id'],
        );
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Api Course'),
      ),
      body: Column(
        children: [
          // ListView use krenge to Expanded jarur use krenge
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              snapshot.data![index].url.toString()),
                        ),
                        title: Text('Notes id: ${snapshot.data![index].id}'),
                        subtitle:
                        Text(snapshot.data![index].title.toString()),
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

// Photos name se model create kr rhe h
class Photos {
  // Postman m 3 hi chij ta to 3 hi diye h i.e. title, url, id
  String title, url;
  int id;

  // Constructor create kiye h
  Photos({required this.title, required this.url, required this.id});
}
