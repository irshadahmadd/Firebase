import 'package:firebase/ui/auth/login_screen.dart';
import 'package:firebase/ui/posts/add_post.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);
  @override
  State<PostScreen> createState() => _PostScreenState();
}
class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance ;
  final ref = FirebaseDatabase.instance.ref('NewData');
  final searchController=TextEditingController();
  final editController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            }).onError((error, stackTrace){
              Utilities().toastMessage(error.toString());
            });
          }, icon: const Icon(Icons.logout_outlined),),
          const SizedBox(width: 10,)
        ],
      ),
      body: Column(
        children: [
             const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 20),
                hintText: "Search",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                        color: Colors.deepPurple, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.blueAccent,
                    )),
                disabledBorder: InputBorder.none,
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index){
                  final title=snapshot.child('title').value.toString();
                  if(searchController.text.isEmpty){
                    return  ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                          color: Colors.white,
                          elevation: 4,
                          padding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2))),
                          icon: const Icon(Icons.more_vert,),
                          itemBuilder: (context) =>
                          [
                            PopupMenuItem(
                              value: 1,
                              child: PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(title,snapshot.child('id').value.toString());
                                  },
                                  leading: const Icon(Icons.edit),
                                  title: const Text('Edit'),
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  ref.child(snapshot.child('id').value
                                      .toString()).remove();
                                },
                                leading: const Icon(Icons.delete_outline),
                                title: const Text('Delete'),
                              ),
                            ),
                          ]),
                    );
                  } else if(title.toLowerCase().contains(searchController
                    .text.toLowerCase()
                      .toString())){
                    return  ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      // trailing:  PopupMenuButton(
                      //     color: Colors.white,
                      //     elevation: 4,
                      //     padding: EdgeInsets.zero,
                      //     shape: const RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.all(Radius.circular(2))),
                      //     icon: const Icon(Icons.more_vert,),
                      //     itemBuilder: (context) => [
                      //       PopupMenuItem(
                      //         value: 1,
                      //         child: PopupMenuItem(
                      //           value: 2,
                      //           child:  ListTile(
                      //             onTap: (){
                      //               Navigator.pop(context);
                      //
                      //               ref.child(snapshot.child('id').value.toString()).update(
                      //                   {
                      //                     'title' : 'nice world'
                      //                   }).then((value){
                      //
                      //               }).onError((error, stackTrace){
                      //                 Utilities().toastMessage(error.toString());
                      //               });
                      //
                      //             },
                      //             leading: const Icon(Icons.edit),
                      //             title: const Text('Edit'),
                      //           ),
                      //         ),
                      //       ),
                      //       PopupMenuItem(
                      //         value: 2,
                      //         child:  ListTile(
                      //           onTap: (){
                      //             Navigator.pop(context);
                      //
                      //             // ref.child(snapshot.child('id').value.toString()).update(
                      //             //     {
                      //             //       'title' : 'hello world'
                      //             //     }).then((value){
                      //             //
                      //             // }).onError((error, stackTrace){
                      //             //   Utils().toastMessage(error.toString());
                      //             // });
                      //             ref.child(snapshot.child('id').value.toString()).remove().then((value){
                      //
                      //             }).onError((error, stackTrace){
                      //               Utilities().toastMessage(error.toString());
                      //             });
                      //           },
                      //           leading: const Icon(Icons.delete_outline),
                      //           title: const Text('Delete'),
                      //         ),
                      //       ),
                      //     ]),
                    );
                  }
                  else{
                    return Container();
                  }

                }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPostScreen()));
        } ,
        child: const Icon(Icons.add),
      ),
    );

  }
  Future<void> showMyDialog(String title,String id) async{
    editController.text=title;
    return showDialog(
        context: context, builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Update"),
            content: Container(
              child: TextFormField(
                controller: editController,
                decoration: const InputDecoration(
                  hintText: "edit",
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              },
                  child: const Text("Cancel")),
              TextButton(onPressed: (){
                Navigator.pop(context);
                ref.child(id).update({
                  'title':editController.text.toString(),
                }).then((value){
                  Utilities().toastMessage("Post Uptdated");
                }).onError((error, stackTrace){
                 Utilities().toastMessage(error.toString());
                });
              },
                  child: const Text("update")),
            ],
          );
    });
  }

}
