import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot poem;
  const DetailPage({super.key, required this.poem});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final data = widget.poem.data() as Map<String, dynamic>;
    Timestamp? timestamp = data["createdAt"];
    String uploadDate = "";

    if(timestamp != null){
      final date = timestamp.toDate();
      uploadDate = "${date.day}/${date.month}/${date.year}";
    }

    return Scaffold(

      appBar: AppBar(
        title: Text(data["title"] ?? "poem"),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              data["image"] ?? "",
              width: double.infinity,
              height: 280,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 280,
                  color: Colors.grey,
                  child: Center(
                    child: Icon(Icons.image, size: 70,),
                  ),
                );


              },
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data["title"] ?? "", style: TextStyle(),),
                  Text("By ${data["title"] ?? ""}", style: TextStyle(),),

                  Text("Description", style: TextStyle(),),
                  Text(data["description"] ?? "", style: TextStyle(),),

                  Text("Poem", style: TextStyle(),),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(data["poem"] ?? "", style: TextStyle(),),
                  ),

                  if((data["video"] ?? "").toString().isNotEmpty)
                  Text("video", style: TextStyle(),),
                  SelectableText(data["video"], style: TextStyle(color: Colors.blue),),

                  Text("Tags", style: TextStyle(),),
                  Wrap(
                    spacing: 8,
                    children: (
                      data["tags"] ?? ""
                    ).toString().split(",").where((tag) => tag.trim().isNotEmpty).map(
                      (tag) => Chip(label: Text(tag.trim()),)
                    ).toList()
                  ),

                  Text("Uploaded: $uploadDate", style: TextStyle(color: Colors.grey),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}