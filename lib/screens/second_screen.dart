import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';

import 'package:share_plus/share_plus.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Future<void> _createAndShareExcel() async {
    // Excelファイルを作成
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    sheetObject.appendRow([
      TextCellValue('Name'),
      TextCellValue('Age'),
      TextCellValue('Occupation')
    ]);

    sheetObject.appendRow([
      TextCellValue('Alice'),
      TextCellValue('30'),
      TextCellValue('Engineer')
    ]);

    sheetObject.appendRow(
        [TextCellValue('Bob'), TextCellValue('24'), TextCellValue('Designer')]);

    List<int>? excelData = excel.encode();
    final Uint8List encoded = Uint8List.fromList(excelData!);

    final xfile = XFile.fromData(
      encoded,
      mimeType:
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      name: 'sample.xlsx',
    );

    await Share.shareXFiles([xfile], text: 'Check out this Excel file!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excel & Share Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _createAndShareExcel,
          child: const Text('Create & Share Excel'),
        ),
      ),
    );
  }
}
