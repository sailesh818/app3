import 'package:flutter/material.dart';

class OfflinePoemDetail extends StatefulWidget {
  final Map poem;

  const OfflinePoemDetail({super.key, required this.poem});

  @override
  State<OfflinePoemDetail> createState() => _OfflinePoemDetailState();
}

class _OfflinePoemDetailState extends State<OfflinePoemDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.poem["title"]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.poem["imageUrl"],
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.poem["title"], style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                  SizedBox(height: 8,),
                  Text(
                    "By ${widget.poem["author"]}", style: TextStyle(fontSize: 18),
                  ),

                  SizedBox(height: 16,),
                  Text(widget.poem["description"], style: TextStyle(fontSize: 16),),

                  SizedBox(height: 16),
                  Text(widget.poem["poem"], style: TextStyle(fontSize: 20, height: 1.8),),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}