import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librayproject/screens/books/logic/home_cubit.dart';

enum ListType { all, recommended }

class CustomListView extends StatelessWidget {
  const CustomListView({super.key, required this.listType});
  final ListType listType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var books = listType == ListType.all ? cubit.allbooks : cubit.recobooks;
        return(state is HomeLoading)
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        )
            : SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                height: 120,
                margin: const EdgeInsets.only(left: 0, right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    books[index].image!,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 20);
            },
            itemCount: books.length,
          ),
        );
      },
    );
  }
}

