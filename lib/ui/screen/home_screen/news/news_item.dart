import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/Articles.dart';
import 'package:news_app/ui/utilites/data_time_extension.dart';

import '../../../utilites/app_colors.dart';

class NewsItem extends StatelessWidget {
  News news;

  NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              errorWidget: (context, url, error) => const Icon(Icons.error),
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
          )
        ],
      ),
    );
  }
}
