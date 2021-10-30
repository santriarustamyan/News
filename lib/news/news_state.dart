import 'package:equatable/equatable.dart';
import 'package:task_for_pixaero/models/news_description.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitialState extends NewsState {}

class NewsDescriptionState extends NewsState {
  final List<NewsDescription> news;
  NewsDescriptionState({required this.news});

  @override
  List<Object> get props => [news];
}
