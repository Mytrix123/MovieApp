import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/detail_page.dart';
import 'package:movie_app/models.dart';
import 'package:movie_app/place_holder.dart';
import 'package:movie_app/search_page.dart';
import 'package:movie_app/services.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<List<TopMovies>> dataTopMovie = ValueNotifier([]);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void initState() {
    isLoading.value = true;
    Services.fetchBestMovie().then((value) {
      isLoading.value = false;
      dataTopMovie.value = value!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _buildContent(),
    ));
  }

  Widget _buildContent() {
    return Column(
      children: [
        Container(
          width: 100.0.w,
          padding: EdgeInsets.symmetric(vertical: 3.0.w),
          child: Column(
            children: [
              Text(
                'Movie App',
                style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.0.w),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SearchPage()));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0.w, horizontal: 5.0.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black12)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 2.0.w,
                      ),
                      Text(
                        'Search Movie..',
                        style:
                            TextStyle(fontSize: 12.0.sp, color: Colors.black54),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, bool isLoad, _) {
              return isLoad
                  ? Expanded(
                      child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                      children: List.generate(8, (index) {
                        return PlaceHolder(
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 2.0.w,
                            ),
                            width: 90.0.w,
                            height: 30.0.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                          ),
                        );
                      }),
                    ))
                  : ValueListenableBuilder(
                      valueListenable: dataTopMovie,
                      builder: (context, List<TopMovies> data, _) {
                        return data.isEmpty
                            ? Container()
                            : Expanded(
                                child: ListView(
                                children: List.generate(data.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => DetailPage(
                                                    type: 0,
                                                    dataTop: data[index],
                                                  )));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3.0.w, horizontal: 5.0.w),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black12))),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 25.0.w,
                                            height: 40.0.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        data[index].image))),
                                          ),
                                          SizedBox(width: 3.0.w),
                                          Expanded(
                                              child: SizedBox(
                                                  width: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  data[index]
                                                                      .title,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12.0
                                                                              .sp,
                                                                      color: Colors
                                                                          .black87,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))),
                                                          SizedBox(
                                                              width: 3.0.w),
                                                          Text(
                                                            '#${data[index].rank}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    18.0.sp,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ],
                                                      ),
                                                      Text(
                                                          data[index].fullTitle,
                                                          style: TextStyle(
                                                            fontSize: 11.0.sp,
                                                            color:
                                                                Colors.black54,
                                                          )),
                                                      SizedBox(height: 3.0.w),
                                                      Text(
                                                        'Crew',
                                                        style: TextStyle(
                                                            fontSize: 12.0.sp,
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(data[index].crew,
                                                          style: TextStyle(
                                                            fontSize: 11.0.sp,
                                                            color:
                                                                Colors.black54,
                                                          )),
                                                      SizedBox(height: 3.0.w),
                                                      Text(
                                                        'Rating',
                                                        style: TextStyle(
                                                            fontSize: 12.0.sp,
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          SizedBox(
                                                              width: 1.0.w),
                                                          Text(
                                                            data[index].rating,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    13.0.sp,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                          ),
                                                          Text(
                                                            ' (${NumberFormat.currency(name: '', decimalDigits: 0, locale: 'id').format(int.parse(data[index].ratingCount))})',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    11.0.sp,
                                                                color: Colors
                                                                    .black54),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  )))
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ));
                      });
            })
      ],
    );
  }
}
