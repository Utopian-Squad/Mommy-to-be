import 'package:client/src/mom/widgets/botton_header_widget.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final String dateLimit;
  //final VoidCallback onClick;

  DatePickerWidget(this.dateLimit);
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? date;

  String getText() {
    if (date == null) {
      if (widget.dateLimit == "birth") {
        return 'Select Birth Date';
      } else {
        return 'Select Conceiving Date';
      }
    } else {
      return '${date!.year}/${date!.month}/${date!.day}';
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        text: getText(),
        onClicked: () => pickDate(context, widget.dateLimit),
      );

  Future pickDate(BuildContext context, String dateLimit) async {
    final initialDate = dateLimit == "birth"
        ? DateTime(DateTime.now().year - 19)
        : DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: dateLimit == "birth"
          ? DateTime(DateTime.now().year - 30)
          : DateTime(DateTime.now().year - 1),
      lastDate: dateLimit == "birth"
          ? DateTime(DateTime.now().year - 18)
          : DateTime(DateTime.now().year + 1),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }
}
