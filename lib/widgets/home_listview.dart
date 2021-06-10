import 'package:awesomeapp/pages/detail_homefeeds.dart';
import 'package:awesomeapp/provider/homepage.dart';
import 'package:awesomeapp/styles/homefeeds_description.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'feeds_image_shimmer.dart';

class ListViewHome extends StatelessWidget {
  const ListViewHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageProvider>(
      builder: (_, prov, ch) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => new DetailHomeFeeds(
                        photos: prov.listHomeFeeds[index],
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      maxHeightDiskCache: 500,
                      useOldImageOnUrlChange: false,
                      imageUrl: prov.listHomeFeeds[index].src.original,
                      fit: BoxFit.cover,
                      width: 99,
                      height: 99,
                      placeholder: (context, url) => Center(
                        child: ImageFeedsShimmer(),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                      ),
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Flexible(
                      child: Linkify(
                        overflow: TextOverflow.fade,
                        onOpen: (link) async {
                          print("CHECK LINK");
                          print(link);
                          if (await canLaunch(link.url)) {
                            await launch(link.url);
                          } else {
                            throw 'Could not launch $link';
                          }
                        },
                        text: prov.listHomeFeeds[index].photographer +
                            " " +
                            prov.listHomeFeeds[index].photographerUrl,
                        textAlign: TextAlign.start,
                        style: descriptionFeedsStyle(),
                        linkStyle: descriptionLinkFeedsStyle(),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          childCount: prov.countListHomeFeeds,
        ),
      ),
    );
  }
}
