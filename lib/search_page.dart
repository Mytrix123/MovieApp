import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/detail_page.dart';
import 'package:movie_app/models.dart';
import 'package:movie_app/place_holder.dart';
import 'package:movie_app/services.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ValueNotifier<List<SearchMovie>> dataSearch = ValueNotifier([]);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  Timer? _debounce;

  searchMovieByTitle({required String query}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      isLoading.value = true;
      Services.searchMovie(query: query).then((value) {
        isLoading.value = false;
        dataSearch.value = value!;
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 5.0.w,
            top: 5.0.w,
          ),
          child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          width: 90.0.w,
          margin: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 3.0.w),
          child: TextField(
            onChanged: (value) {
              searchMovieByTitle(query: value.toLowerCase());
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 3.0.w),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Movie..',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
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
                      valueListenable: dataSearch,
                      builder: (context, List<SearchMovie> data, _) {
                        return data.isEmpty
                            ? Expanded(
                                child: Center(
                                  child: Text(
                                    'Data Is Empty',
                                    style: TextStyle(
                                        fontSize: 11.0.sp,
                                        color: Colors.black54),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView(
                                children: List.generate(data.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => DetailPage(
                                                    type: 1,
                                                    dataSearch: data[index],
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                      SizedBox(height: 5.0.w),
                                                      Text(data[index].title,
                                                          style: TextStyle(
                                                              fontSize: 12.0.sp,
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(data[index].desc,
                                                          style: TextStyle(
                                                            fontSize: 11.0.sp,
                                                            color:
                                                                Colors.black54,
                                                          )),
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
