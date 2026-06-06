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

 String get id; String get title; DateTime get startsDate; DateTime get endDate; String get route; String get meetingPlace; bool get hasSpots; int get requiredGuides; bool get hasLunch; bool get hasMasterclass; GuideLevel get requiredLevel; String get companyId; List<String> get assignedGuides; int get maxParticipants; String get excursionType; PaymentStatus get paymentStatus;
/// Create a copy of Excursion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExcursionCopyWith<Excursion> get copyWith => _$ExcursionCopyWithImpl<Excursion>(this as Excursion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Excursion&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsDate, startsDate) || other.startsDate == startsDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.route, route) || other.route == route)&&(identical(other.meetingPlace, meetingPlace) || other.meetingPlace == meetingPlace)&&(identical(other.hasSpots, hasSpots) || other.hasSpots == hasSpots)&&(identical(other.requiredGuides, requiredGuides) || other.requiredGuides == requiredGuides)&&(identical(other.hasLunch, hasLunch) || other.hasLunch == hasLunch)&&(identical(other.hasMasterclass, hasMasterclass) || other.hasMasterclass == hasMasterclass)&&(identical(other.requiredLevel, requiredLevel) || other.requiredLevel == requiredLevel)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&const DeepCollectionEquality().equals(other.assignedGuides, assignedGuides)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.excursionType, excursionType) || other.excursionType == excursionType)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,startsDate,endDate,route,meetingPlace,hasSpots,requiredGuides,hasLunch,hasMasterclass,requiredLevel,companyId,const DeepCollectionEquality().hash(assignedGuides),maxParticipants,excursionType,paymentStatus);

@override
String toString() {
  return 'Excursion(id: $id, title: $title, startsDate: $startsDate, endDate: $endDate, route: $route, meetingPlace: $meetingPlace, hasSpots: $hasSpots, requiredGuides: $requiredGuides, hasLunch: $hasLunch, hasMasterclass: $hasMasterclass, requiredLevel: $requiredLevel, companyId: $companyId, assignedGuides: $assignedGuides, maxParticipants: $maxParticipants, excursionType: $excursionType, paymentStatus: $paymentStatus)';
}


}

/// @nodoc
abstract mixin class $ExcursionCopyWith<$Res>  {
  factory $ExcursionCopyWith(Excursion value, $Res Function(Excursion) _then) = _$ExcursionCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime startsDate, DateTime endDate, String route, String meetingPlace, bool hasSpots, int requiredGuides, bool hasLunch, bool hasMasterclass, GuideLevel requiredLevel, String companyId, List<String> assignedGuides, int maxParticipants, String excursionType, PaymentStatus paymentStatus
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsDate = null,Object? endDate = null,Object? route = null,Object? meetingPlace = null,Object? hasSpots = null,Object? requiredGuides = null,Object? hasLunch = null,Object? hasMasterclass = null,Object? requiredLevel = null,Object? companyId = null,Object? assignedGuides = null,Object? maxParticipants = null,Object? excursionType = null,Object? paymentStatus = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsDate: null == startsDate ? _self.startsDate : startsDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,meetingPlace: null == meetingPlace ? _self.meetingPlace : meetingPlace // ignore: cast_nullable_to_non_nullable
as String,hasSpots: null == hasSpots ? _self.hasSpots : hasSpots // ignore: cast_nullable_to_non_nullable
as bool,requiredGuides: null == requiredGuides ? _self.requiredGuides : requiredGuides // ignore: cast_nullable_to_non_nullable
as int,hasLunch: null == hasLunch ? _self.hasLunch : hasLunch // ignore: cast_nullable_to_non_nullable
as bool,hasMasterclass: null == hasMasterclass ? _self.hasMasterclass : hasMasterclass // ignore: cast_nullable_to_non_nullable
as bool,requiredLevel: null == requiredLevel ? _self.requiredLevel : requiredLevel // ignore: cast_nullable_to_non_nullable
as GuideLevel,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,assignedGuides: null == assignedGuides ? _self.assignedGuides : assignedGuides // ignore: cast_nullable_to_non_nullable
as List<String>,maxParticipants: null == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int,excursionType: null == excursionType ? _self.excursionType : excursionType // ignore: cast_nullable_to_non_nullable
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startsDate,  DateTime endDate,  String route,  String meetingPlace,  bool hasSpots,  int requiredGuides,  bool hasLunch,  bool hasMasterclass,  GuideLevel requiredLevel,  String companyId,  List<String> assignedGuides,  int maxParticipants,  String excursionType,  PaymentStatus paymentStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Excursion() when $default != null:
return $default(_that.id,_that.title,_that.startsDate,_that.endDate,_that.route,_that.meetingPlace,_that.hasSpots,_that.requiredGuides,_that.hasLunch,_that.hasMasterclass,_that.requiredLevel,_that.companyId,_that.assignedGuides,_that.maxParticipants,_that.excursionType,_that.paymentStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startsDate,  DateTime endDate,  String route,  String meetingPlace,  bool hasSpots,  int requiredGuides,  bool hasLunch,  bool hasMasterclass,  GuideLevel requiredLevel,  String companyId,  List<String> assignedGuides,  int maxParticipants,  String excursionType,  PaymentStatus paymentStatus)  $default,) {final _that = this;
switch (_that) {
case _Excursion():
return $default(_that.id,_that.title,_that.startsDate,_that.endDate,_that.route,_that.meetingPlace,_that.hasSpots,_that.requiredGuides,_that.hasLunch,_that.hasMasterclass,_that.requiredLevel,_that.companyId,_that.assignedGuides,_that.maxParticipants,_that.excursionType,_that.paymentStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime startsDate,  DateTime endDate,  String route,  String meetingPlace,  bool hasSpots,  int requiredGuides,  bool hasLunch,  bool hasMasterclass,  GuideLevel requiredLevel,  String companyId,  List<String> assignedGuides,  int maxParticipants,  String excursionType,  PaymentStatus paymentStatus)?  $default,) {final _that = this;
switch (_that) {
case _Excursion() when $default != null:
return $default(_that.id,_that.title,_that.startsDate,_that.endDate,_that.route,_that.meetingPlace,_that.hasSpots,_that.requiredGuides,_that.hasLunch,_that.hasMasterclass,_that.requiredLevel,_that.companyId,_that.assignedGuides,_that.maxParticipants,_that.excursionType,_that.paymentStatus);case _:
  return null;

}
}

}

