import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:lectura/core/failures.dart';
import 'package:lectura/features/auth/domain/entities/user.dart';
import 'package:lectura/features/search/data/dto/google_book_result_dto.dart';
import 'package:lectura/features/search/data/dto/user_book_dto.dart';
import 'package:lectura/features/search/domain/entities/book.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension SharedPreferencesLogs on SharedPreferences {
  void logAll() {
    final keysAsString = getKeys()
        .map((key) => "$key: ${get(key)}") // "key: value"
        .join(",");
    log("Shared Preferences: { $keysAsString }\n");
  }
}

extension IsFailure on Either<Failure, dynamic> {
  bool get isFailure => isLeft();
}

extension GetStringValue on Either<Failure, String> {
  String get stringValue {
    assert(isRight(),
    "Trying to get Right from an Either but isRight() is false.");
    return fold((l) => l, (r) => r) as String;
  }
}

extension GetFailure on Either<Failure, dynamic> {
  Failure get failure {
    assert(
        isLeft(), "Trying to get Left from an Either but isLeft() is false.");
    return fold((l) => l, (r) => r) as Failure;
  }
}

extension GetListOfBooksDTOs on Either<Failure, List<GoogleBookResultDto>> {
  List<GoogleBookResultDto> get googleBooksDTOs {
    assert(isRight(),
        "Trying to get Right from an Either but isRight() is false.");
    return fold((l) => l, (r) => r) as List<GoogleBookResultDto>;
  }
}

extension GetListOfUserBooksDTOs on Either<Failure, List<UserBookDto>> {
  List<UserBookDto> get googleUserBooksDTOs {
    assert(isRight(),
        "Trying to get Right from an Either but isRight() is false.");
    return fold((l) => l, (r) => r) as List<UserBookDto>;
  }
}

extension GetUser on Either<Failure, User> {
  User get user {
    assert(isRight(),
        "Trying to get Right from an Either but isRight() is false.");
    return fold((l) => l, (r) => r) as User;
  }
}

extension GetListOfBooks on Either<Failure, List<Book>> {
  List<Book> get books {
    assert(isRight(),
        "Trying to get Right from an Either but isRight() is false.");
    return fold((l) => l, (r) => r) as List<Book>;
  }
}

extension GetValidGoogleBook on GoogleBookResultDto {
  bool get isValid =>
      this.id?.isNotEmpty == true &&
      volumeInfo.title?.isNotEmpty == true &&
      volumeInfo.description?.isNotEmpty == true &&
      volumeInfo.thumbnail?.isNotEmpty == true;
}

extension GetBook on Either<Failure, Book> {
  Book get book {
    assert(isRight(),
    "Trying to get Right from an Either but isRight() is false.");
    return fold((l) => l, (r) => r) as Book;
  }
}

extension GetGoogleBookDto on Either<Failure, GoogleBookResultDto> {
  GoogleBookResultDto get bookDto {
    assert(isRight(),
    "Trying to get Right from an Either but isRight() is false.");
    return fold((l) => l, (r) => r) as GoogleBookResultDto;
  }
}

extension SizedBoxFromDouble on double {
  SizedBox get verticalSpace => SizedBox(height: this);

  SizedBox get horizontalSpace => SizedBox(width: this);
}

extension DurationFromInt on int {
  get seconds => Duration(seconds: this);

  get milliseconds => Duration(milliseconds: this);
}

extension PaddingFromDouble on double {
  get all => EdgeInsets.all(this);

  get horizontal => EdgeInsets.symmetric(horizontal: this);

  get vertical => EdgeInsets.symmetric(vertical: this);

  get onlyBottom => EdgeInsets.only(bottom: this);

  get onlyTop => EdgeInsets.only(top: this);

  get onlyRight => EdgeInsets.only(right: this);

  get onlyLeft => EdgeInsets.only(left: this);
}

extension PaddingFromListDouble on List<double> {
  get fromLTRB {
    if (length == 4) {
      return EdgeInsets.fromLTRB(this[0], this[1], this[2], this[3]);
    }
    // TODO Add exception
    return EdgeInsets.zero;
  }

  get verticalHorizontal {
    if (length == 2) {
      return EdgeInsets.symmetric(vertical: this[0], horizontal: this[1]);
    }
    // TODO Add exception
    return EdgeInsets.zero;
  }
}
