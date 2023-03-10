import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_app/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

class PDFScreen extends StatefulWidget {
  static const String id = 'pdf_screen';
  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  pw.Document pdf;
  PdfImage imagen;

  Uint8List archivoPdf;

  double sizeIcon1 = 65;
  double sizeIcon2 = 30;
  double sizeIcon3 = 30;

  

  @override
  void initState() {
    initPDF();
  }

  Future<void> initPDF() async {
    
    archivoPdf = await generarPdf1();
  }

  void iconoSeleccionado(int numero) {
    if (numero == 1) {
      sizeIcon1 = 65;
      sizeIcon2 = 30;
      sizeIcon3 = 30;
    } else if (numero == 2) {
      sizeIcon1 = 30;
      sizeIcon2 = 65;
      sizeIcon3 = 30;
    } else {
      sizeIcon1 = 30;
      sizeIcon2 = 30;
      sizeIcon3 = 65;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 157, 194, 243),
      appBar: AppBar(
        title: Text('PDF'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 70,
                width: MediaQuery.of(context).size.width - 130,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 25,
                  ),
                  child: PdfPreview(
                    build: (format) => archivoPdf,
                    useActions: false,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        archivoPdf = await generarPdf1();
                        setState(
                          () {
                            iconoSeleccionado(1);
                            archivoPdf = archivoPdf;
                          },
                        );
                      },
                      child: Icon(
                        Icons.picture_as_pdf,
                        size: sizeIcon1,
                        color: Color.fromARGB(255, 9, 19, 73),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        archivoPdf = await generarPdf2();
                        setState(
                          () {
                            iconoSeleccionado(2);
                            archivoPdf = archivoPdf;
                          },
                        );
                      },
                      child: Icon(
                        Icons.picture_as_pdf,
                        size: sizeIcon2,
                        color: Color.fromARGB(255, 30, 96, 112),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        archivoPdf = await generarPdf3();
                        setState(
                          () {
                            iconoSeleccionado(3);
                            archivoPdf = archivoPdf;
                          },
                        );
                      },
                      child: Icon(
                        Icons.picture_as_pdf,
                        size: sizeIcon3,
                        color: Color.fromARGB(255, 1, 19, 24),
                      ),
                    ),
                    
              GestureDetector(
                onTap: () async {
                  await Printing.sharePdf(
                      bytes: archivoPdf, filename: 'Curriculum.pdf');
                },
                child: Icon(
                  Icons.download_outlined,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 70,
                ),
              ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

 
  Future<Uint8List> generarPdf1() async {
    pdf = pw.Document();

    imagen = PdfImage.file(
      pdf.document,
      bytes: (await rootBundle.load(kImagePath)).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a5,
        margin: pw.EdgeInsets.zero,
        build: (context) => [
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: pw.Center(
              child: pw.Text(
                'Aucancela Tamay Jhoana del Rocio', 
                style: pw.TextStyle(
                  fontSize: 24,
                  color: PdfColors.black,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
          ),
          pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
               pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Image(
                  imagen,
                  //height: 70,
                  width: 150,
                ),
                pw.Text(
                '\nDescripci??n',
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.blueGrey900,
                ),
                textAlign: pw.TextAlign.justify,
                ),
                pw.Text(
                '\nSoy un profesional que esta en \nconstante crecimiento personal \ny profesional. Tengo experiencia \nen liderar y organizar grupos de \ntrabajo. Me presto ayudar aplicando\nmis conocimientos para cumplir \ncon los objetivos propuestos',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.justify,
                ),

                pw.Text(
                '\nIdiomas',
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.blueGrey900,
                ),
                textAlign: pw.TextAlign.justify,
                ),
                pw.Text(
                '\n* Espa??ol (Nativo)',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.justify,
                ),

                pw.Text(
                '\n* Ingl??s          ',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.justify
                ),
                ]
               ),
                
              
              pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Text(
                'Formaci??n Acad??mica',
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.blueGrey900,
                ),
                textAlign: pw.TextAlign.justify,
                ),
                pw.Text(
                '\nEscuela Polit??cnica Nacional, [Quito, Pichincha]\nTecnolog??a Superior en Desarrollo de Software',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.justify,
                ),

                pw.Text(
                '\nU.E. Jos?? Mar??a V??laz, [Quito, Pichincha]\nBachiller T??cnico de Aplicaciones Inform??ticas\n\n',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.justify,
                ),

                pw.Text(
                '\nExperiencia Profesional',
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.blueGrey900,
                ),
                textAlign: pw.TextAlign.justify,
                ),
                pw.Text(
                '\nBanco Central del Ecuador                Infraestructura\n\n',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.justify,
                ),

                pw.Text(
                '\nHabilidades y Aptitudes',
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.blueGrey900,
                ),
                textAlign: pw.TextAlign.justify,
                ),
                pw.Text(
                '\n* Responsabilidad                                       \n* Eficiencia                                            \n* Liderazgo                                             \n\n\n\n\n',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.justify,
                ),

