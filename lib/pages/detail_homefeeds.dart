import 'package:awesomeapp/models/homefeeds.dart';
import 'package:awesomeapp/styles/appbar.dart';
import 'package:awesomeapp/styles/homefeeds_description.dart';
import 'package:awesomeapp/widgets/feeds_image_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailHomeFeeds extends StatelessWidget {
  DetailHomeFeeds({
    Key key,
    this.photos,
  }) : super(key: key);

  final Photos photos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 515,
            pinned: true,
            title: Text(photos.photographer, style: appBarDetailFeedsStyle()),
            leading: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 33,
                    ),
                  ),
                ),
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              centerTitle: true,
              background: Hero(
                  tag: photos.id,
                  child: CachedNetworkImage(
                    maxHeightDiskCache: 500,
                    useOldImageOnUrlChange: false,
                    imageUrl: photos.src.large2x,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    placeholder: (context, url) => ImageFeedsShimmer(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                    ),
                  )

                  // Image.network(
                  //   photos.src.large2x,
                  //   fit: BoxFit.cover,
                  // ),
                  ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(17.0),
                child: Linkify(
                  onOpen: (link) async {
                    print("CHECK LINK");
                    print(link);
                    if (await canLaunch(link.url)) {
                      await launch(link.url);
                    } else {
                      throw 'Could not launch $link';
                    }
                  },
                  text: photos.photographer + " " + photos.photographerUrl,
                  textAlign: TextAlign.start,
                  style: descriptionFeedsStyle(),
                  linkStyle: descriptionLinkFeedsStyle(),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
