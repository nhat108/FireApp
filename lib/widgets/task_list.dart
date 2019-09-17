import 'package:fire_task/model/task.dart';
import 'package:fire_task/utils/colors.dart';
import 'package:fire_task/utils/utils.dart';
import 'package:fire_task/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  final Function onTap;
  final Function onDeleteTask;
  final Function onDoneTask;
  TaskList({this.onTap, this.onDeleteTask, this.onDoneTask});
  @override
  State<StatefulWidget> createState() => TaskListState();
}

class TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    var taskList = Provider.of<List<Task>>(context);
    return Stack(
      children: <Widget>[
        Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              if (taskList == null || taskList.length == 0)
                Container(
                  height: 10,
                ),
              if (taskList != null)
                for (int i = 0; i < taskList.length; i++)
                  getTaskItem(
                      index: i,
                      task: taskList[i],
                      onTap: () {
                        widget.onTap(task: taskList[i]);
                      }),
            ],
          ),
        ),
        SharedWidget.getCardHeader(context: context, text: 'TASK')
      ],
    );
  }

  Widget getTaskItem({@required Task task, @required onTap, int index}) {
    return Container(
      child: Column(
        children: <Widget>[
          Dismissible(
            key: Key(task.title + '$index'),
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                widget.onDeleteTask(id: task.id);
              } else if (direction == DismissDirection.startToEnd) {
                widget.onDoneTask(id: task.id);
              }
            },
            secondaryBackground:
                SharedWidget.getOnDismissableDeleteBackground(),
            background: SharedWidget.getOnDismissableDoneBackground(),
            child: InkWell(
              onTap: onTap, //do something,
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 7,
                      decoration: BoxDecoration(
                          color: TasksColor.sharedInstance
                              .leadingTaskColor(index)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.only(top: 15, right: 20, bottom: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              task.title,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.justify,
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(color: Color(0xff373640)),
                            ),
                            if (task.detail != null && task.detail.length > 0)
                              SizedBox(
                                height: 5,
                              ),
                            if (task.detail != null && task.detail.length > 0)
                              Text(
                                task.detail,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(
                                        color: Color(0xff373640),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                              ),
                            if (task.alarm != null)
                              OutlineButton(
                                color: Colors.green,
                                onPressed: () {},
                                padding: EdgeInsets.all(5),
                                child: Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 mainAxisSize: MainAxisSize.min,
                                 children: <Widget>[
                                   Icon(Icons.alarm,color: Colors.blue,),
                                   SizedBox(width: 5,),
                                   Text(
                                     Utils.dayReminder(task.alarm),
                                     style: TextStyle(color: Colors.blue),
                                   ),
                                   SizedBox(width: 5,)
                                 ],
                                  ),
                              ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0.5,
            child: Container(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
