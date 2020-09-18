import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:ecoupon_lib/models/address_auto_completion_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

typedef ValidationFunction = bool Function();

class VerificationAddressField extends StatefulWidget {
  final AddressVerificationInput model;
  final String label;
  final Function suggestionsCallback;

  VerificationAddressField({this.model, this.label, this.suggestionsCallback});

  @override
  State<VerificationAddressField> createState() =>
      _MaterialVerificationAddressField();
}

class _MaterialVerificationAddressField
    extends State<VerificationAddressField> {
  final TextEditingController _typeAheadController = TextEditingController();

  bool isEditable = true;

  @override
  void initState() {
    this.isEditable = true;
    super.initState();
  }

  _MaterialVerificationAddressField();

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

  Widget _createInput() {
    return TypeAheadFormField<AddressAutoCompletionResult>(
      textFieldConfiguration: TextFieldConfiguration(
          focusNode: widget.model.focusNode,
          onEditingComplete: () => widget.model.fieldFocusChange(context),
          controller: this._typeAheadController,
          style: Theme.of(context)
              .textTheme
              .headline3
              .merge(TextStyle(fontWeight: fontWeightRegular)),
          decoration: InputDecoration(
            helperText: widget.label,
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
        return widget.suggestionsCallback != null
            ? await widget.suggestionsCallback(pattern)
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
        widget.model.setValue(Address(
            street: suggestion.street,
            postalCode: suggestion.postalCode,
            city: suggestion.town));

        this._typeAheadController.text = widget.model.value;
        this.isEditable = false;
      },
      validator: (value) {
        var result = widget.model.isValid;
        if (result) {
          return null;
        } else {
          return I18n.of(context).formErrorRequired;
        }
      },
    );
  }

  Widget _createOutput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.model.input.street,
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .merge(TextStyle(fontWeight: fontWeightRegular))),
                Text(
                  '${widget.model.input.postalCode} ${widget.model.input.city}',
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
            GestureDetector(
                onTap: _onResetInput, child: SvgPicture.asset(Assets.close_svg))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: const Divider(
            color: Colors.grey,
            height: 1,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
        ),
        Text(
          widget.label,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .merge(TextStyle(color: ColorStyles.bg_gray)),
        )
      ],
    );
  }

  void _onResetInput() {
    this._typeAheadController.clear();
    widget.model.setValue(null);
    setState(() {
      this.isEditable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.isEditable ? _createInput() : _createOutput();
  }
}
