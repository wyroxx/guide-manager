// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'excursion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Excursion {

@JsonKey(includeToJson: false) String get id; String get title;@TimestampConverter() DateTime get startDate;@TimestampConverter() DateTime get endDate; String get route; String get meetingPlace; bool get hasSpots; int get requiredGuides; bool get hasLunch; bool get hasMasterclass; List<GuideLevel> get requiredLevels; String get companyId; List<String> get assignedGuides; int get maxParticipants; String get excursionType; PaymentStatus get paymentStatus;@JsonKey(includeFromJson: false, includeToJson: false) Application? get application;
/// Create a copy of Excursion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExcursionCopyWith<Excursion> get copyWith => _$ExcursionCopyWithImpl<Excursion>(this as Excursion, _$identity);

  /// Serializes this Excursion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Excursion&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.route, route) || other.route == route)&&(identical(other.meetingPlace, meetingPlace) || other.meetingPlace == meetingPlace)&&(identical(other.hasSpots, hasSpots) || other.hasSpots == hasSpots)&&(identical(other.requiredGuides, requiredGuides) || other.requiredGuides == requiredGuides)&&(identical(other.hasLunch, hasLunch) || other.hasLunch == hasLunch)&&(identical(other.hasMasterclass, hasMasterclass) || other.hasMasterclass == hasMasterclass)&&const DeepCollectionEquality().equals(other.requiredLevels, requiredLevels)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&const DeepCollectionEquality().equals(other.assignedGuides, assignedGuides)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.excursionType, excursionType) || other.excursionType == excursionType)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.application, application) || other.application == application));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startDate,endDate,route,meetingPlace,hasSpots,requiredGuides,hasLunch,hasMasterclass,const DeepCollectionEquality().hash(requiredLevels),companyId,const DeepCollectionEquality().hash(assignedGuides),maxParticipants,excursionType,paymentStatus,application);

@override
String toString() {
  return 'Excursion(id: $id, title: $title, startDate: $startDate, endDate: $endDate, route: $route, meetingPlace: $meetingPlace, hasSpots: $hasSpots, requiredGuides: $requiredGuides, hasLunch: $hasLunch, hasMasterclass: $hasMasterclass, requiredLevels: $requiredLevels, companyId: $companyId, assignedGuides: $assignedGuides, maxParticipants: $maxParticipants, excursionType: $excursionType, paymentStatus: $paymentStatus, application: $application)';
}


}

/// @nodoc
abstract mixin class $ExcursionCopyWith<$Res>  {
  factory $ExcursionCopyWith(Excursion value, $Res Function(Excursion) _then) = _$ExcursionCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) String id, String title,@TimestampConverter() DateTime startDate,@TimestampConverter() DateTime endDate, String route, String meetingPlace, bool hasSpots, int requiredGuides, bool hasLunch, bool hasMasterclass, List<GuideLevel> requiredLevels, String companyId, List<String> assignedGuides, int maxParticipants, String excursionType, PaymentStatus paymentStatus,@JsonKey(includeFromJson: false, includeToJson: false) Application? application
});




}
/// @nodoc
class _$ExcursionCopyWithImpl<$Res>
    implements $ExcursionCopyWith<$Res> {
  _$ExcursionCopyWithImpl(this._self, this._then);

  final Excursion _self;
  final $Res Function(Excursion) _then;

/// Create a copy of Excursion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startDate = null,Object? endDate = null,Object? route = null,Object? meetingPlace = null,Object? hasSpots = null,Object? requiredGuides = null,Object? hasLunch = null,Object? hasMasterclass = null,Object? requiredLevels = null,Object? companyId = null,Object? assignedGuides = null,Object? maxParticipants = null,Object? excursionType = null,Object? paymentStatus = null,Object? application = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,meetingPlace: null == meetingPlace ? _self.meetingPlace : meetingPlace // ignore: cast_nullable_to_non_nullable
as String,hasSpots: null == hasSpots ? _self.hasSpots : hasSpots // ignore: cast_nullable_to_non_nullable
as bool,requiredGuides: null == requiredGuides ? _self.requiredGuides : requiredGuides // ignore: cast_nullable_to_non_nullable
as int,hasLunch: null == hasLunch ? _self.hasLunch : hasLunch // ignore: cast_nullable_to_non_nullable
as bool,hasMasterclass: null == hasMasterclass ? _self.hasMasterclass : hasMasterclass // ignore: cast_nullable_to_non_nullable
as bool,requiredLevels: null == requiredLevels ? _self.requiredLevels : requiredLevels // ignore: cast_nullable_to_non_nullable
as List<GuideLevel>,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,assignedGuides: null == assignedGuides ? _self.assignedGuides : assignedGuides // ignore: cast_nullable_to_non_nullable
as List<String>,maxParticipants: null == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int,excursionType: null == excursionType ? _self.excursionType : excursionType // ignore: cast_nullable_to_non_nullable
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,application: freezed == application ? _self.application : application // ignore: cast_nullable_to_non_nullable
as Application?,
  ));
}

}


