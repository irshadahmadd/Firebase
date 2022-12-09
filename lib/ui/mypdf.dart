
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class MyPdf extends StatefulWidget {
  String? pdf;
  MyPdf({Key? key,this.pdf}) : super(key: key);

  @override
  State<MyPdf> createState() => _MyPdfState();
}

class _MyPdfState extends State<MyPdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDf"),),
      body: SfPdfViewer.network(widget.pdf.toString(),
      ),
    );
  }
}
