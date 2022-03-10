#set( $ClassName = ${StringUtils.removeAndHump(${NAME}, "_")})

import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum ${ClassName}FailureType {
  Unknown,
}

class ${ClassName}Failure {
  // ignore: avoid_field_initializers_in_const_classes
  const ${ClassName}Failure.unknown([this.cause]) : type = ${ClassName}FailureType.Unknown;
  
  final ${ClassName}FailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case ${ClassName}FailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return '${ClassName}Failure{type: \$type, cause: \$cause}';
  }
}
