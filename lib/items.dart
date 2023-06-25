import 'package:flutter/material.dart';
import 'package:taskone/todo.dart';
class items extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  final onAddItem;

  const items({
    required this.todo,
    required this.onDeleteItem,
    required this.onToDoChanged,
    required this.onAddItem,
    super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 22),
        child:ListTile(
          onTap: (){
            // print('Clicked on todo item!');

            onToDoChanged(todo);
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
          tileColor: Colors.white,
          // leading: Icon(todo.isDone? Icons.check_box : Icons.check_box_outline_blank,color: Colors.indigo,),
          title: Container(
            margin:const EdgeInsets.all(10),
            padding:const EdgeInsets.all(15),
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),color: Colors.grey.shade300,
          ),
            child: Text(todo.todotext!,style:const TextStyle(
              fontSize: 16,color: Colors.black,
            ),),
          ),
          trailing: Container(height: 25,width: 110,
            decoration:const BoxDecoration(
              // color: Colors.red,
              // borderRadius: BorderRadius.circular(5),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon:const Icon( Icons.delete),
                  color: Colors.deepPurple,
                  onPressed: () {
                    // print('Clicked on delete button');

                    onDeleteItem(todo.id);
                  },
                  padding:const EdgeInsets.all(0),
                  iconSize: 23,
                ),const SizedBox(width: 5,),
                // IconButton(
                //   icon:Icon( Icons.add),
                //   color: Colors.deepPurple,
                //   onPressed: () {
                //     // print('Clicked on delete button');
                //
                //     onAddItem(todo.id);
                //   },
                //   padding: EdgeInsets.all(0),
                //   iconSize: 23,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

