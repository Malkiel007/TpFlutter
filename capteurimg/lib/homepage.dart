import 'dart:io';
import 'package:flutter/material.dart';
import 'package:capteurimg/process_page.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String result = "";
  File? image;
  late ImagePicker imagePicker;
  late TextRecognizer textRecognizer;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    textRecognizer = GoogleMlKit.vision.textRecognizer();
  }

  Future<void> GalleryImage() async {
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      image = File(xFile.path);

      setState(() {
        image;
        // Faire l'étiquetage des images_ extraire l'image de l'image
        ImageExtrait();
      });
    }
  }

  Future<void> CaptureImage() async {
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (xFile != null) {
      image = File(xFile.path);

      setState(() {
        image;
        // Faire l'étiquetage des images_ extraire l'image de l'image
        ImageExtrait();
      });
    }
  }

  Future<void> ImageExtrait() async {
    try {
      final inputImage = InputImage.fromFilePath(image!.path);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      result = recognizedText.text;

      
      // Détecter la langue du système
      String systemLocale = Platform.localeName.split('_').first;

      // Traduire le texte extrait dans la langue du système
      final translator = GoogleTranslator();
      var translation = await translator.translate(result, to: systemLocale);

      setState(() {
        result = translation.text!;
      });

      navigateToProcessPage(context, image!, result);
    } catch (e) {
      print("Erreur lors de la reconnaissance de texte : $e");
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 7, 8, 22), // Fond d'écran noir
      appBar: AppBar(
        title: Text('Application de traitement d\'image'),
        backgroundColor: Color.fromARGB(255, 7, 8, 22), // Fond d'écran noir
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: CaptureImage,
                  icon: Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: Colors.white70,),
                ),
                IconButton(
                  onPressed: GalleryImage,
                  icon: Icon(
                    Icons.photo_library,
                    size: 40,
                    color: Colors.white70,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void navigateToProcessPage(BuildContext context, File image, String result) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProcessPage(image: image, extractedText: result),
    ),
  );
}

                             
}
