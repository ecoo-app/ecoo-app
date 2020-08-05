import 'package:e_coupon/business/entities/verification_input.dart';
import 'package:ecoupon_lib/models/verification_input.dart' as lib;
import 'package:meta/meta.dart';

class VerificationForm {
  final String title;
  final List<lib.VerificationInput> inputModel;
  final List<VerificationInput> inputs;
  final bool isShop;

  VerificationForm({this.title, @required this.inputModel, this.isShop})
      : this.inputs = inputModel.map((input) {
          return VerificationInput(
              id: input.label,
              i18nLabel: {'all': input.label},
              inputType: _getInputType(input.type));
        }).toList();

  static InputType _getInputType(String type) {
    switch (type) {
      case 'text':
        return InputType.Text;
      case 'number':
        return InputType.Number;
      case 'bool':
        return InputType.Bool;
      case 'date':
        return InputType.Date;
      case 'uuid':
        return InputType.Uuid;
      default:
        return InputType.Text;
    }
  }
}
