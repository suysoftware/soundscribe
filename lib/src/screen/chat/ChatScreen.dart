import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';
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
  late ChatGPTApi _api;
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

  Future<ChatGptModel> generateResponse(String prompt) async {
    const openAIKey = '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';
    const endpoint = 'https://api.openai.com/v1/completions';
    var client = http.Client();
    var uri = Uri.parse(endpoint);
    var payload = jsonEncode({
      "model": "text-davinci-003",
      "prompt": prompt,
      "temperature": 0,
      "max_tokens": 200
    });
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $openAIKey",
    };
    var response = await client.post(
      uri,
      headers: header,
      body: payload,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var cgptModel = chatGptModelFromJson(response.body);
      return cgptModel;
    } else {
      throw Exception('Failed to generate response.');
    }
  }

  @override
  void initState() {
    super.initState();
    _api = ChatGPTApi(
      sessionToken:
          "eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIn0..a4KpaCS0Ry1wUWES.45ZHyv46xXUwwAX7q8ZSjt0gPxdGPNgLsZed1Fj5Trr-Oc-anrMA-X-_SeAxCDrmGrf_wJgL25ljYbLTC4LxrMqYsc3wAqwKorNx1zfG6F8Wgo_LwGTz2Pm2c7ZFNZRUkPgINc6ehMM4_ihGoC20Vix33IzbWH58jj8db6kXTICxaXE0uAdINrzIJJwOi0e0Rn-OM6RiFLzzFNty0gJeB6L6xxd2uJJzacpof-bZ33aIMjPEsURC-nAY2-elRRO-Aqi2xDte-n4xgPUgk1L_QQDQVfBwlvJA_DBayGieL6p7w1MwjoGDa9XOIB-dZJcVWLOX6FBExFIa3PcSMyBH53PsOlGke3fnlem-nAicqiFV7fPOezOcWxJyWsBtz1qXlv88AWLrtv4g7VdHobSyLGxeQhAA8I4ZBjM4PtfKLlJNKM6NxmFK0YeuBsW5mRb3fLO8yV-4pZVPL8JImB5fLHvzQiiXx9Rl9FeycKYAohGt3OZT7KLZ5AaOgRMo7wTa5WiWmgUe44QoL4PGjojmCFq3WPIt29xq2tw3JWtIekiTilWXi-FIAtzhZggvB6mMrTXTteL5Ky-NE43VngsU4qO3fvnNUbDdC5qVnICjaP1Cl2wjVSrXI-DBWuwmiwNU0wHTd_S1GRQp_lR1m00YLj1So0Rb63Iy4oyRwj4RJGosf88pb7e0iiLjo90E_1LA4KNy1ZOC9VocpmuFVi1xT6I4KCPB7Q0iaUmZGgjcn-n05SzzIpswhQfjucAFWq-p6CY4mU6wuUYDxNhOyihzUNcG9XIJWSdOfSDThZ9W0qyYMchBERb9W5Qnp2pTgvqS8by46oY-gXiVPbJ2Nwkz2Ohv-eV8Pnv2DkKRH4c6T96KfzQyyGnD7CJt3D72-HcBCbLn1K8534Gugtix0dOdQKYWFQKarKcyBMxw2yjdVRB-8540ZadoNBQdR2zH56b-USICHuMSThtFBA_hEn3vOjdJMzKD5TV3inlgEYUEhWM-kf84aL5WpfmDdW77Y4wXNyu5c0XiO2o7Uargk0F6u28HadFPHsSNS4ozo1K4O-hMwg5CBw1kb4jZ4hQsMNSdx6PNpi15KMi9t7bGRzcMPVnBKpwbRgnaXvnWqaHmNai3Qyiu0kosEyV48elLbWPg1ruLp-QLl4EeSNAtZ6lTHopGrUl5yaL6LIEGYDugRV8omDxEFukRlmRHs6SBXyeE-EJuS7XIlIk4uNhD5_1tvXnYl5pgJ6IM3BX0MTEiS8VoQk7shU2OCznk6LEri0Ay9mu_9l6JM56T8eozTHOHgfMspRBNBW9mOrZ3SzztHSSasdwcKXt4N2Rie-iX959ty2W5n2kED52dk8o_00zz3bULs7d0c4qjveqwxz6eORzgjwuHX-18z9VTJ8PM3oh7w83Qq46grCCYrB6rTaH_x2Br204HFolTjYOiUhyxYn35QgqgoqGDayLOdYxI2dUtiuSXV_Uvgicq9sL6Ypp7PGCKtZRAXttopN5hxfjbj4bkwdwhQzmLIwiMlI-IfadVFTdXi11wGq8atzxfVNXLBuEoh4_GCoX2oNK-wSIw1HfxCFmfelCpYGmnttWJUD48RMB4S_2KJXBzMCmR9oNX7bZJ2XUh_7DqCzxv_B11gupcLnFtu-Sn3oIAhbyHNhjZMqwe6RGNjCg89rNbNoqwVMUSsg6WSspC_XSUEnfcx5IsbYnVQaSszMsvKJ27cI4Y9ZD8wZeg19YiejzD9RUhFJJOq5-ZxZDP_r2fihaKYDQluBBs93xE5GeLZFc7o7TCOcZt3GOnqlOrHiMR3xdXzlHXrgOJyEuOGNja4LGRgMbSWFa8640T3Eeo1fNfBMbm2LRbPZ6x_mY5krrI4gCd51DFa-apnP3HhWUoaW5Zpwk8NkwvdbycR8r2vgvFfrTTA9XWHnE8kDUpeSIu4k5vOV1zkLJPICk5wzhGrLtN7phomC-ZPY9XDgp9Ow2dsqzgNBoM8aEPoEvJhowXfMxtybQ3zEEDVP0NXt92hTRMUoGtks4LR7BhD-iJ_mGeu5ulR5FXHdgBZZMrANpMTOU3we2xqZ-0Cl-l6f7_yWZ1Y0mlGbKawlFfPDT7jbfTtPW7C0zESCypq23x3VoMEw-J6DdphxQTWO4xOLYNGLsQbRAYhKbTJGpZFI_MgaZY0c8Vjch9k8fFSLkUTNu4tuHAfs2jroDi016WGeA176olbzS3i5rTmAice2S1rDtjeAIBQd2yRMulevLAgJu6E-O0sc-_5bkcz46CQjzbUsxbS-fR7g15idI-bQ2QjRQy9Fb0v_CzH3mr9Aq4QPpZL_aSpe_frIVEFPVQAmF9lnbsR_VMTvCgBlRHt3MCooSP-EdwMaOmacVYiSC9NfdaWAnf62qPP2PhboyPLiZ3fPocCYAhgxbM7YtA3CGCyy00C5eBm3bhLnNLySyQGmHO9l_N3dKxPn5eZinySS4rIRRkdhZaUBpfygujiH27p5jtivIbD0hylKlS7h4oI0DWHpbQ811rbKShnpjZri9GD6DCTIM.bYRH4v3zZqt50o3v8oMcVg",
      clearanceToken:
          "dZFHAUodm5cjBzn6aham1hXeveVMJ8HxM8vmnQPLRy4-1677960337-0-1-f14c6b06.f29c2655.192061b8-160",
    );
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
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
            var newMessage = await generateResponse(input);
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


          var answer = await generateResponse(result);


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
