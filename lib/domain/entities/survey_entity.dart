import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SurveyEntity {

  final String id;
  final String question;
  final DateTime dateTime;
  final bool didAnswer;
  

  const SurveyEntity({
    @required this.id, 
    @required this.question,
    @required this.dateTime, 
    @required this.didAnswer
  });
}
