import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fire_task/model/task.dart';
import 'package:fire_task/utils/utils.dart';
import 'package:fire_task/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditTask extends StatefulWidget {
  final Task oldTask;
  final Function updateTask;
  final Function deleteTask;
  EditTask({this.oldTask, this.updateTask, this.deleteTask});
  @override
  State<StatefulWidget> createState() => EditTaskState();
}

class EditTaskState extends State<EditTask> {
  TextEditingController _titleControl = TextEditingController();
  TextEditingController _detailControl = TextEditingController();
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  Task newTask = new Task();

  DateTime alarm;
  @override
  void initState() {
    super.initState();
    _titleControl.clear();
    _detailControl.clear();
    _titleControl.text = widget.oldTask.title;
    _detailControl.text = widget.oldTask.detail;
    alarm = widget.oldTask.alarm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                newTask = Task(
                    id: widget.oldTask.id,
                    title: _titleControl.text.trim(),
                    detail: _detailControl.text.trim(),
                    created: widget.oldTask.created,
                    updated: DateTime.now(),
                    alarm: alarm);
              });
              widget.updateTask(task: newTask);
              Navigator.pop(context);
            },
            icon: Icon(Icons.done),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                widget.deleteTask(id: widget.oldTask.id);
                Navigator.pop(context);
              },
            ),
          ],
          backgroundColor: Colors.white,
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Flexible(
                child: TextField(
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  minLines: 1,
                  maxLines: 10,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  controller: _titleControl,
                  decoration: InputDecoration(
                      hintText: 'Enter title', border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(
                    Icons.short_text,
                    size: 30,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Flexible(
                    child: TextField(
                      focusNode: nodeTwo,
                      controller: _detailControl,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      minLines: 1,
                      maxLines: 10,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Add details'),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.alarm),
                  SizedBox(
                    width: 5,
                  ),
                  if (alarm == null)
                    FlatButton(
                      onPressed: () async {
                        SharedWidget.getDateAndTime(context, alarm).then((value) {
                          if (value != null) {
                            setState(() {
                              alarm = value;
                            });
                          }
                        });
                      },
                      child: Text('Add date/time'),
                    ),
                  if (alarm != null)
                    OutlineButton(
                      // color: Colors.transparent,
                      onPressed: () {
                        SharedWidget.getDateAndTime(context, alarm).then((value) {
                          if (value != null) {
                            setState(() {
                              alarm = value;
                            });
                          }
                        });
                      },
                      child:calendarBox() ,
                    )
                  // calendarBox()
                ],
              )
            ],
          ),
        ));
  }

  Future<DateTime> getDateAndTime(DateTime dateTime) async {
    var date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: alarm == null ? DateTime.now() : alarm,
        lastDate: DateTime(2100));
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );
      return DateTimeField.combine(date, time);
    }
    return date;
  }

  Widget calendarBox() {
    String date = Utils.getDateAndTime(alarm);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          date,
          style: TextStyle(fontSize: 12.8, color: Colors.blue),
        ),
        Container(
          height: 30,
          width: 18,
          child: IconButton(
            onPressed: () {
              setState(() {
                alarm = null;
              });
            },
            icon: Icon(
              Icons.clear,
              size: 15,
            ),
          ),
        )
      ],
    );
  }
}
