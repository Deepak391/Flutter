import 'package:demo/questions_handler.dart';

List<QuestionHand> questions = [
  QuestionHand(
    "Who invented the telescope ?",
    {
      "Hans Lipperhey": true,
      "Hypatia": false,
      "Galileo": false,
      "Johannes Kepler": false,
    },
  ),
  QuestionHand("Which of these object is the farthest from the Sun ?", {
    "Neptune": false,
    "Saturn": false,
    "Kuiper belt": false,
    "90377 Sedna": true,
  }),
  QuestionHand("What is the Smallest planet in the solar system ?", {
    "Mars": false,
    "Mercury": true,
    "Earth": false,
    "Jupiter": false,
  }),
  QuestionHand("What is the visible part of the Sun called ?", {
    "The stratosphere": false,
    "The lithosphere": false,
    "The Photosphere": true,
    "The atmosphere": false,
  }),
  QuestionHand("What makes a planet a dwarf planet", {
    "Smell": false,
    "Size and shape": true,
    "Color": false,
    "Distance from the Sun": false,
  }),
  QuestionHand("What two motions do all planets have?", {
    "rock and roll": false,
    "twist and shout": false,
    "wiggle and wobble": false,
    "orbit and spin": false,
  }),
  QuestionHand(
      "Approzimately how many miles (or km) are there in a light-year ?", {
    "590,00(950,000 km)": false,
    "5.9 million (9.5 million km)": false,
    "5.9 billion (9.5 billion)": false,
    "5.9 trillion (9.5 trillion km)": true,
  }),
  QuestionHand("Mars Is the ___ planet from the sun ?", {
    "Second": false,
    "Third": false,
    "Fourth": true,
    "Sixth": false,
  }),
  QuestionHand(
      "Which is the name of a radio source that is very far from earth ?",
      {
        "phaser": false,
        "tracer": false,
        "quasar": true,
        "taser": false,
      }),
  QuestionHand(
      "What is the nucleus of a comet made of ?", {
    "helium and water": false,
    "ice, dust, and organic materials": true,
    "fire": false,
    "radio wave": false,
  }),
];