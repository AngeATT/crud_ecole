// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eleves.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Eleve extends DataClass implements Insertable<Eleve> {
  final String matricule;
  final String nom;
  final String prenoms;
  final double moyMath;
  final double moyInfo;
  final String parcours;
  Eleve(
      {required this.matricule,
      required this.nom,
      required this.prenoms,
      required this.moyMath,
      required this.moyInfo,
      required this.parcours});
  factory Eleve.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Eleve(
      matricule: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}matricule'])!,
      nom: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nom'])!,
      prenoms: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}prenoms'])!,
      moyMath: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}moy_math'])!,
      moyInfo: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}moy_info'])!,
      parcours: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}parcours'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['matricule'] = Variable<String>(matricule);
    map['nom'] = Variable<String>(nom);
    map['prenoms'] = Variable<String>(prenoms);
    map['moy_math'] = Variable<double>(moyMath);
    map['moy_info'] = Variable<double>(moyInfo);
    map['parcours'] = Variable<String>(parcours);
    return map;
  }

  ElevesCompanion toCompanion(bool nullToAbsent) {
    return ElevesCompanion(
      matricule: Value(matricule),
      nom: Value(nom),
      prenoms: Value(prenoms),
      moyMath: Value(moyMath),
      moyInfo: Value(moyInfo),
      parcours: Value(parcours),
    );
  }

  factory Eleve.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Eleve(
      matricule: serializer.fromJson<String>(json['matricule']),
      nom: serializer.fromJson<String>(json['nom']),
      prenoms: serializer.fromJson<String>(json['prenoms']),
      moyMath: serializer.fromJson<double>(json['moyMath']),
      moyInfo: serializer.fromJson<double>(json['moyInfo']),
      parcours: serializer.fromJson<String>(json['parcours']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'matricule': serializer.toJson<String>(matricule),
      'nom': serializer.toJson<String>(nom),
      'prenoms': serializer.toJson<String>(prenoms),
      'moyMath': serializer.toJson<double>(moyMath),
      'moyInfo': serializer.toJson<double>(moyInfo),
      'parcours': serializer.toJson<String>(parcours),
    };
  }

  Eleve copyWith(
          {String? matricule,
          String? nom,
          String? prenoms,
          double? moyMath,
          double? moyInfo,
          String? parcours}) =>
      Eleve(
        matricule: matricule ?? this.matricule,
        nom: nom ?? this.nom,
        prenoms: prenoms ?? this.prenoms,
        moyMath: moyMath ?? this.moyMath,
        moyInfo: moyInfo ?? this.moyInfo,
        parcours: parcours ?? this.parcours,
      );
  @override
  String toString() {
    return (StringBuffer('Eleve(')
          ..write('matricule: $matricule, ')
          ..write('nom: $nom, ')
          ..write('prenoms: $prenoms, ')
          ..write('moyMath: $moyMath, ')
          ..write('moyInfo: $moyInfo, ')
          ..write('parcours: $parcours')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(matricule, nom, prenoms, moyMath, moyInfo, parcours);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Eleve &&
          other.matricule == this.matricule &&
          other.nom == this.nom &&
          other.prenoms == this.prenoms &&
          other.moyMath == this.moyMath &&
          other.moyInfo == this.moyInfo &&
          other.parcours == this.parcours);
}

class ElevesCompanion extends UpdateCompanion<Eleve> {
  final Value<String> matricule;
  final Value<String> nom;
  final Value<String> prenoms;
  final Value<double> moyMath;
  final Value<double> moyInfo;
  final Value<String> parcours;
  const ElevesCompanion({
    this.matricule = const Value.absent(),
    this.nom = const Value.absent(),
    this.prenoms = const Value.absent(),
    this.moyMath = const Value.absent(),
    this.moyInfo = const Value.absent(),
    this.parcours = const Value.absent(),
  });
  ElevesCompanion.insert({
    required String matricule,
    required String nom,
    required String prenoms,
    required double moyMath,
    required double moyInfo,
    required String parcours,
  })  : matricule = Value(matricule),
        nom = Value(nom),
        prenoms = Value(prenoms),
        moyMath = Value(moyMath),
        moyInfo = Value(moyInfo),
        parcours = Value(parcours);
  static Insertable<Eleve> custom({
    Expression<String>? matricule,
    Expression<String>? nom,
    Expression<String>? prenoms,
    Expression<double>? moyMath,
    Expression<double>? moyInfo,
    Expression<String>? parcours,
  }) {
    return RawValuesInsertable({
      if (matricule != null) 'matricule': matricule,
      if (nom != null) 'nom': nom,
      if (prenoms != null) 'prenoms': prenoms,
      if (moyMath != null) 'moy_math': moyMath,
      if (moyInfo != null) 'moy_info': moyInfo,
      if (parcours != null) 'parcours': parcours,
    });
  }

