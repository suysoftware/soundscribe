import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:record/record.dart';
import 'package:sizer/sizer.dart';
import 'package:soundscribe/src/model/ChatGptModel.dart';
import 'package:soundscribe/src/services/OpenAiServices.dart';
import 'package:soundscribe/src/utils/audio_recorder.dart';

const backgroundColor = Color(0xff343541);
const botBackgroundColor = Color(0xff444654);

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  final record = Record();
  var audioPath = "";
  bool switchValueLanguage = false;
  bool switchValueQuestion = false;
  String? _parentMessageId;
  String? _conversationId;
  late bool isLoading;

  Future<void> setUserMessage() async {
    setState(() {
      _messages.add(ChatMessage(
          text: _textController.text, chatMessageType: ChatMessageType.user));
      _textController.clear();
    });
  }



  @override
  void initState() {
    super.initState();
    print(dotenv.env['OPEN_AI_API_KEY'].toString());
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    print('Language: ${switchValueLanguage ? 'English' : 'Turkish'}');
    print('Language ${switchValueQuestion?'Soru':'STT'}');
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 3,
            ),
            Text('Turkish'),
            CupertinoSwitch(
                activeColor: CupertinoColors.activeBlue,
                value: switchValueLanguage,
                onChanged: (value) {
                  setState(() {
                    switchValueLanguage = value;
                  });
                }),
            Text('English'),
            Spacer(
              flex: 1,
            ),
            Text('   |    '),
            Spacer(
              flex: 1,
            ),
            Text('Speech To Text'),
            CupertinoSwitch(
                activeColor: CupertinoColors.activeBlue,
                value: switchValueQuestion,
                onChanged: (value) {
                  setState(() {
                    switchValueQuestion = value;
                  });
                }),
            Text('Question'),
            Spacer(
              flex: 3,
            )
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildList(),
            ),
            Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _buildInput(),
                  _buildSubmit(),
                  _voiceRecorder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        color: botBackgroundColor,
        child: CupertinoButton(
          child: const Icon(
            CupertinoIcons.arrow_up_left,
            color: Color.fromRGBO(142, 142, 160, 1),
          ),
          onPressed: () async {
            setState(
              () {
                _messages.add(
                  ChatMessage(
                    text: _textController.text,
                    chatMessageType: ChatMessageType.user,
                  ),
                );
                isLoading = true;
              },
            );
            var input = _textController.text;
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
            var newMessage = await OpenAiServices.openAiQuestionRequest(input);
            setState(() {
              isLoading = false;
              _messages.add(
                ChatMessage(
                  text: newMessage.choices.first.text,
                  chatMessageType: ChatMessageType.bot,
                ),
              );
            });
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
          },
          /*onPressed: () async {
            await setUserMessage();
            
          },*/
        ),
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: CupertinoTextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: _textController,
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Widget _voiceRecorder() {
    return GestureDetector(
      child: Icon(CupertinoIcons.mic),
      onLongPress: () async {
        audioPath = (await AudioRecorder.audioRecordStart(record))!;
      },
      onLongPressEnd: (s) async {
        await AudioRecorder.audioRecordStop(record);
        var result =
            await OpenAiServices.audioSender(switchValueLanguage, audioPath);

        if (switchValueQuestion) {
          setState(() {
            isLoading = true;
            _messages.add(
              ChatMessage(
                text: result,
                chatMessageType: ChatMessageType.user,
              ),
            );
          });

          var answer = await OpenAiServices.openAiQuestionRequest(result);

          setState(() {
            isLoading = false;
            _messages.add(
              ChatMessage(
                text: answer.choices.first.text,
                chatMessageType: ChatMessageType.bot,
              ),
            );
          });
        } else {
          setState(() {
            isLoading = false;
            _messages.add(
              ChatMessage(
                text: result,
                chatMessageType: ChatMessageType.bot,
              ),
            );
          });
        }
      },
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {super.key, required this.text, required this.chatMessageType});

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16),
      color: chatMessageType == ChatMessageType.bot
          ? botBackgroundColor
          : backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(16, 163, 127, 1),
                    child: Image.asset(
                      'assets/images/bot.png',
                      color: Colors.white,
                      scale: 1.5,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: const CircleAvatar(
                    child: Icon(
                      Icons.person,
                    ),
                  ),
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(text, style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
