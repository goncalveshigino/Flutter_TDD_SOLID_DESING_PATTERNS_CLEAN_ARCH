import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ServeyEntity {

  final String id;
  final String question;
  final DateTime dateTime;
  final bool didAnswer;
  

  const ServeyEntity({
    @required this.id, 
    @required this.question,
    @required this.dateTime, 
    @required this.didAnswer
  });
}
