import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fire_task/utils/utils.dart';
import 'package:flutter/material.dart';

class SharedWidget {
  static Widget getCardHeader(
      {@required BuildContext context,
      @required String text,
      Color textColor = Colors.white,
      Color cardColor = Colors.red}) {
    var fontSize = Theme.of(context).textTheme.title.fontSize;
    return Container(
      width: 85,
      alignment: AlignmentDirectional.center,
      margin: EdgeInsets.only(left: 35),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: cardColor),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: textColor, fontSize: fontSize),
      ),
    );
  }

  static Widget getOnDismissableDoneBackground() {
    return Container(
        alignment: Alignment.centerLeft,
        color: Colors.blue,
        padding: EdgeInsets.only(left: 10),
        child: Icon(
          Icons.done,
          color: Colors.white,
        ));
  }

  static Widget getOnDismissableDeleteBackground() {
    return Container(
      alignment: Alignment.centerRight,
      color: Colors.red,
      padding: EdgeInsets.only(right: 10),
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  static Future<DateTime> getDateAndTime(
      BuildContext context, DateTime dateTime) async {
      
    var date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: dateTime == null ? DateTime.now() : dateTime,
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
}
