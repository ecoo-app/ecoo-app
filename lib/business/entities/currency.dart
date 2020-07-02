import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Currency extends Equatable {
  final String id;
  final String label;

  Currency({@required this.id, @required this.label});

  @override
  List<Object> get props => [id, label];
}