                pw.Text(
                'Manejo de lenguajes',
                style: pw.TextStyle(
                  fontSize: 14,
                ),
                textAlign: pw.TextAlign.justify,
                ),
                pw.Text(
                '\nLorem Ipsum is simply \nLorem Ipsum is simply \nLorem Ipsum is simply \nLorem Ipsum is simply\n Lorem Ipsum is simply \nLorem Ipsum is simply',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.justify,
                ),

              ],
            ),
              ],
            ),
            ],
          ),
        

        ],
      ),
    );
    return pdf.save();
  }


//////////////////////////////////////////////
 Future<Uint8List> generarPdf2() async {
    pdf = pw.Document();

    imagen = PdfImage.file(
      pdf.document,
      bytes: (await rootBundle.load(kGoogleImagePath)).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (context) => [
          pw.Row(
            children: [
              pw.Expanded(
                flex: 1,
                child: pw.Column(children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 10),
                  ),
                  pw.Center(
                    child:  pw.Image(
                        imagen,
                        height: 70,
                        width: 140,
                      ),
                  ),
                  pw.SizedBox(
                    height: 20,
                  ),
                  
                  pw.Text(
                    '+593-98-319-1978\nmanuelauqui@outlook.com\nQuito - Ecuador\ngithub.com/ManuEly19\nlinkedn.com/ManuEly19',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.grey800),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.Text(
                    'DATOS GENERALES',
                    style: pw.TextStyle(fontSize: 14, color: PdfColors.grey800),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.Text(
                    'Soy un profesional que esta en constante crecimiento personal y profesional. Tengo experiencia en liderar y organizar grupos de trabajo. Me gusta ser asertivos con las personas al mi al redor y me presto ayudar aplicando mis conocimientos para cumplir con los objetivos propuestos. Quiero aportar al desarrollo y crecimiento de mi pa??s, sin dejar de lado los valores ??ticos que me inculcado. ',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.grey800),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.Text(
                    'IDIOMAS',
                    style: pw.TextStyle(fontSize: 14, color: PdfColors.grey800),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.Text(
                    'Espa??ol ??  Nativo\nIngl??s ??  Avanzado Nivel C2 2022',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.grey800),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.Text(
                    'COMPETENCIAS',
                    style: pw.TextStyle(fontSize: 14, color: PdfColors.grey800),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.Text(
                    'Desarrollo de Frontend\nDesarrollo de Backend\nDise??o Web',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.grey800),
                    textAlign: pw.TextAlign.left,
                  ),
                ]),
              ),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    color: PdfColors.grey900,
                    child: pw.Column(children: [
                      pw.ListView(
                        padding: pw.EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        children: [
                          pw.Container(
                              height: 50,
                              color: PdfColors.white,
                              child: pw.Column(children: [
                                pw.Center(
                                  child: pw.Text(
                                    'Manuel Auqui',
                                    style: pw.TextStyle(
                                      fontSize: 40,
                                      color: PdfColors.pink900,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                                pw.Text(
                                  'DESARROLLADOR DE SOFTWARE',
                                  style: pw.TextStyle(
                                      fontSize: 14, color: PdfColors.grey800),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ])),
                          pw.Container(
                            height: 25,
                            color: PdfColors.pink900,
                            child: pw.Center(
                                child: pw.Text('FORMACI??N ACADEMICA',
                                    style: pw.TextStyle(
                                        fontSize: 14, color: PdfColors.white))),
                          ),
                          pw.Text(
                            '2022\nTecnolog??a Superior en Desarrollo de Software\nEscuela Polit??cnica Nacional',
                            style: pw.TextStyle(
                                fontSize: 12, color: PdfColors.white),
                            textAlign: pw.TextAlign.left,
                          ),
                          pw.Text(
                            '2019\nBachillerato T??cnico de servicios de Aplicaciones Inform??ticas\nUnidad Educativa Fiscal "Arturo Borja"',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                            textAlign: pw.TextAlign.left,
                          ),
                          pw.Container(
                            height: 25,
                            color: PdfColors.pink900,
                            child: pw.Center(
                                child: pw.Text('EXPERIENCIA PROFESIONAL',
                                    style: pw.TextStyle(
                                        fontSize: 14, color: PdfColors.white))),
                          ),
                          pw.Text(
                            'Escuela de Formaci??n de Tecn??logos (ESFOT)\nPASANTE',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                            textAlign: pw.TextAlign.left,
                          ),
                          pw.Text(
                            '- Colaboraci??n en el desarrollo de la pagina web.\n- Administraci??n y gesti??n de contenido informativos de la pagina web.\n- Actualizaci??n de componentes visuales de la pagina web.',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                            textAlign: pw.TextAlign.left,
                          ),
                          pw.Container(
                            height: 25,
                            color: PdfColors.pink900,
                            child: pw.Center(
                                child: pw.Text('APTITUDES Y HABILIDADES',
                                    style: pw.TextStyle(
                                        fontSize: 14, color: PdfColors.white))),
                          ),
                          pw.Text(
                            '- Persona excelente y comprometido con su trabajo, obligaciones y responsabilidades.\n- Gran capacidad para el trabajo en equipo y desarrollo de ambientes favorables. Persona proactiva, asertiva y con iniciativa.\n- Actitud constante hacia el aprendizaje, y b??squeda del desarrollo profesional y personal.',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                            textAlign: pw.TextAlign.left,
                          ),
                          pw.Container(
                            height: 25,
                            color: PdfColors.pink900,
                            child: pw.Center(
                                child: pw.Text('INTERESES',
                                    style: pw.TextStyle(
                                        fontSize: 14, color: PdfColors.white))),
                          ),
                          pw.Text(
                            'Tengo diversos interesen en mi vida las cuales he estado aprendiendo constantemente. Me gusta entonar la guitarra lo llevo haciendo desde los 15 a??os y todo lo que aprendido en ella ha sido casi totalmente autodidacta. Adem??s, he aprendido armar cubos de Rubik, me gusta conducir y viajar.',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                            textAlign: pw.TextAlign.left,
                          ),
                          pw.Container(
                            height: 25,
                            color: PdfColors.pink900,
                            child: pw.Center(
                                child: pw.Text('SOFTWARE SKILLS',
                                    style: pw.TextStyle(
                                        fontSize: 14, color: PdfColors.white))),
                          ),
                          pw.Text(
                            '- C/C++\n- Python\n- PHP\n- HTML\n- CSS\n- JavaScript\n- SQL Serve\n- MySQL\n- JAVA\n- Ofimatica',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                            textAlign: pw.TextAlign.left,
                          ),
                        ],
                      )
                    ]),
                  )),
            ],
          )
        ],
      ),
    );
    return pdf.save();
  }

   Future<Uint8List> generarPdf3() async {
    pdf = pw.Document();

    imagen = PdfImage.file(
      pdf.document,
      bytes: (await rootBundle.load(kGoogleImagePath)).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (context) => [
          pw.Row(
            children: [
              pw.Expanded(
                flex: 1,
                child: pw.Column(children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 10),
                  ),
                  pw.Center(
                    child:  pw.Image(
                      imagen,
                      //height: 70,
                      width: 150,
                    ),
                  ),
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.Text(
                    '+593-98-319-1978\nmanuelauqui@outlook.com\nQuito - Ecuador\ngithub.com/ManuEly19\nlinkedn.com/ManuEly19',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.grey800),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.Text(
                    'DATOS GENERALES',
                    style: pw.TextStyle(fontSize: 14, color: PdfColors.grey800),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.Text(
                    'Soy un profesional que esta en constante crecimiento personal y profesional. Tengo experiencia en liderar y organizar grupos de trabajo. Me gusta ser asertivos con las personas al mi al redor y me presto ayudar aplicando mis conocimientos para cumplir con los objetivos propuestos. Quiero aportar al desarrollo y crecimiento de mi pa??s, sin dejar de lado los valores ??ticos que me inculcado. ',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.grey800),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.Text(
                    'IDIOMAS',
                    style: pw.TextStyle(fontSize: 14, color: PdfColors.grey800),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.Text(
                    'Espa??ol ??  Nativo\nIngl??s ??  Avanzado Nivel C2 2022',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.grey800),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.Text(
                    'COMPETENCIAS',
                    style: pw.TextStyle(fontSize: 14, color: PdfColors.grey800),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.Text(
                    'Desarrollo de Frontend\nDesarrollo de Backend\nDise??o Web',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.grey800),
                    textAlign: pw.TextAlign.left,
                  ),
                ]),
              ),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    color: PdfColors.grey900,
                    child: pw.Column(children: [
                      pw.ListView(
                        padding: pw.EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        children: [
                          pw.Container(
                              height: 50,
                              color: PdfColors.white,
                              child: pw.Column(children: [
                                pw.Center(
                                  child: pw.Text(
                                    'Manuel Auqui 2',
                                    style: pw.TextStyle(
                                      fontSize: 40,
                                      color: PdfColors.pink900,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                                pw.Text(
                                  'DESARROLLADOR DE SOFTWARE',
                                  style: pw.TextStyle(
                                      fontSize: 14, color: PdfColors.grey800),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ])),
                          pw.Container(
                            height: 25,
                            color: PdfColors.pink900,
                            child: pw.Center(
                                child: pw.Text('FORMACI??N ACADEMICA',
                                    style: pw.TextStyle(
                                        fontSize: 14, color: PdfColors.white))),
                          ),
                          pw.Text(
                            '2022\nTecnolog??a Superior en Desarrollo de Software\nEscuela Polit??cnica Nacional',
                            style: pw.TextStyle(
                                fontSize: 12, color: PdfColors.white),
                            textAlign: pw.TextAlign.left,
                          ),
                          pw.Text(
                            '2019\nBachillerato T??cnico de servicios de Aplicaciones Inform??ticas\nUnidad Educativa Fiscal "Arturo Borja"',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                            textAlign: pw.TextAlign.left,
                          ),
                          pw.Container(
                            height: 25,
                            color: PdfColors.pink900,
                            child: pw.Center(
                                child: pw.Text('EXPERIENCIA PROFESIONAL',
                                    style: pw.TextStyle(
                                        fontSize: 14, color: PdfColors.white))),
                          ),
                          pw.Text(
                            'Escuela de Formaci??n de Tecn??logos (ESFOT)\nPASANTE',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                            textAlign: pw.TextAlign.left,
                          ),
                          pw.Text(
                            '- Colaboraci??n en el desarrollo de la pagina web.\n- Administraci??n y gesti??n de contenido informativos de la pagina web.\n- Actualizaci??n de componentes visuales de la pagina web.',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                            textAlign: pw.TextAlign.left,
                          ),
                          pw.Container(
                            height: 25,
                            color: PdfColors.pink900,
                            child: pw.Center(
                                child: pw.Text('APTITUDES Y HABILIDADES',
                                    style: pw.TextStyle(
                                        fontSize: 14, color: PdfColors.white))),
                          ),
                          pw.Text(
                            '- Persona excelente y comprometido con su trabajo, obligaciones y responsabilidades.\n- Gran capacidad para el trabajo en equipo y desarrollo de ambientes favorables. Persona proactiva, asertiva y con iniciativa.\n- Actitud constante hacia el aprendizaje, y b??squeda del desarrollo profesional y personal.',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                            textAlign: pw.TextAlign.left,
                          ),
                          pw.Container(
                            height: 25,
                            color: PdfColors.pink900,
                            child: pw.Center(
                                child: pw.Text('INTERESES',
                                    style: pw.TextStyle(
                                        fontSize: 14, color: PdfColors.white))),
                          ),
                          pw.Text(
                            'Tengo diversos interesen en mi vida las cuales he estado aprendiendo constantemente. Me gusta entonar la guitarra lo llevo haciendo desde los 15 a??os y todo lo que aprendido en ella ha sido casi totalmente autodidacta. Adem??s, he aprendido armar cubos de Rubik, me gusta conducir y viajar.',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                            textAlign: pw.TextAlign.left,
                          ),
                          pw.Container(
                            height: 25,
                            color: PdfColors.pink900,
                            child: pw.Center(
                                child: pw.Text('SOFTWARE SKILLS',
                                    style: pw.TextStyle(
                                        fontSize: 14, color: PdfColors.white))),
                          ),
                          pw.Text(
                            '- C/C++\n- Python\n- PHP\n- HTML\n- CSS\n- JavaScript\n- SQL Serve\n- MySQL\n- JAVA\n- Ofimatica',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                            textAlign: pw.TextAlign.left,
                          ),
                        ],
                      )
                    ]),
                  )),
            ],
          )
        ],
      ),
    );
    return pdf.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Curriculm',
            style: pw.TextStyle(
              fontSize: 35,
              color: PdfColors.blue,
            ),
          ),
          pw.SizedBox(
            height: 4,
          ),
          pw.Container(
            height: 1,
            color: PdfColors.green,
          ),
          pw.SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: pw.TextStyle(
              fontSize: 20,
              color: PdfColors.grey,
            ),
            textAlign: pw.TextAlign.right,
          ),
          pw.SizedBox(
            height: 4,
          ),
          pw.Container(
            height: 1,
            color: PdfColors.green,
          ),
        ],
      ),
    );
  }

}
