import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_todo/data_provider.dart';
import 'package:flutter_todo/model.dart';

class CreateScreen extends StatefulWidget {
  final Category category;
  const CreateScreen({Key key, this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController _taskController;

  @override
  void initState() {
    _taskController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.black87),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "New Task",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(80.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _taskController,
                      autofocus: true,
                      style: Theme.of(context).textTheme.title,
                      decoration: InputDecoration(
                          labelText: "What task are you planning to perform?",
                          labelStyle: Theme.of(context).textTheme.subhead),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.purple),
              child: StoreConnector<CategoryState, ValueChanged<String>>(
                converter: (store) =>
                    (name) => store.dispatch(AddTask(widget.category, name)),
                builder: (context, callback) => IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      String text = _taskController.text;
                      if (text != null && text.isNotEmpty) {
                        callback(text);
                      }
                      Navigator.of(context).pop();
                    }),
              ),
            ),
          ],
        ));
  }
}
