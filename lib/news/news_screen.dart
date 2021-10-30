import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_for_pixaero/models/news_description.dart';
import 'news_cubit.dart';
import 'news_state.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late List<NewsDescription> _newsDescription = [];

  late NewsCubit _newsCubit;
  @override
  void initState() {
    super.initState();
    _newsDescription = [];
    _newsCubit = NewsCubit();
    _newsCubit.getNews();
  }

  @override
  void dispose() {
    _newsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCubit>(
        create: (context) {
          return _newsCubit;
        },
        child: BlocListener<NewsCubit, NewsState>(
          listener: _blocListner,
          child: _build(context),
        ));
  }

  void _blocListner(context, state) {
    if (state is NewsDescriptionState) {
      _newsDescription = state.news;
      setState(() {});
    }
  }

  Widget _build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 80,
            bottom: 40,
          ),
          child: Column(
            children: [
              for (var i = 0; i < _newsDescription.length; i++) _viewNews(i),
            ],
          ),
        ),
      ]),
    ));
  }

  Widget _viewNews(i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              _newsDescription[i].urlToImage!,
              fit: BoxFit.cover,
              height: 70.0,
              width: 70.0,
            ),
          ),
          title: Text(_newsDescription[i].title!,
              style: TextStyle(
                color: Colors.black,
              )),
        ),
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.purple,
          borderRadius: BorderRadius.circular(10),
          gradient: new LinearGradient(
              colors: [Color(0xffEE9CA7), Color(0xffFFDDE1)],
              begin: Alignment.centerRight,
              end: new Alignment(-1.0, -1.0)),
        ),
      ),
    );
  }
}
