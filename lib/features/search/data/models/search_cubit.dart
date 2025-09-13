import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/features/search/data/models/search_state.dart';
import 'package:yumquick/features/search/data/repos/repo_search.dart';


class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());


  static SearchCubit get(context) => BlocProvider.of(context);

  Future<void> onSearch({
    required String q,
}) async {
    emit(SearchLoading());
    final searchRepo = SearchRepo();

    final response = await searchRepo.search(q: q);

    response.fold(
          (error) => emit(SearchError(error: error)),
          (data) => emit(SearchSuccess(data: data)),
    );
  }
}
