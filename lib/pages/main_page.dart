import 'package:fire_task/model/db.dart';
import 'package:fire_task/model/task.dart';
import 'package:fire_task/pages/edit_task_page.dart';
import 'package:fire_task/services/authentication.dart';
import 'package:fire_task/utils/utils.dart';
import 'package:fire_task/widgets/add_task.dart';
import 'package:fire_task/widgets/bottom_menu_left.dart';
import 'package:fire_task/widgets/bottom_menu_right.dart';
import 'package:fire_task/widgets/done_list.dart';
import 'package:fire_task/widgets/header.dart';
import 'package:fire_task/widgets/task_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  final BaseAuth auth;
  final FirebaseUser user;
  final VoidCallback onSignOut;
  MainPage({this.auth, this.user, this.onSignOut});
  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  DatabaseService database;
  String msg;
  String firstName;

  @override
  void initState() {
    super.initState();
    msg = Utils.getWelcomeMessage();
    var userName = widget.user.displayName;
    var fullname = userName.split(" ");
    firstName = fullname[0];
    database = DatabaseService(userId: widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).backgroundColor,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  margin: EdgeInsets.only(top: 35, left: 10),
                  child: Header(
                    msg: msg,
                    name: firstName,
                  ),
                ),
              ),
              expandedHeight: 120,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                switch (index) {
                  case 0:
                    return StreamProvider<List<Task>>.value(
                      value: database.streamTasks(TaskStatus.active.index),
                      child: TaskList(
                        onTap: openTask,
                        onDeleteTask: deleteTask,
                        onDoneTask: markAsDoneTask,
                      ),
                    );
                  case 1:
                    return SizedBox(
                      height: 10,
                    );

                  default:
                    return StreamProvider<List<Task>>.value(
                      value: database.streamDones(TaskStatus.done.index),
                      child: DoneList(
                        onTap: openTask,
                        onDeleteTask: deleteTask,
                      ),
                    );
                }
              }, childCount: 3),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return AddTaskWidget(onSaved: addTask);
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.red,
        ),
        elevation: 5,
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return MenuLeft(
                                user: widget.user,
                                logOut: signOut,
                              );
                            });
                      },
                      icon: Icon(Icons.menu))),
              Container(
                  child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return MenuRight(
                                deleteAllDones: deleteAllDoneTasks,
                                deleteAll: deleteAllTasks,
                              );
                            });
                      },
                      icon: Icon(Icons.more_vert)))
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
      ),
    );
  }

  signOut() {
    widget.onSignOut();
    Navigator.pop(context);
  }

  Future addTask(
      {@required TextEditingController controller,
      TextEditingController detailController,
      DateTime dateTime}) async {
    final inputText = controller.text.trim();
    if (inputText.length > 0) {
      Task task = new Task(
          title: inputText,
          detail: detailController.text.trim(),
          created: DateTime.now(),
          updated: DateTime.now(),
          status: TaskStatus.active.index,
          alarm: dateTime ?? null);
      database.createNewTask(task);
    }
  }

  openTask({@required Task task}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTask(
          oldTask: task,
          deleteTask: deleteTask,
          updateTask: updateTask,
        ),
      ),
    );
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => NewRoute()),
    // );
  }

  updateTask({@required Task task}) async {
    database.updateTask(task);
  }

  deleteTask({@required String id}) async {
    print('deleteTask is called: $id');
    database.deleteTask(id);
  }

  markAsDoneTask({@required String id}) async {
    database.markAsDoneTask(id);
  }

  deleteAllTasks() {
    database.deleteAllTasks().then((onValue) {
      Navigator.pop(context);
    });
  }

  deleteAllDoneTasks() {
    database.deleteDoneTasks(TaskStatus.done.index).then((onValue) {
      Navigator.pop(context);
    });
  }
}

class NewRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewRouteState();
  }
}

class NewRouteState extends State<NewRoute> {
  bool isDay=true;
  String state = 'day_idle';
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
                 state = 'switch_night';
                 isDay=!isDay;
                 if(isDay){
                   state='switch_day';
                 }
            });

            Future.delayed(const Duration(milliseconds: 330), () {})
                .then((onValue) {
              setState(() {
                state = 'night_idle';
                if(isDay){
                  state='day_idle';
                }
              });
            });
          },
          child: Container(
            width: 200,
            height: 80,
            child: FlareActor(
              'assets/assets/switch_daytime.flr',
              animation: state,
              
            ),
          ),
        ),
      ),
    );
  }
}   