  ElevesCompanion copyWith(
      {Value<String>? matricule,
      Value<String>? nom,
      Value<String>? prenoms,
      Value<double>? moyMath,
      Value<double>? moyInfo,
      Value<String>? parcours}) {
    return ElevesCompanion(
      matricule: matricule ?? this.matricule,
      nom: nom ?? this.nom,
      prenoms: prenoms ?? this.prenoms,
      moyMath: moyMath ?? this.moyMath,
      moyInfo: moyInfo ?? this.moyInfo,
      parcours: parcours ?? this.parcours,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (matricule.present) {
      map['matricule'] = Variable<String>(matricule.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (prenoms.present) {
      map['prenoms'] = Variable<String>(prenoms.value);
    }
    if (moyMath.present) {
      map['moy_math'] = Variable<double>(moyMath.value);
    }
    if (moyInfo.present) {
      map['moy_info'] = Variable<double>(moyInfo.value);
    }
    if (parcours.present) {
      map['parcours'] = Variable<String>(parcours.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ElevesCompanion(')
          ..write('matricule: $matricule, ')
          ..write('nom: $nom, ')
          ..write('prenoms: $prenoms, ')
          ..write('moyMath: $moyMath, ')
          ..write('moyInfo: $moyInfo, ')
          ..write('parcours: $parcours')
          ..write(')'))
        .toString();
  }
}

class $ElevesTable extends Eleves with TableInfo<$ElevesTable, Eleve> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ElevesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _matriculeMeta = const VerificationMeta('matricule');
  @override
  late final GeneratedColumn<String?> matricule = GeneratedColumn<String?>(
      'matricule', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String?> nom = GeneratedColumn<String?>(
      'nom', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _prenomsMeta = const VerificationMeta('prenoms');
  @override
  late final GeneratedColumn<String?> prenoms = GeneratedColumn<String?>(
      'prenoms', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _moyMathMeta = const VerificationMeta('moyMath');
  @override
  late final GeneratedColumn<double?> moyMath = GeneratedColumn<double?>(
      'moy_math', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _moyInfoMeta = const VerificationMeta('moyInfo');
  @override
  late final GeneratedColumn<double?> moyInfo = GeneratedColumn<double?>(
      'moy_info', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _parcoursMeta = const VerificationMeta('parcours');
  @override
  late final GeneratedColumn<String?> parcours = GeneratedColumn<String?>(
      'parcours', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NULL REFERENCES parcours(codeParcours)');
  @override
  List<GeneratedColumn> get $columns =>
      [matricule, nom, prenoms, moyMath, moyInfo, parcours];
  @override
  String get aliasedName => _alias ?? 'eleves';
  @override
  String get actualTableName => 'eleves';
  @override
  VerificationContext validateIntegrity(Insertable<Eleve> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('matricule')) {
      context.handle(_matriculeMeta,
          matricule.isAcceptableOrUnknown(data['matricule']!, _matriculeMeta));
    } else if (isInserting) {
      context.missing(_matriculeMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
          _nomMeta, nom.isAcceptableOrUnknown(data['nom']!, _nomMeta));
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('prenoms')) {
      context.handle(_prenomsMeta,
          prenoms.isAcceptableOrUnknown(data['prenoms']!, _prenomsMeta));
    } else if (isInserting) {
      context.missing(_prenomsMeta);
    }
    if (data.containsKey('moy_math')) {
      context.handle(_moyMathMeta,
          moyMath.isAcceptableOrUnknown(data['moy_math']!, _moyMathMeta));
    } else if (isInserting) {
      context.missing(_moyMathMeta);
    }
    if (data.containsKey('moy_info')) {
      context.handle(_moyInfoMeta,
          moyInfo.isAcceptableOrUnknown(data['moy_info']!, _moyInfoMeta));
    } else if (isInserting) {
      context.missing(_moyInfoMeta);
    }
    if (data.containsKey('parcours')) {
      context.handle(_parcoursMeta,
          parcours.isAcceptableOrUnknown(data['parcours']!, _parcoursMeta));
    } else if (isInserting) {
      context.missing(_parcoursMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {matricule};
  @override
  Eleve map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Eleve.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ElevesTable createAlias(String alias) {
    return $ElevesTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ElevesTable eleves = $ElevesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [eleves];
}
