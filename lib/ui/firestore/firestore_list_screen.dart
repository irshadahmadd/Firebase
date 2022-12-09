import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/ui/firestore/add_firestore_data.dart';
import 'package:firebase/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({Key? key}) : super(key: key);

  @override
  State<FirestoreListScreen> createState() => _FirestoreListScreenState();
}

class _FirestoreListScreenState extends State<FirestoreListScreen> {
  final auth = FirebaseAuth.instance ;
  final editController=TextEditingController();
  final fireStore=FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref=FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("You Enter this data"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50,),
            StreamBuilder<QuerySnapshot>(
              stream: fireStore,
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>
                snapshot){
                  if(snapshot.connectionState== ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if(snapshot.hasError) {
                    return const Text("Error Occur");
                  }
                  return Expanded(
                      child:  ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                            return  ListTile(
                        onTap: (){
                          ref.doc(snapshot.data!.docs[index]['id'].toString()
                          ).update({
                           'title':'asif taj subscribe',
                          }).then((value) =>{
                            Utilities().toastMessage('Updated'),
                          }).onError((error, stackTrace) =>{
                            Utilities().toastMessage(error.toString()),
                          });
                          // ref.doc(snapshot.data!.docs[index]['id'].toString()
                          // ).delete();
                        },
                              title: Text(snapshot.data!.docs[index]['title'].toString()),
                              subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                            );
                          }
                      )
                  );
                }
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
          const AddFireStoreDataScreen()));
        } ,
        child: const Icon(Icons.add),
      ),
    );
  }
}
