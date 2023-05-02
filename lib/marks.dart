import 'dart:ffi';
import 'package:xml/xml.dart';

import 'package:flutter/material.dart';

class Marks extends StatefulWidget {
  final int mark;
  const Marks({super.key, required this.mark});

  @override
  State<Marks> createState() => _MarksState();
}

class _MarksState extends State<Marks> {
  late Double marksMean;
  final List<int> markss = List<int>.filled(15, 2);

  double calculateMean(List<int> mark) {
    double mean = 0.0;
    for (int i = 0; i < widget.mark; i++) {
      mean += mark[i];
    }
    mean /= widget.mark;
    return mean;
  }

  final List<Map<String, String>> subjects = [];
  void readXml() async {
    const subjectsInXml = '''<?xml version="1.0" encoding="UTF-8"?>
<Subjects>
    <Subject Name="Mat" id="0"><Name>Mat</Name></Subject>
    <Subject Name="Fiz" id="1"><Name>Fiz</Name></Subject>
    <Subject Name="Inf" id="2"><Name>Inf</Name></Subject>
    <Subject Name="W-f" id="3"><Name>W-f</Name></Subject>
    <Subject Name="Algo" id="4"><Name>Algo</Name></Subject>
    <Subject Name="Kos" id="5"><Name>Kos</Name></Subject>
    <Subject Name="Eng" id="6"><Name>Eng</Name></Subject>
    <Subject Name="His" id="7"><Name>His</Name></Subject>
    <Subject Name="And" id="8"><Name>And</Name></Subject>
    <Subject Name="Flu" id="9"><Name>Flu</Name></Subject>
    <Subject Name="Tter" id="10"><Name>Tter</Name></Subject>
    <Subject Name="Da" id="11"><Name>Da</Name></Subject>
    <Subject Name="Rt" id="12"><Name>Rt</Name></Subject>
    <Subject Name="Sos" id="13"><Name>Sos</Name></Subject>
    <Subject Name="Los" id="14"><Name>Los</Name></Subject>
</Subjects>''';

    final document = XmlDocument.parse(subjectsInXml);
    final elements = document.findAllElements('Subject');
    for (final element in elements) {
      final data = <String, String>{
        'Name': element.getElement('Name')?.text ?? '',
        'Name2': element.getElement('Name')?.text ?? '',
      };
      subjects.add(data);
    }
  }

  @override
  void initState() {
    super.initState();
    readXml();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marks'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context, calculateMean(markss)),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.mark,
              itemBuilder: (context, index) => Align(
                child: Row(
                  children: [
                    Text(subjects[index]['Name']!),
                    Radio(
                      groupValue: markss[index],
                      value: 2,
                      onChanged: (value) {
                        setState(() {
                          markss[index] = value!;
                        });
                      },
                    ),
                    const Text('2'),
                    Radio(
                      groupValue: markss[index],
                      value: 3,
                      onChanged: (value) {
                        setState(() {
                          markss[index] = value!;
                        });
                      },
                    ),
                    const Text('3'),
                    Radio(
                      groupValue: markss[index],
                      value: 4,
                      onChanged: (value) {
                        setState(() {
                          markss[index] = value!;
                        });
                      },
                    ),
                    const Text('4'),
                    Radio(
                      groupValue: markss[index],
                      value: 5,
                      onChanged: (value) {
                        setState(() {
                          markss[index] = value!;
                        });
                      },
                    ),
                    const Text('5'),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, calculateMean(markss));
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
