import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_coupon/business/core/failure.dart';
import 'package:e_coupon/business/entities/city_of_origin.dart';
import 'package:e_coupon/data/network_info.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

abstract class IOriginService {
  Future<Either<Failure, List<CityOfOrigin>>> cityAutocompletions(
      String pattern);
  void closeClient();
}

@LazySingleton(as: IOriginService)
class OriginService implements IOriginService {
  final INetworkInfo _networkInfo;
  Client client;

  OriginService(this._networkInfo);

  @override
  void closeClient() {
    if (client != null) {
      client.close();
    }
  }

  @override
  Future<Either<Failure, List<CityOfOrigin>>> cityAutocompletions(
      String pattern) async {
    if (client == null) {
      client = Client();
    }

    if (!await _networkInfo.isConnected) {
      return Left(NoService());
    }

    try {
      var uriResponse = await client.get(
          'https://swisspost.opendatasoft.com/api/records/1.0/search/?dataset=politische-gemeinden_v2&q=$pattern');

      if (uriResponse.statusCode == 200) {
        List<CityOfOrigin> origins = [];

        Map responseMap = jsonDecode(uriResponse.body);
        var records = responseMap['records'];

        for (var record in records) {
          origins.add(CityOfOrigin.fromJson(record));
        }

        return Right(origins);
      } else {
        print(uriResponse.body);
        var originalMsg = uriResponse.body;

        Map<String, List<String>> errormsg = Map();
        errormsg['postAPI'] = ['postAPI: $originalMsg'];

        return Left(HTTPFailure(uriResponse.statusCode, errormsg));
      }
    } catch (e) {
      print(e);
      return Left(UnknownFailure());
    }
  }
}
