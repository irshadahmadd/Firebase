import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase/ui/auth/uploadpdf.dart';
import 'package:firebase/ui/mypdf.dart';
import 'package:firebase/widgets/round_butten.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class PdfScreen extends StatefulWidget {
  const PdfScreen({Key? key}) : super(key: key);

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {

  String? url;

  File? file;
FilePicker? picker;

  getFile()async
  {
    print('starting');
    final value= await FilePicker.platform.pickFiles();
    if(value!=null)
      {
        setState(() {
          file=File(value.files.single.path.toString());
          log(file.toString());
        });
      }
    print(file.toString());

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Upload and view pdf"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
  RoundButten(title: 'Upload PDF', onTap: (){
    getFile();
          // Navigator.push(context, MaterialPageRoute(builder: (context)
    // =>const UploadPdf()));
  }),
            const SizedBox(height: 50,),

          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)
            =>MyPdf(pdf: url.toString(),)));
          }, child: Text("view"))



          // Container(
          //   child: SfPdfViewer.network("https://firebasestorage.googleapis.com/v0/b/fir-one-a2876.appspot.com/o/pdf%2F2022-12-06%2016%3A40%3A45.215250?alt=media&token=540b5d6f-f5e6-4209-b119-a3900e9aa54b")
          //     // child: SfPdfViewer.network(
          //     //     'https://cdn.syncfusion.com/content/PDFViewer/encrypted.pdf',
          //     //     password: 'syncfusion')));
          // )
      ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()async
        {
          final databse=await FirebaseStorage.instance.ref().child
            ('pdf/${DateTime.now()}').putFile(File(file!.path));


           url=await databse.ref.getDownloadURL();


          print("url:$url");


        },
        child: Icon(Icons.add),
      ),
    );
  }
}
