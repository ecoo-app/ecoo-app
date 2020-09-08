import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:ecoupon_lib/models/address_auto_completion_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

typedef ValidationFunction = bool Function();

class VerificationAddressField extends StatefulWidget {
  final AddressVerificationInput model;
  final String label;
  final Function suggestionsCallback;

  VerificationAddressField({this.model, this.label, this.suggestionsCallback});

  @override
  State<VerificationAddressField> createState() =>
      _MaterialVerificationAddressField(model, label, suggestionsCallback);
}

class _MaterialVerificationAddressField
    extends State<VerificationAddressField> {
  final AddressVerificationInput model;
  final String label;
  final Function suggestionsCallback;
  final TextEditingController _typeAheadController = TextEditingController();

  _MaterialVerificationAddressField(
      this.model, this.label, this.suggestionsCallback);

  Widget _createItem(
      BuildContext context, AddressAutoCompletionResult resultItem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(resultItem.street),
          Text(
            '${resultItem.postalCode} ${resultItem.town}',
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<AddressAutoCompletionResult>(
      textFieldConfiguration: TextFieldConfiguration(
          focusNode: model.focusNode,
          onEditingComplete: () => model.fieldFocusChange(context),
          controller: this._typeAheadController,
          decoration: InputDecoration(
            helperText: label,
            helperStyle: Theme.of(context)
                .textTheme
                .bodyText2
                .merge(TextStyle(color: ColorStyles.bg_gray)),
          )),
      getImmediateSuggestions: true,
      noItemsFoundBuilder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          I18n.of(context).noAddressSuggestions,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
      suggestionsCallback: (pattern) async {
        return suggestionsCallback != null
            ? await suggestionsCallback(pattern)
            : [];
      },
      itemBuilder: (context, suggestion) {
        return _createItem(context, suggestion);
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      suggestionsBoxVerticalOffset: -20,
      onSuggestionSelected: (suggestion) {
        model.setValue(Address(
            street: suggestion.street,
            postalCode: suggestion.postalCode,
            city: suggestion.town));
        print(model.value);
        this._typeAheadController.text = model.value;
      },
      validator: (value) {
        var result = model.isValid;
        if (result) {
          return null;
        } else {
          return I18n.of(context).formErrorRequired;
        }
      },
    );
  }
}
