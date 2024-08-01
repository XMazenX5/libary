import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librayproject/screens/books/logic/home_cubit.dart';
import 'package:librayproject/screens/books/views/bookinfo.dart';
import 'package:librayproject/screens/books/widgets/customnavigator.dart';

enum ListType2 { all, recommended }

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key, required this.listType});
  final ListType2 listType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getallBooks()..getrecoBooks(),
      child: Scaffold(
        backgroundColor: const Color(0xFF2e354e),
        appBar: AppBar(
          backgroundColor: Color(0xFF2e354e),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  } else if (state is HomeSuccess) {
                    var cubit = HomeCubit.get(context);
                    var books = listType == ListType2.all ? cubit.allbooks : cubit.recobooks;
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (context, index) {
                              if (index >= books.length) {
                                return SizedBox.shrink(); // Prevent index out of range errors
                              }

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BookInfo(id: books[index].id!);
                                      },
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: const Color(0xFF414966),
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            books[index].image!,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 150,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                books[index].name!,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                books[index].author!,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFCDF674D),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      books[index].description!,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      maxLines: 3,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      var result = books[index].buyLink;
                                                      if (result != null) {
                                                        await HomeCubit.launchUrls(result);
                                                      } else {
                                                        debugPrint('Buy link is not available');
                                                      }
                                                    },
                                                    child: const Text(
                                                      'Buy',
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: const Color(0xFFDF674D),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 10);
                            },
                            itemCount: books.length,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Failed to load books',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                },
              ),
            ),
            const Customnavigator(),
          ],
        ),
      ),
    );
  }
}
