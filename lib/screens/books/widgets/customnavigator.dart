import 'package:flutter/material.dart';
import 'package:librayproject/screens/books/views/booksgrid.dart';
import 'package:librayproject/screens/books/views/homescreen.dart';

class Customnavigator extends StatelessWidget {
  const Customnavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 20,
        left: 30,
        child: Container(
          width: 350,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xFF414966),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Booksgrid(q: 'Science');
                      }),
                    );
                  },
                  icon: Icon(Icons.science),
                  color: Color(0xFFDF674D)),
              SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Booksgrid(q: 'Programming');
                      }),
                    );
                  },
                  icon: Icon(Icons.code),
                  color: Color(0xFFDF674D)),
              SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Homescreen();
                    }),
                  );
                },
                icon: Icon(Icons.home),
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Booksgrid(q: 'Business');
                      }),
                    );
                  },
                  icon: Icon(Icons.business),
                  color: Color(0xFFDF674D)),
              SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Booksgrid(q: 'FreeBooks');
                      }),
                    );
                  },
                  icon: Icon(Icons.book),
                  color: Color(0xFFDF674D)),
            ],
          ),
        ));
  }
}
