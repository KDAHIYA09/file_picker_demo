import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OpenMultipleFile extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;

  const OpenMultipleFile({
    Key? key,
    required this.files,
    required this.onOpenedFile
  }) : super(key: key);

  @override
  State<OpenMultipleFile> createState() => _OpenMultipleFileState();
}

class _OpenMultipleFileState extends State<OpenMultipleFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Open Mutiple Files'),
      ),
      body: Center(
        child: GridView.builder(
          padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8),
            itemCount: widget.files.length,
            itemBuilder: (context, index){
            final file = widget.files[index];
            return buildFile(file);
            }
        ),
      ),
    );
  }

  Widget buildFile(PlatformFile file){
    final kb = file.size / 1024 ;
    final mb = kb/1024 ;
    final fileSize = mb >= 1 ? '${mb.toStringAsFixed(2)} MB ' : '${kb.toString()} Kb';
    final extension = file.extension ?? 'none';


    return InkWell(
      onTap: (){
        widget.onOpenedFile(file);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$extension',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              file.name,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              fileSize,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black
              ),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

}
