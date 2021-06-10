import 'package:awesomeapp/pages/detail_homefeeds.dart';
import 'package:awesomeapp/provider/homepage.dart';
import 'package:awesomeapp/styles/homefeeds_description.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'feeds_image_shimmer.dart';

class GridViewHome extends StatelessWidget {
  const GridViewHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageProvider>(
      builder: (_, prov, ch) => SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 333.0,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
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
                  child: Hero(
                    tag: prov.listHomeFeeds[index].id,
                    child: Card(
                      margin: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 5,
                        top: 33,
                      ),
                      child: Container(
                        height: 212,
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                          maxHeightDiskCache: 200,
                          // useOldImageOnUrlChange: false,
                          imageUrl: prov.listHomeFeeds[index].src.medium,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          placeholder: (context, url) => Center(
                            child: ImageFeedsShimmer(),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                      left: 15,
                      right: 9,
                    ),
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
                      text: prov.listHomeFeeds[index].photographer +
                          " " +
                          prov.listHomeFeeds[index].photographerUrl,
                      textAlign: TextAlign.start,
                      style: descriptionFeedsStyle(),
                      linkStyle: descriptionLinkFeedsStyle(),
                    ),
                  ),
                ),
              ],
            );
          },
          childCount: prov.countListHomeFeeds,
        ),
      ),
    );
  }
}