/// Adds pattern-matching-related methods to [Excursion].
extension ExcursionPatterns on Excursion {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Excursion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Excursion() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Excursion value)  $default,){
final _that = this;
switch (_that) {
case _Excursion():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Excursion value)?  $default,){
final _that = this;
switch (_that) {
case _Excursion() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String title, @TimestampConverter()  DateTime startDate, @TimestampConverter()  DateTime endDate,  String route,  String meetingPlace,  bool hasSpots,  int requiredGuides,  bool hasLunch,  bool hasMasterclass,  List<GuideLevel> requiredLevels,  String companyId,  List<String> assignedGuides,  int maxParticipants,  String excursionType,  PaymentStatus paymentStatus, @JsonKey(includeFromJson: false, includeToJson: false)  Application? application)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Excursion() when $default != null:
return $default(_that.id,_that.title,_that.startDate,_that.endDate,_that.route,_that.meetingPlace,_that.hasSpots,_that.requiredGuides,_that.hasLunch,_that.hasMasterclass,_that.requiredLevels,_that.companyId,_that.assignedGuides,_that.maxParticipants,_that.excursionType,_that.paymentStatus,_that.application);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String id,  String title, @TimestampConverter()  DateTime startDate, @TimestampConverter()  DateTime endDate,  String route,  String meetingPlace,  bool hasSpots,  int requiredGuides,  bool hasLunch,  bool hasMasterclass,  List<GuideLevel> requiredLevels,  String companyId,  List<String> assignedGuides,  int maxParticipants,  String excursionType,  PaymentStatus paymentStatus, @JsonKey(includeFromJson: false, includeToJson: false)  Application? application)  $default,) {final _that = this;
switch (_that) {
case _Excursion():
return $default(_that.id,_that.title,_that.startDate,_that.endDate,_that.route,_that.meetingPlace,_that.hasSpots,_that.requiredGuides,_that.hasLunch,_that.hasMasterclass,_that.requiredLevels,_that.companyId,_that.assignedGuides,_that.maxParticipants,_that.excursionType,_that.paymentStatus,_that.application);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  String id,  String title, @TimestampConverter()  DateTime startDate, @TimestampConverter()  DateTime endDate,  String route,  String meetingPlace,  bool hasSpots,  int requiredGuides,  bool hasLunch,  bool hasMasterclass,  List<GuideLevel> requiredLevels,  String companyId,  List<String> assignedGuides,  int maxParticipants,  String excursionType,  PaymentStatus paymentStatus, @JsonKey(includeFromJson: false, includeToJson: false)  Application? application)?  $default,) {final _that = this;
switch (_that) {
case _Excursion() when $default != null:
return $default(_that.id,_that.title,_that.startDate,_that.endDate,_that.route,_that.meetingPlace,_that.hasSpots,_that.requiredGuides,_that.hasLunch,_that.hasMasterclass,_that.requiredLevels,_that.companyId,_that.assignedGuides,_that.maxParticipants,_that.excursionType,_that.paymentStatus,_that.application);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Excursion implements Excursion {
  const _Excursion({@JsonKey(includeToJson: false) required this.id, required this.title, @TimestampConverter() required this.startDate, @TimestampConverter() required this.endDate, required this.route, required this.meetingPlace, required this.hasSpots, required this.requiredGuides, required this.hasLunch, required this.hasMasterclass, required final  List<GuideLevel> requiredLevels, required this.companyId, required final  List<String> assignedGuides, required this.maxParticipants, required this.excursionType, required this.paymentStatus, @JsonKey(includeFromJson: false, includeToJson: false) this.application}): _requiredLevels = requiredLevels,_assignedGuides = assignedGuides;
  factory _Excursion.fromJson(Map<String, dynamic> json) => _$ExcursionFromJson(json);

@override@JsonKey(includeToJson: false) final  String id;
@override final  String title;
@override@TimestampConverter() final  DateTime startDate;
@override@TimestampConverter() final  DateTime endDate;
@override final  String route;
@override final  String meetingPlace;
@override final  bool hasSpots;
@override final  int requiredGuides;
@override final  bool hasLunch;
@override final  bool hasMasterclass;
 final  List<GuideLevel> _requiredLevels;
@override List<GuideLevel> get requiredLevels {
  if (_requiredLevels is EqualUnmodifiableListView) return _requiredLevels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requiredLevels);
}

@override final  String companyId;
 final  List<String> _assignedGuides;
@override List<String> get assignedGuides {
  if (_assignedGuides is EqualUnmodifiableListView) return _assignedGuides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignedGuides);
}

@override final  int maxParticipants;
@override final  String excursionType;
@override final  PaymentStatus paymentStatus;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  Application? application;

/// Create a copy of Excursion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExcursionCopyWith<_Excursion> get copyWith => __$ExcursionCopyWithImpl<_Excursion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExcursionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Excursion&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.route, route) || other.route == route)&&(identical(other.meetingPlace, meetingPlace) || other.meetingPlace == meetingPlace)&&(identical(other.hasSpots, hasSpots) || other.hasSpots == hasSpots)&&(identical(other.requiredGuides, requiredGuides) || other.requiredGuides == requiredGuides)&&(identical(other.hasLunch, hasLunch) || other.hasLunch == hasLunch)&&(identical(other.hasMasterclass, hasMasterclass) || other.hasMasterclass == hasMasterclass)&&const DeepCollectionEquality().equals(other._requiredLevels, _requiredLevels)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&const DeepCollectionEquality().equals(other._assignedGuides, _assignedGuides)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.excursionType, excursionType) || other.excursionType == excursionType)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.application, application) || other.application == application));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startDate,endDate,route,meetingPlace,hasSpots,requiredGuides,hasLunch,hasMasterclass,const DeepCollectionEquality().hash(_requiredLevels),companyId,const DeepCollectionEquality().hash(_assignedGuides),maxParticipants,excursionType,paymentStatus,application);

@override
String toString() {
  return 'Excursion(id: $id, title: $title, startDate: $startDate, endDate: $endDate, route: $route, meetingPlace: $meetingPlace, hasSpots: $hasSpots, requiredGuides: $requiredGuides, hasLunch: $hasLunch, hasMasterclass: $hasMasterclass, requiredLevels: $requiredLevels, companyId: $companyId, assignedGuides: $assignedGuides, maxParticipants: $maxParticipants, excursionType: $excursionType, paymentStatus: $paymentStatus, application: $application)';
}


}

