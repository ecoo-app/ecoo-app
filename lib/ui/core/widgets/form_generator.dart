import 'package:e_coupon/business/entities/verification_input.dart';
import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/widgets/date_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: unused_element
var _formKey = GlobalKey<FormState>();

///
///
///
class FieldFail extends StatelessWidget {
  final String fieldType;

  FieldFail({@required this.fieldType});

  @override
  Widget build(BuildContext context) {
    return Text('Field of type $fieldType failed');
  }
}

///
///
///
class FormGenerator extends StatefulWidget {
  final List<VerificationInput> inputs;
  final Map<String, String> inputData;
  final GlobalKey<FormState> formKey;

  FormGenerator({this.inputs, this.inputData, this.formKey});

  @override
  _FormGeneratorState createState() =>
      _FormGeneratorState(inputs, inputData, formKey);
}

///
///
///
class _FormGeneratorState extends State<FormGenerator> {
  final List<VerificationInput> inputs;
  final Map<String, String> inputData;
  final GlobalKey<FormState> formKey;

  _FormGeneratorState(this.inputs, this.inputData, this.formKey);

  void _setInputValue(String uuid, String value) {
    if (inputData.containsKey(uuid)) {
      // inputData[uuid] = value;
      inputData.update(uuid, (_) => value);
    } else {
      inputData.putIfAbsent(uuid, () => value);
    }
  }

  List<Widget> _generateFields(List<VerificationInput> inputsInput) {
    return inputsInput.map((input) {
      switch (input.inputType) {
        case InputType.Text:
          return TextFormField(
            key: Key('${input.i18nLabel['all']}${input.inputType}'),
            onChanged: (text) => _setInputValue(input.id, text),
            decoration: InputDecoration(
                hintText: input.i18nHint != null ? input.i18nHint['all'] : '',
                labelText: input.i18nLabel['all']),
            validator: (value) {
              if (value.isEmpty) {
                return I18n.of(context).formErrorRequired;
              }
              return null;
            },
          );
        case InputType.Date:
          return DateFormField(
            key: Key('${input.i18nLabel['all']}${input.inputType}'),
            labelText: input.i18nLabel['all'],
            suffixIcon: Icon(Icons.calendar_today),
            initialDate: DateTime.now(),
            firstDate: DateTime.utc(1870),
            lastDate: DateTime.now(),
            onDateChanged: (_) => print('date changed'),
          );
        default:
          return FieldFail(fieldType: input.inputType.toString());
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Expanded(child: ListView(children: _generateFields(inputs))));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
