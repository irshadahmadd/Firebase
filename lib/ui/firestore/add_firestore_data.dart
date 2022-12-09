import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/ui/firestore/firestore_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_butten.dart';
class AddFireStoreDataScreen extends StatefulWidget {
  const AddFireStoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFireStoreDataScreen> createState() => _AddFireStoreDataScreenState();
}

class _AddFireStoreDataScreenState extends State<AddFireStoreDataScreen> {
  final postController =TextEditingController();
  bool loading = false ;
  final fireStoreRef=FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Firestore Data"),
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
                title: 'Add data',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true ;
                  });
                  String id=DateTime.now().millisecondsSinceEpoch.toString();
                  fireStoreRef.doc(id).set({
                    "title":postController.text.toString(),
                    'id':id,
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    Utilities().toastMessage("Post Added") ;

                  }).onError((error, stackTrace){
                    setState(() {
                      loading = false ;
                    });
                    Utilities().toastMessage(error.toString());
                  });
                }),

            const SizedBox(height: 50,),
            RoundButten(
                title: 'View Added data',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true ;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const FirestoreListScreen()));
                }),

          ],
        ),
      ),
    );
  }
}
