// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyc_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$KYCEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  KYCStatus get status => throw _privateConstructorUsedError;
  List<KYCDocument> get documents => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  DateTime? get submittedAt => throw _privateConstructorUsedError;
  DateTime? get reviewedAt => throw _privateConstructorUsedError;

  /// Create a copy of KYCEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KYCEntityCopyWith<KYCEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KYCEntityCopyWith<$Res> {
  factory $KYCEntityCopyWith(KYCEntity value, $Res Function(KYCEntity) then) =
      _$KYCEntityCopyWithImpl<$Res, KYCEntity>;
  @useResult
  $Res call(
      {String id,
      String userId,
      KYCStatus status,
      List<KYCDocument> documents,
      String? rejectionReason,
      DateTime? submittedAt,
      DateTime? reviewedAt});
}

/// @nodoc
class _$KYCEntityCopyWithImpl<$Res, $Val extends KYCEntity>
    implements $KYCEntityCopyWith<$Res> {
  _$KYCEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KYCEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? status = null,
    Object? documents = null,
    Object? rejectionReason = freezed,
    Object? submittedAt = freezed,
    Object? reviewedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as KYCStatus,
      documents: null == documents
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<KYCDocument>,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      submittedAt: freezed == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reviewedAt: freezed == reviewedAt
          ? _value.reviewedAt
          : reviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KYCEntityImplCopyWith<$Res>
    implements $KYCEntityCopyWith<$Res> {
  factory _$$KYCEntityImplCopyWith(
          _$KYCEntityImpl value, $Res Function(_$KYCEntityImpl) then) =
      __$$KYCEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      KYCStatus status,
      List<KYCDocument> documents,
      String? rejectionReason,
      DateTime? submittedAt,
      DateTime? reviewedAt});
}

