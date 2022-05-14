import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Consts/consts.dart';
import 'package:news_app/Cubit/cubit.dart';
import 'package:news_app/Cubit/states.dart';
import 'package:news_app/Widgets/news_row_widget.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        List list = AppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: defaultFormField(
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  label: const Text('Search'),
                  prefix: const Icon(Icons.search),
                  onChanged: (value) {
                    if (value != ' '||value.isNotEmpty) {
                      AppCubit.get(context).getSearch(value);
                      print(value);
                    }
                  },
                ),
              ),
              Expanded(
                child: NewsRowWidget(
                  list: list,
                  isSearch: true,
                ),
              ),
            ],
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
