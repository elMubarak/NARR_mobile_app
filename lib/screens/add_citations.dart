import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:narr/models/citation_mode.dart';

class CitationDialog extends StatefulWidget {
  const CitationDialog();

  @override
  _CitationDialogState createState() => _CitationDialogState();
}

class _CitationDialogState extends State<CitationDialog> {
  final TextEditingController citationNameController = TextEditingController();
  final TextEditingController citationYearController = TextEditingController();
  final TextEditingController citationwebsiteController =
      TextEditingController();
  List<String> suggestCitation = <String>[
    'Musa Damu',
    'Ibrahim gwads',
    'Aseey Jibson',
  ];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add new citation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Divider(thickness: 1),
                SizedBox(height: 15),
                TypeAheadFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'person name can not be empty';
                    }
                    return null;
                  },
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: citationNameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        hintText: 'Name'),
                  ),
                  suggestionsCallback: (String pattern) async {
                    final List<String> list = suggestCitation ?? <String>[];

                    return list
                        .where((String element) => element
                            .toLowerCase()
                            .contains(pattern.toLowerCase()))
                        .toList();
                  },
                  itemBuilder: (BuildContext context, String suggestion) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(suggestion),
                    );
                  },
                  onSuggestionSelected: (String suggestion) {
                    citationNameController.text = suggestion;
                    setState(() {});
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Citation year can not be empty';
                    }
                    return null;
                  },
                  controller: citationYearController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Year',
                  ),
                  keyboardType: TextInputType.datetime,
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: citationwebsiteController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Website/url (optional)',
                  ),
                  keyboardType: TextInputType.url,
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                // background color    this is color:
                                (Set<MaterialState> states) => Colors.red[600]),
                      ),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text('Close'),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          setState(() {});
                          CitationModel _newCitation = CitationModel(
                            fullName: citationNameController.text,
                            date: citationYearController.text,
                            url: citationwebsiteController.text,
                          );
                          setState(() {});
                          Navigator.pop(context, _newCitation);
                        } else {
                          print('You have to fill required feild');
                        }
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
