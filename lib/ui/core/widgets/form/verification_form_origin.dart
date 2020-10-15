import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_coupon/business/entities/city_of_origin.dart';
import 'package:e_coupon/generated/i18n.dart';
import 'package:e_coupon/ui/core/style/theme.dart';
import 'package:e_coupon/ui/screens/verification/verification_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class VerificationFormOrigin extends StatefulWidget {
  final OriginVerificationInput model;
  final String label;
  final Function citySuggestionsCallback;

  const VerificationFormOrigin(
      {Key key, this.model, this.label, this.citySuggestionsCallback})
      : super(key: key);

  @override
  _VerificationFormOrigin createState() => _VerificationFormOrigin();
}

class _VerificationFormOrigin extends State<VerificationFormOrigin> {
  final TextEditingController _cityOfOriginController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cityOfOriginController.addListener(onTextChanged);
  }

  void onTextChanged() {
    widget.model.setCity(_cityOfOriginController.text);
  }

  @override
  void dispose() {
    _cityOfOriginController.dispose();
    super.dispose();
  }

  void _onCountryChanged(CountryCode countryCode) {
    widget.model.isSwissChanged(countryCode.code == 'CH');
    if (!widget.model.isSwiss) {
      widget.model.setCountry(countryCode.name);
      this._cityOfOriginController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          child: TypeAheadFormField<CityOfOrigin>(
            textFieldConfiguration: TextFieldConfiguration(
                enabled: widget.model.isSwiss,
                focusNode: widget.model.focusNode,
                onEditingComplete: () => widget.model.fieldFocusChange(context),
                controller: this._cityOfOriginController,
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
                I18n.of(context).noOriginSuggestions,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            suggestionsCallback: (pattern) async {
              return widget.citySuggestionsCallback != null
                  ? await widget.citySuggestionsCallback(pattern)
                  : [];
            },
            itemBuilder: (context, suggestion) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(suggestion.cityAndCanton),
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            suggestionsBoxVerticalOffset: -20,
            onSuggestionSelected: (suggestion) {
              widget.model.setCity(suggestion.cityAndCanton);
              this._cityOfOriginController.text = widget.model.value;
            },
            validator: (value) {
              var result = widget.model.isValid;
              if (result) {
                return null;
              } else {
                return I18n.of(context).formErrorAddressSelectRequired;
              }
            },
          ),
        ),
        SizedBox(
          height: 32,
        ),
        CountryCodePicker(
          onChanged: _onCountryChanged,
          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
          initialSelection: 'CH',
          showFlagDialog: false,
          comparator: (a, b) => b.name.compareTo(a.name),
          showCountryOnly: true,
          showOnlyCountryWhenClosed: true,
          showFlag: false,
          //Get the country information relevant to the initial selection
          onInit: (code) => print("on init ${code.name}"),
          textStyle: Theme.of(context)
              .textTheme
              .headline3
              .merge(TextStyle(fontWeight: fontWeightRegular)),
        ),
        Text(I18n.of(context).verifyFormFieldNationality)
      ],
    );
  }
}
