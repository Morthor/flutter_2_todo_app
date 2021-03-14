import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2_todo_app/custom_widgets/title_widget.dart';
import 'package:flutter_2_todo_app/item_view.dart';
import 'package:flutter_2_todo_app/todo_model.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter 2 Todo App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.montserratTextTheme()
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final GlobalKey<_ItemListWidgetState> itemKey = GlobalKey<_ItemListWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FlutterLogo(),
            SizedBox(width: 12,),
            TitleWidget('TODO APP'),
            SizedBox(width: 8,),
            Icon(Icons.check,
              size: 28,
              color: Colors.blue,
            )
          ],
        ),
        centerTitle: true,
      ),
      body: ItemListWidget(itemKey),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,),
        onPressed: onPressedFAB,
      ),
    );
  }

  void onPressedFAB(){
    itemKey.currentState.goToNewItemView();
  }
}

class ItemListWidget extends StatefulWidget {
  final GlobalKey itemKey;

  ItemListWidget(this.itemKey) : super(key: itemKey);

  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  List<Todo> items = List<Todo>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return items.length > 0 ? ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(items[index].hashCode.toString()),
          child: ItemWidget(
            item: items[index],
            setItemCompleteness: updateItemCompleteness
          ),
          direction: DismissDirection.horizontal,
          confirmDismiss: (direction) => dismissItem(direction, items[index]),
          background: DismissRemoveBackground(),
          secondaryBackground: DismissEditBackground(),
        );
      }
    ) : EmptyList();
  }

  // Navigation

  void goToEditItem(Todo item){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ItemView(item: item),
    )).then((description) {
      if(description != null && description != ''){
        setState(() {
          updateItemDescription(item, description);
        });
      }
    });
  }

  void goToNewItemView() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return ItemView();
    })).then((description) {
      setState(() {
        addItem(description);
      });
    });
  }

  // Actions

  Future<bool> dismissItem(DismissDirection direction, Todo item) async {
    switch(direction) {
      case DismissDirection.endToStart:
        goToEditItem(item);
        return false;
        break;

      case DismissDirection.startToEnd:
        setState(() {
          removeItem(item);
        });
        return true;
        break;
      default:
        return false;
    }
  }

  // Operations

  void addItem(String description){
    if(description != null && description.isNotEmpty){
      items.insert(0, Todo(description));
    }
  }

  void updateItemCompleteness(Todo item){
    setState(() {
      item.complete = !item.complete;
    });
  }

  void updateItemDescription(Todo item, String description){
    item.description = description;
  }

  void removeItem(Todo item){
    items.remove(item);
  }
}

// UI Widgets

class ItemWidget extends StatelessWidget {
  final Todo item;
  final Function(Todo) setItemCompleteness;

  ItemWidget({
    @required this.item,
    @required this.setItemCompleteness
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(item.description,
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      value: item.complete,
      onChanged: (_) => setItemCompleteness(item),
    );
  }
}

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('NO ITEMS',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
          fontSize: 16
        ),
      ),
    );
  }
}

class DismissRemoveBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Icon(Icons.delete, color: Colors.white),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 12),
    );
  }
}

class DismissEditBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Icon(Icons.edit, color: Colors.white),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 12),
    );
  }
}