import 'package:flutter/material.dart';
import 'package:segi_tv/detailed_screen.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';

import 'color.dart';


class RSSDemo extends StatefulWidget {
  RSSDemo() : super();

  final String title = 'Wotter News';

  @override
  RSSDemoState createState() => RSSDemoState();
}

class RSSDemoState extends State<RSSDemo> {
  static const String FEED_URL = 'https://media.livecast365.com/segi1/segitv/feed/feed.Xml';
  RssFeed _feed;
  String _title;
  static const String loadingFeedMsg = 'Loading Feed...';
  static const String feedLoadErrorMsg = 'Error Loading Feed.';
  static const String feedOpenErrorMsg = 'Error Opening Feed.';
  static const String placeholderImg = 'assets/';
  GlobalKey<RefreshIndicatorState> _refreshKey;
  VideoPlayerController _controller;

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
      return;
    }
    updateTitle(feedOpenErrorMsg);
  }

  load() async {
    updateTitle(loadingFeedMsg);
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        updateTitle(feedLoadErrorMsg);
        return;
      }
      updateFeed(result);
      updateTitle('Movies and TV Shows');
    }).catchError((onError) => {print(onError)});
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(FEED_URL);
      return RssFeed.parse(response.body);
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    load();
  }


  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subtitle(subTitle) {
    return Text(
      subTitle,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  thumbnail(imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: CachedNetworkImage(
        placeholder: (context, url) => Image.asset(placeholderImg),
        imageUrl: imageUrl,
        height: 50,
        width: 70,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }

  rightIcon() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: Colors.grey,
      size: 30.0,
    );
  }

  list() {
    return ListView.builder(
      itemCount: _feed.items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed.items[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Card( 
              elevation: 5.0,  
               child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailedScreen(item.link, item.title, item.description, item.media.thumbnails[0].url,item.media.contents[0].url)));
                      },
                      child: Image.network(
                        item.media.thumbnails[0].url,
                      //  item.media.contents[0].url,
                        height: 300,
                        // fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                              fontSize: 26.0, fontWeight: FontWeight.w900),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        Text(
                          item.media.category.value,
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.w700),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ],
                )
              ],
            )),
          ),
        );
      },
    );
  }

  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  body() {
    return isFeedEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: list(),
            onRefresh: () => load(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
         title: new Text(_title),
        leading: Builder(
    builder: (BuildContext context) {
      return Icon(Icons.donut_large, color: kPrimaryColor);
    },
  ),
      ),
      body: body(),
    );
  }
}
