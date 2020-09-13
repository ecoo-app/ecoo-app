class CityOfOrigin {
  String cityAndCanton;

  CityOfOrigin(this.cityAndCanton);

  // {
  //   "datasetid": "politische-gemeinden_v2",
  //   "recordid": "9bcc1d2938be3e9c617185e9be6964e9b8fb57cd",
  //   "fields": {
  //     "bfsnr": 4711,
  //     "gemeindename": "Affeltrangen",
  //     "rec_art": "03",
  //     "kanton": "TG"
  //   },
  //   "record_timestamp": "2020-08-28T23:00:07.854000+00:00"
  // },

  // TODO if Geimende name contains canton: delete it
  CityOfOrigin.fromJson(Map<String, dynamic> json)
      : cityAndCanton = cleanup(json);
  // : cityAndCanton =
  //       '${json['fields']['gemeindename']} ${json['fields']['kanton']}';

// gemeindename seems to contain (canton) sometimes, so it has to be cleaned
  static String cleanup(Map<String, dynamic> json) {
    String gemeinde = json['fields']['gemeindename'];
    String canton = json['fields']['kanton'];
    if (gemeinde.contains(canton)) {
      gemeinde = gemeinde.replaceAll('($canton)', '');
      gemeinde = gemeinde.trim();
    }
    return '$gemeinde $canton';
  }
}
