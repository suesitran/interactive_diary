import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:interactive_diary/features/home/data/diary_display_content.dart';

part 'diary_detail_state.dart';

class DiaryDetailCubit extends Cubit<DiaryDetailState> {
  DiaryDetailCubit() : super(DiaryDetailInitial());
  void loadDiaryDetail() async {
    int timeStamp = 1683310211667;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);

    var textJson = [
      {
        'insert':
            'Steak anchovies parmesan ipsum white ipsum personal string platter. White platter ipsum ',
        'attributes': {'italic': true}
      },
      {
        'insert':
            'lasagna wing style ricotta. Bell white thin platter thin bacon Chicago. '
      },
      {
        'insert': 'Mayo sausage NY green lasagna Aussie deep roll bacon. ',
        'attributes': {'bold': true, 'italic': true, 'underline': true}
      },
      {
        'insert':
            'Ricotta thin and large pork lovers. Dolor pizza personal green broccoli green Aussie pesto melted black. Banana broccoli spinach meat meat sautéed bell. '
      },
      {
        'insert':
            'Pesto bacon pepperoni sausage wing mozzarella. Pie mayo meat pesto and pepperoni dolor dolor thin.',
        'attributes': {'background': '#2f89eb', 'color': '#faa49e'}
      },
      {'insert': '\n\n'},
      {
        'insert': 'Lorem ipsum dolor sit amet',
        'attributes': {'color': '#0fabe2'}
      },
      {'insert': '\n'},
      {
        'insert':
            'Consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
        'attributes': {'color': '#0fabe2'}
      },
      {'insert': '\n\n'},
      {
        'insert':
            'Steak anchovies parmesan ipsum white ipsum personal string platter. White platter ipsum ',
        'attributes': {'italic': true}
      },
      {
        'insert':
            'lasagna wing style ricotta. Bell white thin platter thin bacon Chicago. '
      },
      {
        'insert': 'Mayo sausage NY green lasagna Aussie deep roll bacon. ',
        'attributes': {'bold': true, 'italic': true, 'underline': true}
      },
      {
        'insert':
            'Ricotta thin and large pork lovers. Dolor pizza personal green broccoli green Aussie pesto melted black. Banana broccoli spinach meat meat sautéed bell. '
      },
      {
        'insert':
            'Pesto bacon pepperoni sausage wing mozzarella. Pie mayo meat pesto and pepperoni dolor dolor thin.',
        'attributes': {'background': '#2f89eb', 'color': '#faa49e'}
      },
      {'insert': '\n\n'},
      {
        'insert': 'Lorem ipsum dolor sit amet',
        'attributes': {'color': '#0fabe2'}
      },
      {'insert': '\n'},
      {
        'insert':
            'Consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
        'attributes': {'color': '#00eeff'}
      },
      {'insert': '\n\n'},
      {
        'insert':
            'lasagna wing style ricotta. Bell white thin platter thin bacon Chicago. '
      },
      {
        'insert': 'Mayo sausage NY green lasagna Aussie deep roll bacon. ',
        'attributes': {'bold': true, 'italic': true, 'underline': true}
      },
      {
        'insert':
            'Ricotta thin and large pork lovers. Dolor pizza personal green broccoli green Aussie pesto melted black. Banana broccoli spinach meat meat sautéed bell. '
      },
      {
        'insert':
            'Pesto bacon pepperoni sausage wing mozzarella. Pie mayo meat pesto and pepperoni dolor dolor thin.',
        'attributes': {'background': '#2f89eb', 'color': '#faa49e'}
      },
      {
        'insert':
            'Steak anchovies parmesan ipsum white ipsum personal string platter. White platter ipsum ',
        'attributes': {'italic': true}
      },
      {
        'insert':
            'lasagna wing style ricotta. Bell white thin platter thin bacon Chicago. '
      },
      {
        'insert': 'Mayo sausage NY green lasagna Aussie deep roll bacon. ',
        'attributes': {'bold': true, 'italic': true, 'underline': true}
      },
      {
        'insert':
            'Ricotta thin and large pork lovers. Dolor pizza personal green broccoli green Aussie pesto melted black. Banana broccoli spinach meat meat sautéed bell. '
      },
      {'insert': '\n\n'},
    ];
    Document? document = Document.fromJson(textJson);
    String plainText = document.toPlainText();
    QuillController richText = QuillController(
        document: document,
        selection: const TextSelection.collapsed(offset: 0));
    String userDisplayName = 'Hoang Nguyen';
    String userPhotoUrl =
        'https://lh3.googleusercontent.com/a-/AOh14GikSAp8pgWShabZgY2Pw99zzvtz5A9WpVjmqZY7=s96-c';

    DiaryDisplayContent displayContents = DiaryDisplayContent(
      userDisplayName: userDisplayName,
      dateTime: dateTime,
      userPhotoUrl: userPhotoUrl,
      plainText: plainText.trim(),
    );

    emit(LoadDiaryDetailCompleted(displayContents, richText));
  }
}
