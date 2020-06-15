import 'dart:convert';

import 'package:e_coupon/views/video_cell.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ECouponApp());
}

class ECouponApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<ECouponApp> {
  var _isLoading = true;
  var videos;

  _fetchData() async {
    print("fetch data");

    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final videosJson = map["videos"];
      // videosJson.forEach((video) {
      //   print(video["name"]);
      // });

      setState(() {
        _isLoading = false;
        videos = videosJson;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "übersicht",
      home: new Scaffold(
          appBar: new AppBar(title: new Text("Übersicht"), actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.refresh),
                onPressed: () {
                  print("Reloading...");
                  setState(() {
                    _isLoading = true;
                  });
                  _fetchData();
                })
          ]),
          body: new Center(
            child: _isLoading
                ? new CircularProgressIndicator()
                : new ListView.builder(
                    itemCount: videos != null ? videos.length : 0,
                    itemBuilder: (context, i) {
                      final video = videos[i];
                      return new FlatButton(child: new VideoCell(video),
                      onPressed: (){
                        Navigator.push(context, 
                        new MaterialPageRoute(builder: (context){
                          return new DetailPage();
                        }));
                      });
                    }),
          )),
    );
  }
}


class DetailPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('detail page'),
      ),
      body: new Center(
        child: new Text('Detail')
      ),
    );
  }
  
}


class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, rowNumber) {
        return new WalletListItem(); //new Text("row $rowNumber");
      },
      itemCount: 20,
    );
  }
}

class WalletListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[new Text("row"), new Divider(color: Colors.amber)],
    );
  }
}
