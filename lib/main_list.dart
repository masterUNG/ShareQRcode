import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

const String _url1 = 'https://line.me/ti/p/IS7TprJ8pl';
const String _url2 = 'https://m.me/yingyong.kamolrat.56';
const String _url3 =
    'https://www.lazada.co.th/products/60w-5-i2416992178-s8309678813.html?spm=a2o4m.home.flashSale.5.11252a80lGE4na&search=1&mp=1&c=fs&clickTrackInfo=rs%3A1.0%3Bfs_item_discount_price%3A84.00%3Bitem_id%3A2416992178%3Bmt%3Ai2i%3Bfs_item_sold_cnt%3A88%3Babid%3A238030%3Bfs_item_price%3A319.00%3Bpvid%3Aa06d857b-d989-48d2-aa73-51e11558dfb3%3Bfs_min_price_l30d%3A84.0%3Bdata_type%3Aflashsale%3Bfs_pvid%3Aa06d857b-d989-48d2-aa73-51e11558dfb3%3Btime%3A1646493396%3Bfs_biz_type%3Afs%3Bscm%3A1007.17760.238030.%3Bchannel_id%3A0000%3Bfs_item_discount%3A74%25%3Bcampaign_id%3A161072&scm=1007.17760.238030.0';
const String _url4 =
    'https://v16-webapp.tiktok.com/fd4ee713552c496d698cf65a7f69186d/6223e749/video/tos/alisg/tos-alisg-pve-0037c001/af935dff37294579838992aa3c28c5cb/?a=1988&br=4404&bt=2202&cd=0%7C0%7C1%7C0&ch=0&cr=0&cs=0&cv=1&dr=0&ds=3&er=&ft=XOQ9-3Rdnz7Thm2MCDXq&l=202203051642080102440870620510C53A&lr=tiktok_m&mime_type=video_mp4&net=0&pl=0&qs=0&rc=MzR4ZDc6ZnE2OzMzODczNEApZmRpNGdmZ2VpN2ZnOzc0aGctMzNicjRvZGRgLS1kMS1zczQyLTFgMDYwL2NgYDMyXjU6Yw%3D%3D&vl=&vr=';

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('กรุณาเลือกช่องทางการติดต่อ'),
      ),
      body: Center(
          child: Column(children: <Widget>[
        const SizedBox(height: 5),
        const SizedBox(
          height: 50, //height of button
          width: 300, //width of button
          child: ElevatedButton(
            onPressed: _launchURL1,
            child: Text('Line'),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 50, //height of button
          width: 300,
          child: ElevatedButton(
            onPressed: () {
              LAUNCHURL(_url2);
            },
            child: Text('Lazada'),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 50, //height of button
          width: 300,
          child: ElevatedButton(
            onPressed: () {
              LAUNCHURL(_url3);
            },
            child: Text('Shopee'),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          height: 50, //height of button
          width: 300,
          child: ElevatedButton(
            onPressed: () {
              LAUNCHURL(_url2);
            },
            child: Text('Facebook'),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          height: 50, //height of button
          width: 300,
          child: ElevatedButton(
            onPressed: () {
              LAUNCHURL(_url4);
            },
            child: Text('Tiktok'),
            //padding:   EdgeInsets.all(30),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          height: 50, //height of button
          width: 300,
          child: ElevatedButton.icon(
            onPressed: () {},
            label: const Text('Plus One'),
            icon: const Icon(Icons.signal_wifi_statusbar_null),
          ),
        ),
      ])),
    );
  }
}

void _launchURL1() async {
  if (!await launch(_url1)) throw 'Could not launch $_url1';
}

void LAUNCHURL(URL) async {
  if (!await launch(URL)) throw 'Could not launch $_url2';
}
