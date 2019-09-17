import 'package:fire_task/model/task.dart';
import 'package:fire_task/utils/utils.dart';
import 'package:fire_task/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoneList extends StatefulWidget {
  final Function onDeleteTask;
  final Function onTap;
  DoneList({this.onTap, this.onDeleteTask});
  @override
  State<StatefulWidget> createState() => DoneListState();
}

class DoneListState extends State<DoneList> {
  @override
  Widget build(BuildContext context) {
    var doneList = Provider.of<List<Task>>(context);
    return Stack(
      children: <Widget>[
        Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              if (doneList == null || doneList.length == 0)
                Container(
                  height: 10,
                ),
              if (doneList != null)
                for (int i = 0; i < doneList.length; i++)
                  getTaskItem(
                      index: i,
                      task: doneList[i],
                      onTap: () {
                        widget.onTap(task: doneList[i]);
                      })
            ],
          ),
        ),
        SharedWidget.getCardHeader(
            context: context, text: 'DONE', cardColor: Colors.grey)
      ],
    );
  }

  Widget getTaskItem(
      {@required Task task, @required Function onTap, int index}) {
    return Container(
      child: Column(
        children: <Widget>[
          Dismissible(
            key: Key(task.id),
            background: SharedWidget.getOnDismissableDeleteBackground(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              widget.onDeleteTask(id: task.id);
            },
            child: InkWell(
              onTap: onTap,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      width: 7,
                      child: Icon(Icons.done),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, top: 15, right: 20, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              task.title,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.justify,
                              style: Theme.of(context).textTheme.title.copyWith(
                                  color: Colors.grey[400],
                                  decoration: TextDecoration.lineThrough),
                            ),
                            if (task.detail != null && task.detail.length > 0)
                              SizedBox(
                                height: 5,
                              ),
                            if (task.detail != null && task.detail.length > 0)
                              Text(
                                task.detail,
                                maxLines: 3,
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.justify,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey[400],
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
