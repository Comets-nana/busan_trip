import 'package:flutter/material.dart';
import '../model/chatbot_model.dart';

class AiChatbotScreen extends StatefulWidget {
  @override
  _AiChatbotScreenState createState() => _AiChatbotScreenState();
}

class _AiChatbotScreenState extends State<AiChatbotScreen> {
  List<ChatbotModel> messages = [];
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 초기 인사 메시지
    messages.add(ChatbotModel(
      message: "방문해주셔서 감사합니다 :)",
      isUser: false,
    ));
    messages.add(ChatbotModel(
      message: "부산 여행에 대해 관심이 많으시군요!\n무엇을 도와드릴까요?\n\n"
          "1. 부산 인기 명소\n"
          "2. 부산에 가는 방법\n"
          "3. 부산에서 열리는 특별한 연중 이벤트\n"
          "4. 부산의 주요 랜드마크\n"
          "5. 맛집 추천\n"
          "6. 숙박 정보\n"
          "7. 교통 정보\n"
          "8. 쇼핑 정보\n"
          "9. 기타 문의",
      isUser: false,
    ));
  }

  void sendMessage(String message) {
    setState(() {
      messages.add(ChatbotModel(message: message, isUser: true));
      handleBotResponse(message);
    });
    messageController.clear();
  }

  void handleBotResponse(String message) {
    String response;

    switch (message) {
      case '1':
        response = '[부산 인기 명소 리스트]\n\n'
            '- 씨라이프 부산아쿠아리움\n'
            '- 해운대 해수욕장\n'
            '- 감천 문화 마을';
        break;
      case '2':
        response = '[부산에 가는 방법]\n\n'
            '<KTX 이용>\n서울역에서 부산역까지 약 2시간 30분 소요\n\n'
            '<고속버스 이용>\n전국 주요 도시에서 부산행 버스 운행';
        break;
      case '3':
        response = '[부산에서 열리는 특별한 연중 이벤트]\n\n'
            '- 부산 국제 영화제 (10월)\n'
            '- 부산 불꽃축제 (11월)\n'
            '- 해운대 빛 축제 (12월)';
        break;
      case '4':
        response = '[부산의 주요 랜드마크]\n\n'
            '- 광안대교\n'
            '- 부산 타워\n'
            '- 용두산 공원';
        break;
      case '5':
        response = '[부산의 맛집 추천]\n\n'
            '- 돼지국밥\n'
            '- 밀면\n'
            '- 씨앗호떡';
        break;
      case '6':
        response = '[부산의 숙박 정보]\n\n'
            '- 해운대 호텔\n'
            '- 광안리 게스트하우스\n'
            '- 서면 에어비앤비';
        break;
      case '7':
        response = '[부산의 교통 정보]\n\n'
            '- 지하철: 1호선, 2호선, 3호선, 4호선\n'
            '- 버스: 다양한 노선 운행\n'
            '- 택시: 기본요금 3,300원';
        break;
      case '8':
        response = '[부산의 쇼핑 정보]\n\n'
            '- 신세계 센텀시티\n'
            '- 롯데백화점 광복점\n'
            '- 남포동 국제시장';
        break;
      case '9':
        response = '기타 문의사항이 있으시면 질문해주세요!'; // 상담원 연결로 변경 고민
        break;
      default:
        response = '죄송합니다, 이해하지 못했습니다.\n번호를 다시 선택해주세요.';
    }

    setState(() {
      messages.add(ChatbotModel(message: response, isUser: false));
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('챗봇 종료'),
        content: Text('챗봇을 종료하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // "예" 버튼이 첫 번째로 나옴
            child: Text('예'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // "아니요" 버튼이 두 번째로 나옴
            child: Text('아니요'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Colors.white, // 배경색 변경
        padding: EdgeInsets.symmetric(horizontal: 14), // 전체 패딩 추가
        child: Column(
          children: [
            SizedBox(height: 60),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'AI 여행지 추천',
                style: TextStyle(
                  fontFamily: 'NotoSansKR',
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Align(
                    alignment: message.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: message.isUser ? Colors.blue[600] : Colors.blue[200],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomLeft: Radius.circular(message.isUser ? 15.0 : 0),
                          bottomRight: Radius.circular(message.isUser ? 0 : 15.0),
                        ),
                      ),
                      child: Text(
                        message.message,
                        style: TextStyle(
                          color: message.isUser ? Colors.white : Colors.black,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: "챗봇에게 물어볼 질문번호를 입력해주세요",
                          hintStyle: TextStyle(color: Colors.grey, fontFamily: 'NotoSansKR', fontWeight: FontWeight.w400),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      sendMessage(messageController.text);
                    },
                    child: Icon(Icons.send, color: Color(0xff0e4194)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
