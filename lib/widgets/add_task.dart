import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fire_task/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskWidget extends StatefulWidget {
  final Function onSaved;
  AddTaskWidget({@required this.onSaved});
  @override
  State<AddTaskWidget> createState() => AddTaskWigetState();
}

class AddTaskWigetState extends State<AddTaskWidget> {
  final _controller = TextEditingController();
  final _detailController=TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  var dateTime;
  bool showDetail = false;
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  @override
  void initState() {
    super.initState();
    _controller.clear();
    _detailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10),
            topRight: const Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                autofocus: true,
                focusNode: nodeOne,
                controller: _controller,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: false,
                maxLines: 3,
                minLines: 1,
                textInputAction: TextInputAction.newline,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    hintText: 'New task', border: InputBorder.none),
              ),
              if (showDetail)
                TextField(
                  controller: _detailController,
                  focusNode: nodeTwo,
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: 20,
                  textInputAction: TextInputAction.newline,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Colors.grey[700]),
                  decoration: InputDecoration(
                      hintText: 'Add Details', border: InputBorder.none),
                ),
              if (dateTime != null) calendarBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    alignment: AlignmentDirectional.centerStart,
                    onPressed: () {
                      setState(() {
                        showDetail = !showDetail;
                      });
                    },
                    icon: Icon(
                      Icons.list,
                      color: Colors.blueAccent,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    alignment: AlignmentDirectional.centerStart,
                    onPressed: () async {
                      getDateAndTime().then((onValue) {
                        setState(() {
                          dateTime = onValue;
                        });
                      });
                    },
                    icon: Icon(
                      Icons.today,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () {
                          widget.onSaved(
                              controller: _controller, 
                              detailController:_detailController,
                              dateTime: dateTime);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime> getDateAndTime() async {
    var date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: DateTime.now(),
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
    String date = Utils.getDateAndTime(dateTime);
    return Container(
      padding: EdgeInsets.only(left: 6, top: 2, bottom: 2),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey[300]),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 3),
            child: Icon(
              Icons.alarm_on,
              color: Colors.blue,
              size: 23,
            ),
          ),
          Text(
            date,
            style: TextStyle(fontSize: 12.8),
          ),
          Container(
            height: 30,
            width: 30,
            child: IconButton(
              onPressed: () {
                setState(() {
                  dateTime = null;
                });
              },
              icon: Container(
                child: Center(
                  child: Icon(
                    Icons.clear,
                    size: 15,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class BasicDateTimeField extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return BasicDateTimeFieldState();
//   }
// }
//
// class BasicDateTimeFieldState extends State<BasicDateTimeField> {
//   final format = DateFormat("yyyy-MM-dd HH:mm");
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       // Text('Basic date & time field (${format.pattern})'),
//       DateTimeField(
//         format: format,
//         onShowPicker: (context, currentValue) async {
//           final date = await showDatePicker(
//               context: context,
//               firstDate: DateTime(1900),
//               initialDate: currentValue ?? DateTime.now(),
//               lastDate: DateTime(2100));
//           if (date != null) {
//             final time = await showTimePicker(
//               context: context,
//               initialTime:
//                   TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//             );
//             return DateTimeField.combine(date, time);
//           } else {
//             return currentValue;
//           }
//         },
//       ),
//     ]);
//   }
// }
