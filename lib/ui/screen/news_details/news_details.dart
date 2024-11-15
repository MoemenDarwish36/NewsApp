import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/Articles.dart';
import 'package:news_app/ui/utilites/data_time_extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../category/category_model.dart';
import '../../utilites/app_assets.dart';
import '../../utilites/app_colors.dart';
import '../home_screen/drawer/home_drawer.dart';

class NewsDetails extends StatelessWidget {
  static const String routeName = 'newsDetails';

  int selectSideMenuItem = HomeDrawer.categories;
  CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    var news = ModalRoute.of(context)!.settings.arguments as News;
    return Stack(
      children: [
        Container(
          color: AppColors.whiteColor,
          child: Image.asset(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              AppAssets.background),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'News Title',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: news.urlToImage ?? '',
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .3,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryLightColor,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  news.author ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(news.title ?? '',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  DateTime.parse(news.publishedAt ?? '').toFormattedDate,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.end,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(news.content ?? ''),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    _launchUrl(news.url ?? '');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('View Full Article'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
