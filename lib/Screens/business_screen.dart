import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Cubit/cubit.dart';
import 'package:news_app/Cubit/states.dart';
import 'package:news_app/Widgets/news_row_widget.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        List list = AppCubit.get(context).business;
        return NewsRowWidget(list: list,);
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
