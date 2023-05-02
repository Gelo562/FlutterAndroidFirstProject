import 'package:flutter/material.dart';

import 'marks.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  String name = "";
  String surName = "";
  int marks = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool visible1 = false;
  bool visible2 = false;
  bool visible3 = false;
  double score = 0;
  String buttonText = 'Marks';

  Future<void> _navigateAndDisplaySelection(
      BuildContext context, int marks) async {
    if (score == 0) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Marks(mark: marks)),
      );
      setState(() {
        score = result;
      });
    }
    buttonInfo();
  }

  void buttonInfo() {
    if (score == 0) {
      setState(() {
        buttonText = 'Marks';
      });
    } else if (score < 3) {
      setState(() {
        buttonText = 'Unlucky this time';
      });
    } else {
      setState(() {
        buttonText = 'Great! :)';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab1-GUI'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  initialValue: '',
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Imie: ',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 5) {
                      visible1 = false;
                      return 'Minimum lenght is 5';
                    }
                    visible1 = true;
                    return null;
                  },
                  onChanged: (value) {
                    if (_formKey.currentState!.validate()) {}
                    setState(() {
                      name = value;
                    });
                  }),
              TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Surname: ',
                  ),
                  validator: (value) {
                    if (value == null || value.length < 5) {
                      visible2 = false;
                      return 'Minimum lenght is 5';
                    }
                    visible2 = true;
                    return null;
                  },
                  onChanged: (value) {
                    if (_formKey.currentState!.validate()) {}
                    setState(() {
                      surName = value;
                    });
                  }),
              TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Marks: ',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.parse(value) < 5 ||
                        int.parse(value) > 15) {
                      visible3 = false;
                      return 'Number between 5 and 15';
                    }
                    visible3 = true;
                    return null;
                  },
                  onChanged: (value) {
                    if (_formKey.currentState!.validate()) {}
                    setState(() {
                      if (value != '') {
                        marks = int.parse(value);
                      }
                    });
                  }),
              Visibility(
                visible: visible1 && visible2 && visible3,
                child: ElevatedButton(
                  onPressed: () {
                    if (score == 0) {
                      _navigateAndDisplaySelection(context, marks);
                    } else if (score < 3) {
                      const snackBarBad = SnackBar(
                        content: Text(
                            'I am submitting a conditional bond application'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBarBad);
                    } else {
                      const snackBarGood = SnackBar(
                        content: Text('Congrats! You passed it!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBarGood);
                    }
                  },
                  child: Text(buttonText),
                ),
              ),
              Visibility(
                visible: score != 0,
                child: Text(
                  score.toStringAsFixed(2),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
