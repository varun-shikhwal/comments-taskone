import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskone/todo.dart';
import 'package:http/http.dart' as http;
import 'items.dart';
import 'models.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return  MaterialApp(
     debugShowCheckedModeBanner: false,
     home: home(),
   );
  }

}
class home extends StatefulWidget{

  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Add Cart',
      style: optionStyle,
    ),
    Text(
      'Index 2: News',
      style: optionStyle,
    ),
    Text(
      'Index 3: Profile',
      style: optionStyle,
    ),
  ];

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {


  List<PostResponse> postresponse=[];

  final todoslist=ToDo.todoList();
  final todoController=TextEditingController();
  List<ToDo> _foundToDo=[];

  void _handleToDoChange(ToDo toDo){
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }
  void _deleteToDoItem(String id){
    setState(() {
      todoslist.removeWhere((item) => item.id == id);
    });
  }
  void _addToDoItem(String toDo){
    setState(() {
      todoslist.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todotext: toDo));
    });
    todoController.clear();
  }
  @override
  void initState() {
    _foundToDo=todoslist;
  }

  void _runFilter(String enteredkeyword) {
    List<ToDo> results = [];
    if (enteredkeyword.isEmpty) {
      results = todoslist;
    }
    else {
      results = todoslist.where((item) =>
          item.todotext!
              .toLowerCase()
              .contains(enteredkeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }


  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple.shade50,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.deepPurple.withOpacity(.30),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {},

        items:const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Add cart',
            icon: Icon(Icons.credit_card),
          ),
          BottomNavigationBarItem(
            label: 'News',
            icon: Icon(Icons.newspaper),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.account_circle),
          ),
        ],
        currentIndex: _selectedIndex,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
           const Text(
              'Add Comments',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,color: Colors.black,
            ),
            ),
            const SizedBox(height: 290,
              child: Image(image: AssetImage(
                'assets/images/images.jpg',
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15),
              child: Divider(thickness: 3,
                height: .5,color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 20,),
            Container(height: 50,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.only(left: 20,right: 20),
              decoration: BoxDecoration(color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                 decoration: const InputDecoration(
                  // contentPadding: EdgeInsets.all(0),
                 hintText: 'Search',
                 prefixIcon: Icon(Icons.search,color: Colors.black54,),
                 border: InputBorder.none,
      ),
    ),
            ),
            Expanded(
              child: ListView(
                children: [
                  for(ToDo todo in _foundToDo.reversed )
                    items(todo: todo,
                      onToDoChanged: _handleToDoChange,
                      onAddItem: _addToDoItem,
                      onDeleteItem: _deleteToDoItem,
                    ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(child: Container(
                  margin:const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  decoration: const BoxDecoration(
                    color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.0, 0.0),
                        color: Colors.grey,
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],

                  ),
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      hintText: 'Add a new comments',
                      border: InputBorder.none,
                    ),
                  ),
                ),),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(onPressed: (){
                    final snackbar=SnackBar(content: const Text('New Comment was added'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: (){},
                    ),

                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    _addToDoItem(todoController.text);
                  }, child: Icon(Icons.add,color: Colors.white,),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),

                )
              ],),
            )
          ],

        ),

      ),
    );
  }
  Future<List<PostResponse>> getData() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data= jsonDecode(response.body.toString());

    if(response.statusCode==200){
      for(Map<String, dynamic>  index in data){
        postresponse.add(PostResponse.fromJson(index));
      }
      return postresponse;
    }
    else{
      return postresponse;
    }
  }
}