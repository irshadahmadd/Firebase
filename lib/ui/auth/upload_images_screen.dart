import 'dart:io';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_butten.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage
      .instance;
  DatabaseReference databaseref = FirebaseDatabase.instance.ref('NewData');
  bool loading = false;

  File? _image;

  Future getimage(ImageSource source) async {
    // ignore: invalid_use_of_visible_for_testing_member
    final image = await ImagePicker.platform.getImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      _image = imageTemporary;
      Navigator.pop(context);
    });
  }

  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Upload Image"),
      ),
      body: Column(
        children: [
          Center(
            child: PopupMenuButton(
              position: PopupMenuPosition.under,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: () => getimage(ImageSource.gallery),
                      child: const Text("Gallery"),
                    ),),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: () => getimage(ImageSource.camera),
                      child: const Text("Camera"),
                    ),),
                  PopupMenuItem(

                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _image = null;
                          Navigator.pop(context);
                        });
                      },
                      child: const Text("Delete"),
                    ),),
                ];
              },
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: _image != null
                    ?
                Image.file(_image!, height: 100, width: 100, fit: BoxFit.cover,)
                    :
                Image.asset("assets/irshad.jpg", fit: BoxFit.cover,),
              ),

            ),
          ),
          const SizedBox(height: 100,),
          RoundButten(title: "Upload Image", loading: loading, onTap: () async {
            setState(() {
              loading = true;
            });
            firebase_storage.Reference ref = firebase_storage.FirebaseStorage
                .instance.ref('/folfername/${DateTime.now()
                .millisecondsSinceEpoch}');
            firebase_storage.UploadTask uploadTask = ref.putFile(
                _image!.absolute);
            await Future.value(uploadTask);
            var newURL =  await ref.getDownloadURL();
            databaseref.child('1').set({
              'id': '1212',
              'title': newURL.toString(),
            }).then((value) => {
            setState(() {
            loading=false;
            }),
              Utilities().toastMessage('Uploaded'),

            }).onError((error, stackTrace) =>{
              setState(() {
                loading=false;
              }),
              Utilities().toastMessage(error.toString()),
            });
          })
        ],
      ),
    );
  }
}
