import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librayproject/screens/books/logic/home_cubit.dart';
import 'package:librayproject/screens/books/views/bookscreen.dart';
import 'package:librayproject/screens/books/views/booksgrid.dart';
import 'package:librayproject/screens/books/widgets/customlistview.dart';
import 'package:librayproject/screens/books/widgets/customnavigator.dart';
import 'package:librayproject/screens/books/widgets/customrows.dart';
import 'package:librayproject/screens/books/widgets/homeslider.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF2e354e),
            child: BlocProvider(
              create: (context) => HomeCubit()
                ..getbanners()
                ..getallBooks()
                ..getrecoBooks(),
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 15),
                              // User widget
                              const Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4CRKPij6o2waFROp-89BCE8lEf96jLsndRQ&s',
                                    ),
                                    radius: 25,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Welcome',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    CupertinoIcons.bell_solid,
                                    color: Color(0xFFDF674D),
                                    size: 30,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 60),
                              // Ad showcase
                              const HomeSlider(),
                              const SizedBox(height: 35),
                              // Text row custom
                              CustomRow(
                                title: 'Popluar',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const BooksScreen(
                                        listType: ListType2.all,
                                      );
                                    }),
                                  );
                                },
                              ),
                              const SizedBox(height: 15),
                              const SizedBox(
                                height: 160,
                                child: CustomListView(
                                  listType: ListType.all,
                                ),
                              ),
                              const SizedBox(height: 35),
                              // Text row custom 2
                              CustomRow(
                                title: 'Recommendation',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const BooksScreen(
                                        listType: ListType2.recommended,
                                      );
                                    }),
                                  );
                                },
                              ),
                              const SizedBox(height: 15),
                              const SizedBox(
                                height: 160,
                                child: CustomListView(
                                  listType: ListType.recommended,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Customnavigator(),
        ],
      ),
    );
  }
}
