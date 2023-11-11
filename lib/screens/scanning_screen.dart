import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
//import 'package:tflite_flutter/tflite_flutter.dart';

class scanning_screen extends StatefulWidget {
  const scanning_screen({super.key});

  @override
  State<scanning_screen> createState() => _scanning_screenState();
}

class _scanning_screenState extends State<scanning_screen> {
  late bool _loading = true;
  late File _image;
  final imagepicker = ImagePicker();
  List _predictions = [];

  @override
  void initState(){
    super.initState();
    loadmodel();
  }

  loadmodel() async{
    final model1 = await Tflite.loadModel(model: 'assets/CNNmodel.tflite',
        labels: 'assets/leaf-detection.txt');
    final model2 = await Tflite.loadModel(model: 'assets/Disease.tflite',
        labels: 'assets/Disease.txt');
    /*await Tflite.loadModel(model: 'assets/CNNmodel.tflite',
    labels: 'assets/leaf-detection.txt');*/
    useGpuDelegate: false;
  }

  detect_image(File image) async{
    await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _predictions = _predictions;
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  _loadingimage_gallery()async{
    var image = await imagepicker.pickImage(source: ImageSource.gallery);
    if(image == null){
      return null;
    }
    else{
      _image = File(image.path);
    }
    detect_image(_image);
  }
  _loadingimage_camerag()async{
    var image = await imagepicker.pickImage(source: ImageSource.camera);
    if(image == null){
      return null;
    }
    else{
      _image = File(image.path);
    }
    detect_image(_image);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Disease Detetction'),
      ),
      body: Container(
          height: h,
          width: w,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width:200,
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/logo1.png',
                    height: 100,
                    width: 100,
                  ),
                ),


                SizedBox(height: 10),
                Container(
                  width: 200,
                  height: 70,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      _loadingimage_camerag();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Text('Camera',
                        style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 200,
                  height: 70,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      _loadingimage_gallery();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Text('Gallery',
                        style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
                _loading==false
                    ? Container(
                  child: Column(
                    children: [Container(
                      height: 200,
                      width: 200,
                      child: Image.file(_image),
                    ),
                      Text(_predictions[0]['label'].toString().substring(2)),
//                    Text('Confidence ' + _predictions[0]['confidence'].toString()),
                    ],
                  ),
                )
                    : Container(),

              ]
          )
      ),
    );
  }
}
