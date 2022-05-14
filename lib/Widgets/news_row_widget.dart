import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Screens/web_view_screen.dart';

class NewsRowWidget extends StatelessWidget {
  final List list;

  final bool? isSearch;

  NewsRowWidget({required this.list, this.isSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ConditionalBuilder(
        builder: (BuildContext context) =>
            ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (ctx, index) =>
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WebViewScreen(
                                url: list[index]['url'],
                              ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 120,
                      child: Row(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image(
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    'assets/image.png',
                                    fit: BoxFit.cover,
                                  ),
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                '${list[index]['urlToImage']}',
                              ),
                              // loadingBuilder: ( context,
                              //      child,
                              //     loadingProgress,)=>Image.asset(
                              //   'assets/image.png',
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${list[index]['title']}',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .copyWith()
                                        .bodyText1,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  '${list[index]['publishedAt']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              separatorBuilder: (ctx, index) =>
                  Container(
                    color: Colors.grey,
                    height: 1,
                    width: double.infinity,
                    margin: const EdgeInsets.all(15),
                  ),
              itemCount: list.length,
            ),
        condition: list.isNotEmpty,
        fallback: (BuildContext context) =>
        isSearch == true
            ? Container()
            : const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
