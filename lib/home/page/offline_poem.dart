import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/home/page/offline_poem_detail.dart';

class OfflinePoem extends StatefulWidget {
  

  const OfflinePoem({super.key});

  @override
  State<OfflinePoem> createState() => _OfflinePoemState();
}

class _OfflinePoemState extends State<OfflinePoem> {
  List poems = [];

  @override
  void initState(){
    super.initState();
    loadPoems();
  }

  Future<void> loadPoems() async{
    final String jsonString = await rootBundle.loadString("assets/poems/poems.json");

    final List data = json.decode(jsonString);

    setState(() {
      poems = data;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Poems"),
      ),
      body: poems.isEmpty
      ? Center(
        child: CircularProgressIndicator(),
      )
      : ListView.builder(
        itemCount: poems.length,
        itemBuilder: (context, index){
          final poem = poems[index];

          return Card(
            margin: EdgeInsets.all(16),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  poem["imageUrl"],
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),

              title: Text(poem["title"]),
              subtitle: Text(poem["author"]),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OfflinePoemDetail(poem: poem,)));
              },
            ),

          );
        }
      )
    );
  }
}