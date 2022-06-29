import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Uint8List? exportedImage;

  SignatureController controller = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Signature"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Signature(
              controller: controller,
              width: 350,
              height: 200,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () async{
                      exportedImage = await controller.toPngBytes();
                      //API goes in here....
                      setState(() {});
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side:
                                        const BorderSide(color: Colors.red)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.clear();
                    },
                    child: Text(
                      "Clear",
                      style: const TextStyle(fontSize: 20),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red)))),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (exportedImage != null) Image.memory(exportedImage!)
          ],
        ),
      ),
    );
  }
}
