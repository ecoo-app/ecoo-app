import 'package:e_coupon/business/entities/verification_input.dart';
import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/widgets/date_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  FormGenerator(this.inputs);

  @override
  _FormGeneratorState createState() => _FormGeneratorState(inputs);
}

///
///
///
class _FormGeneratorState extends State<FormGenerator> {
  final amountInputController = TextEditingController();
  final recieverInputController = TextEditingController();
  final List<VerificationInput> inputs;

  _FormGeneratorState(this.inputs);

  List<Widget> _generateFields(List<VerificationInput> inputsInput) {
    return inputsInput.map((input) {
      switch (input.inputType) {
        case InputType.Text:
          return TextFormField(
            decoration: InputDecoration(
                hintText: input.i18nHint != null ? input.i18nHint['de'] : '',
                labelText: input.i18nLabel['de']),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value.isEmpty) {
                return I18n.of(context).formErrorRequired;
              }
              return null;
            },
          );
        case InputType.Date:
          return DateFormField(
            labelText: 'Geburststag',
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
    return Form(child: Column(children: _generateFields(inputs)));
    // return Form(
    //   child: Column(
    //     children: <Widget>[
    //       TextFormField(
    //         decoration:
    //             InputDecoration(hintText: 'a hint', labelText: 'a label'),
    //         // The validator receives the text that the user has entered.
    //         validator: (value) {
    //           if (value.isEmpty) {
    //             return 'Please enter some text';
    //           }
    //           return null;
    //         },
    //       )
    //     ],
    //   ),
    // );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    amountInputController.dispose();
    recieverInputController.dispose();
    super.dispose();
  }
}