/// @nodoc


class _Excursion implements Excursion {
  const _Excursion({required this.id, required this.title, required this.startsDate, required this.endDate, required this.route, required this.meetingPlace, required this.hasSpots, required this.requiredGuides, required this.hasLunch, required this.hasMasterclass, required this.requiredLevel, required this.companyId, required final  List<String> assignedGuides, required this.maxParticipants, required this.excursionType, required this.paymentStatus}): _assignedGuides = assignedGuides;
  

@override final  String id;
@override final  String title;
@override final  DateTime startsDate;
@override final  DateTime endDate;
@override final  String route;
@override final  String meetingPlace;
@override final  bool hasSpots;
@override final  int requiredGuides;
@override final  bool hasLunch;
@override final  bool hasMasterclass;
@override final  GuideLevel requiredLevel;
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

/// Create a copy of Excursion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExcursionCopyWith<_Excursion> get copyWith => __$ExcursionCopyWithImpl<_Excursion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Excursion&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsDate, startsDate) || other.startsDate == startsDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.route, route) || other.route == route)&&(identical(other.meetingPlace, meetingPlace) || other.meetingPlace == meetingPlace)&&(identical(other.hasSpots, hasSpots) || other.hasSpots == hasSpots)&&(identical(other.requiredGuides, requiredGuides) || other.requiredGuides == requiredGuides)&&(identical(other.hasLunch, hasLunch) || other.hasLunch == hasLunch)&&(identical(other.hasMasterclass, hasMasterclass) || other.hasMasterclass == hasMasterclass)&&(identical(other.requiredLevel, requiredLevel) || other.requiredLevel == requiredLevel)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&const DeepCollectionEquality().equals(other._assignedGuides, _assignedGuides)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.excursionType, excursionType) || other.excursionType == excursionType)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,startsDate,endDate,route,meetingPlace,hasSpots,requiredGuides,hasLunch,hasMasterclass,requiredLevel,companyId,const DeepCollectionEquality().hash(_assignedGuides),maxParticipants,excursionType,paymentStatus);

@override
String toString() {
  return 'Excursion(id: $id, title: $title, startsDate: $startsDate, endDate: $endDate, route: $route, meetingPlace: $meetingPlace, hasSpots: $hasSpots, requiredGuides: $requiredGuides, hasLunch: $hasLunch, hasMasterclass: $hasMasterclass, requiredLevel: $requiredLevel, companyId: $companyId, assignedGuides: $assignedGuides, maxParticipants: $maxParticipants, excursionType: $excursionType, paymentStatus: $paymentStatus)';
}


}

/// @nodoc
abstract mixin class _$ExcursionCopyWith<$Res> implements $ExcursionCopyWith<$Res> {
  factory _$ExcursionCopyWith(_Excursion value, $Res Function(_Excursion) _then) = __$ExcursionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime startsDate, DateTime endDate, String route, String meetingPlace, bool hasSpots, int requiredGuides, bool hasLunch, bool hasMasterclass, GuideLevel requiredLevel, String companyId, List<String> assignedGuides, int maxParticipants, String excursionType, PaymentStatus paymentStatus
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsDate = null,Object? endDate = null,Object? route = null,Object? meetingPlace = null,Object? hasSpots = null,Object? requiredGuides = null,Object? hasLunch = null,Object? hasMasterclass = null,Object? requiredLevel = null,Object? companyId = null,Object? assignedGuides = null,Object? maxParticipants = null,Object? excursionType = null,Object? paymentStatus = null,}) {
  return _then(_Excursion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsDate: null == startsDate ? _self.startsDate : startsDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,meetingPlace: null == meetingPlace ? _self.meetingPlace : meetingPlace // ignore: cast_nullable_to_non_nullable
as String,hasSpots: null == hasSpots ? _self.hasSpots : hasSpots // ignore: cast_nullable_to_non_nullable
as bool,requiredGuides: null == requiredGuides ? _self.requiredGuides : requiredGuides // ignore: cast_nullable_to_non_nullable
as int,hasLunch: null == hasLunch ? _self.hasLunch : hasLunch // ignore: cast_nullable_to_non_nullable
as bool,hasMasterclass: null == hasMasterclass ? _self.hasMasterclass : hasMasterclass // ignore: cast_nullable_to_non_nullable
as bool,requiredLevel: null == requiredLevel ? _self.requiredLevel : requiredLevel // ignore: cast_nullable_to_non_nullable
as GuideLevel,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,assignedGuides: null == assignedGuides ? _self._assignedGuides : assignedGuides // ignore: cast_nullable_to_non_nullable
as List<String>,maxParticipants: null == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int,excursionType: null == excursionType ? _self.excursionType : excursionType // ignore: cast_nullable_to_non_nullable
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,
  ));
}


}

// dart format on
