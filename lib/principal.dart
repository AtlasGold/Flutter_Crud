import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_crud/src/database/database.dart';

import 'src/platform/platform.dart';

class MainScreenState extends State<MainScreen> {
  List<Entrie> allItems = [];
  TextEditingController editController = TextEditingController();
  final database = MyDatabase(Platform.createDatabaseConnection('sample'));
  TextEditingController updateValue = TextEditingController();
  void addPressed() {
    database.into(database.entries).insert(
        EntriesCompanion(value: drift.Value(editController.text.toString())));
  }

  void addClean() {
    database.clearEntries();
  }

  void update(String value, int id) {
    database.updateEntry(value, id);
  }

  @override
  void initState() {
    database.allEntries().watch().listen((event) {
      setState(() {
        allItems = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                onSubmitted: (value) {
                  addPressed();
                },
                controller: editController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                  onPressed: addPressed, child: const Text('Add')),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Entries',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            for (var e in allItems)
              GestureDetector(
                  onTap: () {
                    setState(() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Change text"),
                              content: TextField(
                                controller: updateValue,
                                onSubmitted: (value) {
                                  update(value, e.id);
                                  Navigator.pop(context);
                                  updateValue.clear();
                                },
                              ),
                            );
                          });
                    });
                  },
                  child: Text(e.value)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                  onPressed: addClean, child: const Text('Remove')),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainScreenState();
}