/// @nodoc
class __$$KYCEntityImplCopyWithImpl<$Res>
    extends _$KYCEntityCopyWithImpl<$Res, _$KYCEntityImpl>
    implements _$$KYCEntityImplCopyWith<$Res> {
  __$$KYCEntityImplCopyWithImpl(
      _$KYCEntityImpl _value, $Res Function(_$KYCEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of KYCEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? status = null,
    Object? documents = null,
    Object? rejectionReason = freezed,
    Object? submittedAt = freezed,
    Object? reviewedAt = freezed,
  }) {
    return _then(_$KYCEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as KYCStatus,
      documents: null == documents
          ? _value._documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<KYCDocument>,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      submittedAt: freezed == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reviewedAt: freezed == reviewedAt
          ? _value.reviewedAt
          : reviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$KYCEntityImpl implements _KYCEntity {
  const _$KYCEntityImpl(
      {required this.id,
      required this.userId,
      required this.status,
      final List<KYCDocument> documents = const [],
      this.rejectionReason,
      this.submittedAt,
      this.reviewedAt})
      : _documents = documents;

  @override
  final String id;
  @override
  final String userId;
  @override
  final KYCStatus status;
  final List<KYCDocument> _documents;
  @override
  @JsonKey()
  List<KYCDocument> get documents {
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documents);
  }

  @override
  final String? rejectionReason;
  @override
  final DateTime? submittedAt;
  @override
  final DateTime? reviewedAt;

  @override
  String toString() {
    return 'KYCEntity(id: $id, userId: $userId, status: $status, documents: $documents, rejectionReason: $rejectionReason, submittedAt: $submittedAt, reviewedAt: $reviewedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KYCEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._documents, _documents) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.reviewedAt, reviewedAt) ||
                other.reviewedAt == reviewedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      status,
      const DeepCollectionEquality().hash(_documents),
      rejectionReason,
      submittedAt,
      reviewedAt);

  /// Create a copy of KYCEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KYCEntityImplCopyWith<_$KYCEntityImpl> get copyWith =>
      __$$KYCEntityImplCopyWithImpl<_$KYCEntityImpl>(this, _$identity);
}

abstract class _KYCEntity implements KYCEntity {
  const factory _KYCEntity(
      {required final String id,
      required final String userId,
      required final KYCStatus status,
      final List<KYCDocument> documents,
      final String? rejectionReason,
      final DateTime? submittedAt,
      final DateTime? reviewedAt}) = _$KYCEntityImpl;

  @override
  String get id;
  @override
  String get userId;
  @override
  KYCStatus get status;
  @override
  List<KYCDocument> get documents;
  @override
  String? get rejectionReason;
  @override
  DateTime? get submittedAt;
  @override
  DateTime? get reviewedAt;

  /// Create a copy of KYCEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KYCEntityImplCopyWith<_$KYCEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$KYCDocument {
  String get id => throw _privateConstructorUsedError;
  DocumentType get type => throw _privateConstructorUsedError;
  String get documentUrl => throw _privateConstructorUsedError;
  String? get documentNumber =>
      throw _privateConstructorUsedError; // Aadhaar number, PAN number, etc.
  bool get isVerified => throw _privateConstructorUsedError;
  DateTime? get uploadedAt => throw _privateConstructorUsedError;

  /// Create a copy of KYCDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KYCDocumentCopyWith<KYCDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KYCDocumentCopyWith<$Res> {
  factory $KYCDocumentCopyWith(
          KYCDocument value, $Res Function(KYCDocument) then) =
      _$KYCDocumentCopyWithImpl<$Res, KYCDocument>;
  @useResult
  $Res call(
      {String id,
      DocumentType type,
      String documentUrl,
      String? documentNumber,
      bool isVerified,
      DateTime? uploadedAt});
}

/// @nodoc
class _$KYCDocumentCopyWithImpl<$Res, $Val extends KYCDocument>
    implements $KYCDocumentCopyWith<$Res> {
  _$KYCDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KYCDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? documentUrl = null,
    Object? documentNumber = freezed,
    Object? isVerified = null,
    Object? uploadedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DocumentType,
      documentUrl: null == documentUrl
          ? _value.documentUrl
          : documentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      documentNumber: freezed == documentNumber
          ? _value.documentNumber
          : documentNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      uploadedAt: freezed == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KYCDocumentImplCopyWith<$Res>
    implements $KYCDocumentCopyWith<$Res> {
  factory _$$KYCDocumentImplCopyWith(
          _$KYCDocumentImpl value, $Res Function(_$KYCDocumentImpl) then) =
      __$$KYCDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DocumentType type,
      String documentUrl,
      String? documentNumber,
      bool isVerified,
      DateTime? uploadedAt});
}

/// @nodoc
class __$$KYCDocumentImplCopyWithImpl<$Res>
    extends _$KYCDocumentCopyWithImpl<$Res, _$KYCDocumentImpl>
    implements _$$KYCDocumentImplCopyWith<$Res> {
  __$$KYCDocumentImplCopyWithImpl(
      _$KYCDocumentImpl _value, $Res Function(_$KYCDocumentImpl) _then)
      : super(_value, _then);

  /// Create a copy of KYCDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? documentUrl = null,
    Object? documentNumber = freezed,
    Object? isVerified = null,
    Object? uploadedAt = freezed,
  }) {
    return _then(_$KYCDocumentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DocumentType,
      documentUrl: null == documentUrl
          ? _value.documentUrl
          : documentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      documentNumber: freezed == documentNumber
          ? _value.documentNumber
          : documentNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      uploadedAt: freezed == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$KYCDocumentImpl implements _KYCDocument {
  const _$KYCDocumentImpl(
      {required this.id,
      required this.type,
      required this.documentUrl,
      this.documentNumber,
      this.isVerified = false,
      this.uploadedAt});

  @override
  final String id;
  @override
  final DocumentType type;
  @override
  final String documentUrl;
  @override
  final String? documentNumber;
// Aadhaar number, PAN number, etc.
  @override
  @JsonKey()
  final bool isVerified;
  @override
  final DateTime? uploadedAt;

  @override
  String toString() {
    return 'KYCDocument(id: $id, type: $type, documentUrl: $documentUrl, documentNumber: $documentNumber, isVerified: $isVerified, uploadedAt: $uploadedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KYCDocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.documentUrl, documentUrl) ||
                other.documentUrl == documentUrl) &&
            (identical(other.documentNumber, documentNumber) ||
                other.documentNumber == documentNumber) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, type, documentUrl,
      documentNumber, isVerified, uploadedAt);

  /// Create a copy of KYCDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KYCDocumentImplCopyWith<_$KYCDocumentImpl> get copyWith =>
      __$$KYCDocumentImplCopyWithImpl<_$KYCDocumentImpl>(this, _$identity);
}

abstract class _KYCDocument implements KYCDocument {
  const factory _KYCDocument(
      {required final String id,
      required final DocumentType type,
      required final String documentUrl,
      final String? documentNumber,
      final bool isVerified,
      final DateTime? uploadedAt}) = _$KYCDocumentImpl;

  @override
  String get id;
  @override
  DocumentType get type;
  @override
  String get documentUrl;
  @override
  String? get documentNumber; // Aadhaar number, PAN number, etc.
  @override
  bool get isVerified;
  @override
  DateTime? get uploadedAt;

  /// Create a copy of KYCDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KYCDocumentImplCopyWith<_$KYCDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
