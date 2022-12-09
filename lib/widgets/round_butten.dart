import 'package:flutter/material.dart';
class RoundButten extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButten({Key? key,
    required this.title,
    required this.onTap,
    this.loading=false,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width/1.1,
        height: MediaQuery.of(context).size.height/15,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: loading? const CircularProgressIndicator(strokeWidth: 4,color: Colors.white,): Text(title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
        ),
      ),
    );
  }
}
