import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/presentation/state/request/request_state.dart';
import 'package:test_project/presentation/vm/request_view_model.dart';

import '../../presentation/event/request/request_event.dart';

class RequestFeedbackPage extends StatefulWidget {
  final int myIdx;

  const RequestFeedbackPage(this.myIdx, {super.key});

  @override
  State<RequestFeedbackPage> createState() => _RequestFeedbackPageState();
}

class _RequestFeedbackPageState extends State<RequestFeedbackPage> {
  late RequestViewModel _requestViewModel;
  late RequestState _requestState;

  late bool _isRequester;
  late double _score = 5.0;

  final _commentController = TextEditingController();

  late String _comment = "";

  @override
  Widget build(BuildContext context) {
    _requestViewModel = context.watch<RequestViewModel>();
    _requestState = _requestViewModel.requestState;

    _requestState.request!.requesterIdx == widget.myIdx ? _isRequester = true : _isRequester = false;

    Logger().d("###${_requestState.request!.workCategoryIdx}");
    return Scaffold(
      appBar: AppBar(
        title: Text("심부름 후기 작성"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Color(0xffE9E9E9),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "asset/icons/icon_${(_requestState.request!.workCategoryIdx + 1).toString().padLeft(2, '0')}.svg",
                    height: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "진행한 심부름",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(_requestState.request!.title),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  Text(
                    _isRequester ? "${_requestState.request!.workerName}님이 진행한 심부름은 마음에 드셨나요?" : "${_requestState.request!.requesterName}님이 요청한 심부름은 어떠셨나요?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "별점으로 리뷰를 남겨주세요.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ClipOval(
                    child: Image.network(
                      "http://${_isRequester ? _requestState.request!.workerImgUrl : _requestState.request!.requesterImgUrl}",
                      cacheWidth: 1080,
                      width: 60,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RatingBar.builder(
                    initialRating: 5,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      size: 24,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (value) {
                      setState(() {
                        _score = value;
                      });
                      Logger().d("$value, $_score");
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${_score.toInt()}", style: const TextStyle(color: Color(0xffF8A239))),
                      const Text("/5"),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Color(0xffE9E9E9)))),
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "별점의 이유를 남겨주세요",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "작성한내용은 프로필에서 확인 할 수 있습니다.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    onChanged: (value) {
                      Logger().d(value);
                      setState(() {
                        _comment = value;
                      });
                    },
                    controller: _commentController,
                    decoration: InputDecoration(border: OutlineInputBorder(), label: Text("후기를 10자 이내로 작성해 주세요")),
                    maxLines: 5,
                    maxLength: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          GestureDetector(
            onTap: _comment.trim() != ""
                ? () async {
                    String fromIdx;
                    String toIdx;
                    Logger().d("review create ### $_comment");
                    if (_isRequester) {
                      fromIdx = _requestState.request!.requesterIdx.toString();
                      toIdx = _requestState.request!.workerIdx.toString();
                    } else {
                      fromIdx = _requestState.request!.workerIdx.toString();
                      toIdx = _requestState.request!.requesterIdx.toString();
                    }
                    await _requestViewModel
                        .onRequestEvent(RequestEvent.createRequestReview(_requestState.request!.idx.toString(), fromIdx, toIdx, _score, _comment))
                        .then((value) => Navigator.of(context).pop(true));
                  }
                : null,
            child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: _comment.trim() != "" ? Color(0xffF8A239) : Color(0xffE9E9E9),
              ),
              child: Text(
                "리뷰 작성하기",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
