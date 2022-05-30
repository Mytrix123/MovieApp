import 'package:flutter/material.dart';
import 'package:movie_app/models.dart';
import 'package:movie_app/place_holder.dart';
import 'package:movie_app/services.dart';
import 'package:sizer/sizer.dart';

class DetailPage extends StatefulWidget {
  final TopMovies? dataTop;
  final SearchMovie? dataSearch;
  final int type;
  const DetailPage(
      {Key? key, required this.type, this.dataTop, this.dataSearch})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ValueNotifier<List<Reviews>> dataReviews = ValueNotifier([]);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void initState() {
    isLoading.value = true;
    Services.reviewsMovie(
            id: widget.type == 0 ? widget.dataTop!.id : widget.dataSearch!.id)
        .then((value) {
      isLoading.value = false;
      dataReviews.value = value!;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        foregroundColor: Colors.black87,
        title: Text(
          widget.type == 0 ? widget.dataTop!.title : widget.dataSearch!.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 5.0.w,
          ),
          Center(
            child: Container(
              width: 40.0.w,
              height: 60.0.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.type == 0
                          ? widget.dataTop!.image
                          : widget.dataSearch!.image))),
            ),
          ),
          SizedBox(height: 5.0.w),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Text(
                widget.type == 0
                    ? widget.dataTop!.title
                    : widget.dataSearch!.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 3.0.w),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Text(
                widget.type == 0
                    ? widget.dataTop!.fullTitle
                    : widget.dataSearch!.desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0.w),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: Text(
              'Reviews',
              style: TextStyle(
                  fontSize: 13.0.sp,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, bool isLoad, _) {
                return isLoad
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                        child: Column(
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
                        ),
                      )
                    : ValueListenableBuilder(
                        valueListenable: dataReviews,
                        builder: (context, List<Reviews> data, _) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                            child: Column(
                              children: List.generate(data.length, (index) {
                                return Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 3.0.w),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black12))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            SizedBox(width: 1.0.w),
                                            Text(
                                              data[index].rate.toString(),
                                              style: TextStyle(
                                                  fontSize: 13.0.sp,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 2.0.w),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                data[index].username,
                                                style: TextStyle(
                                                    fontSize: 12.0.sp,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(width: 3.0.w),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 1.0.w,
                                                horizontal: 3.0.w,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color:
                                                      data[index].warningSpoiler
                                                          ? Colors.orange
                                                          : Colors.green),
                                              child: Text(
                                                data[index].warningSpoiler
                                                    ? 'Spoiler'
                                                    : 'No Spoiler',
                                                style: TextStyle(
                                                    fontSize: 8.0.sp,
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 3.0.w),
                                        Text(
                                          data[index].title,
                                          style: TextStyle(
                                              fontSize: 11.0.sp,
                                              color: Colors.blue),
                                        ),
                                        SizedBox(height: 1.0.w),
                                        Text(
                                          data[index].desc,
                                          style: TextStyle(
                                              fontSize: 11.0.sp,
                                              color: Colors.black87),
                                        ),
                                        SizedBox(
                                          height: 3.0.w,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 4,
                                              child: Text(
                                                data[index].date,
                                                style: TextStyle(
                                                    fontSize: 11.0.sp,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                            SizedBox(width: 2.0.w),
                                            Flexible(
                                              flex: 6,
                                              child: Text(
                                                data[index].helpfull,
                                                style: TextStyle(
                                                    fontSize: 11.0.sp,
                                                    color: Colors.black54),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ));
                              }),
                            ),
                          );
                        });
              })
        ],
      ),
    );
  }
}
