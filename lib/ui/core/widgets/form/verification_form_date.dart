import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/constants.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/core/widgets/date/custom_date_picker_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// initialDate, firstDate, lastDate come from showDatePicker():
class VerificationFormDateField extends StatefulWidget {
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

  VerificationFormDateField({
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

class _DateFormField extends State<VerificationFormDateField> {
  TextEditingController _controllerDate;
  DateFormat _dateFormat;
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();

    if (widget.dateFormat != null) {
      _dateFormat = widget.dateFormat;
    } else {
      _dateFormat = DateFormat.yMd(Constants.defaultLocale.toLanguageTag());
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

  void _applyPickedDate(DateTime pickedDate) {
    if (pickedDate != null) {
      _selectedDate = pickedDate;
      _controllerDate.text = _dateFormat.format(_selectedDate);
      widget.onDateChanged(_selectedDate);
    }

    if (widget.focusNode != null) {
      widget.focusNode.nextFocus();
    }
  }

  Future<DateTime> _materialDatePicker() async {
    final DateTime pickedDate = await showCustomDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      locale: Constants.defaultLocale,
      builder: (context, child) {
        var primaryColorTheme = ColorScheme.fromSwatch(
            primarySwatch:
                MaterialColor(ColorStyles.bg_gray.value, <int, Color>{
          50: ColorStyles.bg_gray,
          100: ColorStyles.bg_gray,
          200: ColorStyles.bg_gray,
          300: ColorStyles.bg_gray,
          400: ColorStyles.bg_gray,
          500: ColorStyles.bg_gray,
          600: ColorStyles.bg_gray,
          700: ColorStyles.bg_gray,
          800: ColorStyles.bg_gray,
          900: ColorStyles.bg_gray,
        }));
        return Theme(
          data: generalTheme.copyWith(
            buttonTheme: ButtonThemeData(colorScheme: primaryColorTheme),
            colorScheme: primaryColorTheme,
          ),
          child: child,
        );
      },
    );

    return pickedDate;
  }

  Future<void> _cupertinoDatePicker() async {
    final double headerHeight = 55;
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        var pickedDate = widget.initialDate;
        return Container(
          height:
              MediaQuery.of(context).copyWith().size.height / 3 + headerHeight,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        vertical: BorderSide(
                            width: 0.5, color: CupertinoColors.separator))),
                height: headerHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      child: Text(I18n.of(context)
                          .cupertinoDatePickerDialogFinishButton),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _applyPickedDate(pickedDate);
                      },
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).copyWith().size.height / 3,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (picked) {
                    pickedDate = picked;
                  },
                  initialDateTime: widget.initialDate,
                  minimumYear: widget.firstDate.year,
                  maximumYear: widget.lastDate.year,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);

    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        var pickedDate = await _materialDatePicker();
        _applyPickedDate(pickedDate);
        break;
      case TargetPlatform.macOS:
      case TargetPlatform.iOS:
        await _cupertinoDatePicker();
        break;
    }
  }
}