/// @nodoc
abstract mixin class _$ExcursionCopyWith<$Res> implements $ExcursionCopyWith<$Res> {
  factory _$ExcursionCopyWith(_Excursion value, $Res Function(_Excursion) _then) = __$ExcursionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) String id, String title,@TimestampConverter() DateTime startDate,@TimestampConverter() DateTime endDate, String route, String meetingPlace, bool hasSpots, int requiredGuides, bool hasLunch, bool hasMasterclass, List<GuideLevel> requiredLevels, String companyId, List<String> assignedGuides, int maxParticipants, String excursionType, PaymentStatus paymentStatus,@JsonKey(includeFromJson: false, includeToJson: false) Application? application
});




}
/// @nodoc
class __$ExcursionCopyWithImpl<$Res>
    implements _$ExcursionCopyWith<$Res> {
  __$ExcursionCopyWithImpl(this._self, this._then);

  final _Excursion _self;
  final $Res Function(_Excursion) _then;

/// Create a copy of Excursion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startDate = null,Object? endDate = null,Object? route = null,Object? meetingPlace = null,Object? hasSpots = null,Object? requiredGuides = null,Object? hasLunch = null,Object? hasMasterclass = null,Object? requiredLevels = null,Object? companyId = null,Object? assignedGuides = null,Object? maxParticipants = null,Object? excursionType = null,Object? paymentStatus = null,Object? application = freezed,}) {
  return _then(_Excursion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,meetingPlace: null == meetingPlace ? _self.meetingPlace : meetingPlace // ignore: cast_nullable_to_non_nullable
as String,hasSpots: null == hasSpots ? _self.hasSpots : hasSpots // ignore: cast_nullable_to_non_nullable
as bool,requiredGuides: null == requiredGuides ? _self.requiredGuides : requiredGuides // ignore: cast_nullable_to_non_nullable
as int,hasLunch: null == hasLunch ? _self.hasLunch : hasLunch // ignore: cast_nullable_to_non_nullable
as bool,hasMasterclass: null == hasMasterclass ? _self.hasMasterclass : hasMasterclass // ignore: cast_nullable_to_non_nullable
as bool,requiredLevels: null == requiredLevels ? _self._requiredLevels : requiredLevels // ignore: cast_nullable_to_non_nullable
as List<GuideLevel>,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,assignedGuides: null == assignedGuides ? _self._assignedGuides : assignedGuides // ignore: cast_nullable_to_non_nullable
as List<String>,maxParticipants: null == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int,excursionType: null == excursionType ? _self.excursionType : excursionType // ignore: cast_nullable_to_non_nullable
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,application: freezed == application ? _self.application : application // ignore: cast_nullable_to_non_nullable
as Application?,
  ));
}


}

// dart format on
