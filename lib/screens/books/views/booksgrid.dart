import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librayproject/screens/books/logic/home_cubit.dart';
import 'package:librayproject/screens/books/views/bookinfo.dart';
import 'package:librayproject/screens/books/widgets/customnavigator.dart';

class Booksgrid extends StatelessWidget {
  const Booksgrid({super.key, required this.q});

  final String q;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
          color: Color(0xFF2e354e),
          child:
          BlocProvider(
            create: (context) => HomeCubit()..getqBooks(q),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                var cubit = HomeCubit.get(context);
                return (state is HomeLoading)
                    ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
                    :SafeArea(
                    child: GridView.builder(
                      shrinkWrap: false,
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: cubit.qbooks.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  cubit.qbooks[index].image!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 250,
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return BookInfo(id: cubit.qbooks[index].id!);
                                      }),
                                    );
                                  },
                                  child: Text(
                                    'More',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFDF674D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                );
              },
            ),
          ),
          ),
          Customnavigator(),
        ],
      ),
    );
  }
}
