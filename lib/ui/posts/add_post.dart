import 'package:firebase/ui/auth/pdf_screen.dart';
import 'package:firebase/ui/auth/upload_images_screen.dart';
import 'package:firebase/ui/firestore/firestore_list_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_butten.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  final postController =TextEditingController();
  bool loading = false ;
  final databaseRef = FirebaseDatabase.instance.ref('NewData');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),

            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: const InputDecoration(
                  hintText: 'What is in your mind?' ,
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButten(
                title: 'Add',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true ;
                  });


                  String id  = DateTime.now().millisecondsSinceEpoch.toString();
                  databaseRef.child(id).set({
                    'title' : postController.text.toString() ,
                    'id' : id,
                  }).then((value){
                    Utilities().toastMessage('Post added');
                    setState(() {
                      loading = false ;
                    });
                  }).onError((error, stackTrace){
                    Utilities().toastMessage(error.toString());
                    setState(() {
                      loading = false ;
                    });
                  });
                }),



            const SizedBox(height: 50,),
            RoundButten(
                title: 'FireStore',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true ;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const FirestoreListScreen()));
                  });

                }),
            const SizedBox(height: 50,),
            RoundButten(
                title: 'Upload Images',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true ;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const UploadImageScreen()));
                  });

                }),
            const SizedBox(height: 50,),
            RoundButten(
                title: 'Upload PDF',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true ;
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context)=>const PdfScreen()));
                  });

                }),
          ],
        ),
      ),
    );
  }
}
