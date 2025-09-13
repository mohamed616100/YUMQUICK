import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/features/search/data/models/search_cubit.dart';
import 'package:yumquick/features/search/data/models/search_state.dart';
import 'package:yumquick/features/search/views/searche_item.dart';

class SearchItemListview extends StatelessWidget {
  const SearchItemListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return Center(child: CircularProgressIndicator());
        }else if(state is SearchError){
          return Center(child: Text(state.error));
        }else if(state is SearchSuccess){
          return  Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return SearcheItem(
                product: state.data[index],
              );
            }, itemCount: state.data.length,),
          );
        }else{
          return Container();
        }
      },
    );
  }
}
