import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/login/widgets/custom_button.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final descriptionController = TextEditingController();
  final poemController = TextEditingController();
  final imageController = TextEditingController();
  final videoController = TextEditingController();
  final categoryController = TextEditingController();
  final tagsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;


  Future<void> uploadpoem() async {
    if(!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try{

      await FirebaseFirestore.instance.collection("poems").add({
        "name": nameController.text.trim(),
        "title": titleController.text.trim(),
        "author": authorController.text.trim(),
        "description": descriptionController.text.trim(),
        "poem": poemController.text.trim(),
        "image": imageController.text.trim(),
        "video": videoController.text.trim(),
        "category": categoryController.text.trim(),
        "tags": tagsController.text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Poem uploaded successfully"))
      );

      nameController.clear();
      titleController.clear();
      authorController.clear();
      descriptionController.clear();
      poemController.clear();
      imageController.clear();
      videoController.clear();
      categoryController.clear();
      tagsController.clear();
      
    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget buildField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    bool requiredField = true
  }){

    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: (value) {
          
          if(!requiredField) return null;

          if(value == null || value.trim().isEmpty){
            return "Required";
          }

          return null;
        },

        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          )
        ),
      ),
    );

  }

  @override
  void dispose() {
    nameController.dispose();
    titleController.dispose();
    authorController.dispose();
    descriptionController.dispose();
    poemController.dispose();
    imageController.dispose();
    videoController.dispose();
    categoryController.dispose();
    tagsController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload Poem"
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildField(
                label: "Poem Name", 
                controller: nameController,
              ),

              buildField(
                label: "Title", 
                controller: titleController,
              ),

              buildField(
                label: "Author Name", 
                controller: authorController,
              ),

              buildField(
                label: "Description", 
                controller: descriptionController,
                maxLines: 3,
              ),

              buildField(
                label: "Poem", 
                controller: poemController,
                maxLines: 8,
              ),

              buildField(
                label: "Image URL", 
                controller: imageController,
              ),

              buildField(
                label: "Video URL(optional)", 
                controller: videoController,
                requiredField: false
              ),

              buildField(
                label: "Category", 
                controller: categoryController,
              ),

              buildField(
                label: "Tags", 
                controller: tagsController,
              ),

              SizedBox(
                height: 20,
              ),

              CustomButton(
                onPressed: uploadpoem,
                loading: isLoading, 
                text: "Submit"
              )

            ],
          )
        ),
      ),
    );
  }
}