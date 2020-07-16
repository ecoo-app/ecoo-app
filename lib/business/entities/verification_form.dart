import 'package:e_coupon/business/entities/verification_input.dart';
import 'package:meta/meta.dart';

class VerificationForm {
  final String title;
  final List<VerificationInput> inputs;

  VerificationForm({@required this.title, @required this.inputs});
}
