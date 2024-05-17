import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:file_picker_demo/multiple_file.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(

        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.blueGrey,
                child: Text('Pick File'),
                onPressed: (){
                  _pickFiles();
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: MaterialButton(
              height: 50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.blueGrey,
                child: Text('Pick Multiple Files'),
                onPressed: () async{
                  final result = await FilePicker.platform.pickFiles(allowMultiple: true);
                  if(result==null)result;
                  _openFiles(result!.files);
                }),
          )
        ],
      ),
    );
  }

  Future _pickFiles() async{
    final resultFile = await FilePicker.platform.pickFiles();
    if(resultFile==null)return;
    final file = resultFile.files.first;
    savePermanent(file);
    _openFile(file);
  }

  void _openFile(PlatformFile file){
    OpenFile.open(file.path!);
  }
  //we can merge these functions



//to save files permanently
  Future<File> savePermanent(PlatformFile file) async{
    final appStorage = await getApplicationDocumentsDirectory();
    final newPath = File('${appStorage.path}/${file.name}');
    return File(file.path!).copy(newPath.path);
  }

  void _openFiles(List<PlatformFile> files) =>
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  OpenMultipleFile(
                    files: files,
                    onOpenedFile: _openFile,
                  )
          )
      );

}
