import 'package:e_coupon/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// initialDate, firstDate, lastDate come from showDatePicker():
class DateFormField extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;

  /// date selected initially
  final DateTime initialDate;

  /// first date that is possible to select (must be before initialDate)
  final DateTime firstDate;

  /// last date that is possbile to select (must be after initialDate)
  final DateTime lastDate;
  final DateFormat dateFormat;
  final FocusNode focusNode;
  final String labelText;
  final String hintText;

  /// the icon at the start of the text field
  final Icon prefixIcon;

  /// the icon at the end of the text field
  final Icon suffixIcon;

  DateFormField({
    Key key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.dateFormat,
    @required this.lastDate,
    @required this.firstDate,
    @required this.initialDate,
    @required this.onDateChanged,
  })  : assert(initialDate != null),
        assert(firstDate != null),
        assert(lastDate != null),
        assert(!initialDate.isBefore(firstDate),
            'initialDate must be on or after firstDate'),
        assert(!initialDate.isAfter(lastDate),
            'initialDate must be on or before lastDate'),
        assert(!firstDate.isAfter(lastDate),
            'lastDate must be on or after firstDate'),
        assert(onDateChanged != null, 'onDateChanged must not be null'),
        super(key: key);

  @override
  _DateFormField createState() => _DateFormField();
}

class _DateFormField extends State<DateFormField> {
  TextEditingController _controllerDate;
  DateFormat _dateFormat;
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();

    if (widget.dateFormat != null) {
      _dateFormat = widget.dateFormat;
    } else {
      _dateFormat = DateFormat.yMd('de-CH');
    }

    _selectedDate = widget.initialDate;

    _controllerDate = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: widget.focusNode,
        controller: _controllerDate,
        decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            labelText: widget.labelText,
            hintText: widget.hintText),
        onTap: () => _selectDate(context),
        readOnly: true,
        validator: (value) {
          if (value.isEmpty) {
            return I18n.of(context).formErrorRequired;
          }
          return null;
        });
  }

  @override
  void dispose() {
    _controllerDate.dispose();
    super.dispose();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      _controllerDate.text = _dateFormat.format(_selectedDate);
      widget.onDateChanged(_selectedDate);
    }

    if (widget.focusNode != null) {
      widget.focusNode.nextFocus();
    }
  }
}
