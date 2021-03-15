import 'package:flutter/material.dart';
import 'package:flutter_2_todo_app/custom_widgets/title_widget.dart';
import 'package:flutter_2_todo_app/todo_model.dart';

class ItemView extends StatefulWidget {
  final Todo item;

  ItemView({this.item});

  @override
  ItemViewState createState() => ItemViewState();
}

class ItemViewState extends State<ItemView> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController(
      text: widget.item != null ? widget.item.description : null,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(widget.item != null ? 'EDIT TODO' : 'NEW TODO'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _textEditingController,
              autofocus: true,
              onFieldSubmitted: (_) => submit(),
              maxLines: 2,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 15,),
            ElevatedButton(
              onPressed: submit,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('SUBMIT',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void submit(){
    String description = _textEditingController.text;
    if(description != null && description.isNotEmpty)
      Navigator.of(context).pop(description);
  }
}
