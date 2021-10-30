import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_for_pixaero/class/news_repository.dart';
import 'package:task_for_pixaero/models/news_description.dart';
import 'package:task_for_pixaero/news/news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  NewsRepository get newsRepository => _newsRepository;
  NewsRepository _newsRepository = NewsRepository();

  Future<void> getNews() async {
    final List<NewsDescription> _news = await newsRepository.getNews();

    emit(NewsDescriptionState(news: _news));
  }
}
