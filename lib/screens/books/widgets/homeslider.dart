import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librayproject/screens/books/logic/home_cubit.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({Key? key}) : super(key: key); // Corrected constructor

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return (state is HomeLoading)
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        )
            : CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            aspectRatio: 16 / 9,
            viewportFraction: 1.5,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
          items: cubit.banner.map((i) {
            return i.image != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(
                  20.0), // Adjust the radius as needed
              child: Image.network(
                i.image!,
                height: 200,
                width: 380,
                fit: BoxFit.cover,
              ),
            )
                : Container(
              color: Colors.grey.shade200,
            );
          }).toList() ??
              [], // Added null check for cubit.banner and default empty list
        );
      },
    );
  }
}
