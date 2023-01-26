import 'package:flutter/material.dart';
import 'package:pdf_app/screen/pdf_screen.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp()); 
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF',
      initialRoute: PDFScreen.id,
      routes: {
        PDFScreen.id: (context) => PDFScreen(),
      },
      
    );
  }
}
