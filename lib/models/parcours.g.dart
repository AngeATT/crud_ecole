// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcours.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Parcour extends DataClass implements Insertable<Parcour> {
  final String codeParcours;
  final String libelleClasse;
  Parcour({required this.codeParcours, required this.libelleClasse});
  factory Parcour.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Parcour(
      codeParcours: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}code_parcours'])!,
      libelleClasse: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}libelle_classe'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code_parcours'] = Variable<String>(codeParcours);
    map['libelle_classe'] = Variable<String>(libelleClasse);
    return map;
  }

  ParcoursCompanion toCompanion(bool nullToAbsent) {
    return ParcoursCompanion(
      codeParcours: Value(codeParcours),
      libelleClasse: Value(libelleClasse),
    );
  }

  factory Parcour.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Parcour(
      codeParcours: serializer.fromJson<String>(json['codeParcours']),
      libelleClasse: serializer.fromJson<String>(json['libelleClasse']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codeParcours': serializer.toJson<String>(codeParcours),
      'libelleClasse': serializer.toJson<String>(libelleClasse),
    };
  }

  Parcour copyWith({String? codeParcours, String? libelleClasse}) => Parcour(
        codeParcours: codeParcours ?? this.codeParcours,
        libelleClasse: libelleClasse ?? this.libelleClasse,
      );
  @override
  String toString() {
    return (StringBuffer('Parcour(')
          ..write('codeParcours: $codeParcours, ')
          ..write('libelleClasse: $libelleClasse')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codeParcours, libelleClasse);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Parcour &&
          other.codeParcours == this.codeParcours &&
          other.libelleClasse == this.libelleClasse);
}

class ParcoursCompanion extends UpdateCompanion<Parcour> {
  final Value<String> codeParcours;
  final Value<String> libelleClasse;
  const ParcoursCompanion({
    this.codeParcours = const Value.absent(),
    this.libelleClasse = const Value.absent(),
  });
  ParcoursCompanion.insert({
    required String codeParcours,
    required String libelleClasse,
  })  : codeParcours = Value(codeParcours),
        libelleClasse = Value(libelleClasse);
  static Insertable<Parcour> custom({
    Expression<String>? codeParcours,
    Expression<String>? libelleClasse,
  }) {
    return RawValuesInsertable({
      if (codeParcours != null) 'code_parcours': codeParcours,
      if (libelleClasse != null) 'libelle_classe': libelleClasse,
    });
  }

  ParcoursCompanion copyWith(
      {Value<String>? codeParcours, Value<String>? libelleClasse}) {
    return ParcoursCompanion(
      codeParcours: codeParcours ?? this.codeParcours,
      libelleClasse: libelleClasse ?? this.libelleClasse,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codeParcours.present) {
      map['code_parcours'] = Variable<String>(codeParcours.value);
    }
    if (libelleClasse.present) {
      map['libelle_classe'] = Variable<String>(libelleClasse.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParcoursCompanion(')
          ..write('codeParcours: $codeParcours, ')
          ..write('libelleClasse: $libelleClasse')
          ..write(')'))
        .toString();
  }
}

class $ParcoursTable extends Parcours with TableInfo<$ParcoursTable, Parcour> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParcoursTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _codeParcoursMeta =
      const VerificationMeta('codeParcours');
  @override
  late final GeneratedColumn<String?> codeParcours = GeneratedColumn<String?>(
      'code_parcours', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _libelleClasseMeta =
      const VerificationMeta('libelleClasse');
  @override
  late final GeneratedColumn<String?> libelleClasse = GeneratedColumn<String?>(
      'libelle_classe', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [codeParcours, libelleClasse];
  @override
  String get aliasedName => _alias ?? 'parcours';
  @override
  String get actualTableName => 'parcours';
  @override
  VerificationContext validateIntegrity(Insertable<Parcour> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code_parcours')) {
      context.handle(
          _codeParcoursMeta,
          codeParcours.isAcceptableOrUnknown(
              data['code_parcours']!, _codeParcoursMeta));
    } else if (isInserting) {
      context.missing(_codeParcoursMeta);
    }
    if (data.containsKey('libelle_classe')) {
      context.handle(
          _libelleClasseMeta,
          libelleClasse.isAcceptableOrUnknown(
              data['libelle_classe']!, _libelleClasseMeta));
    } else if (isInserting) {
      context.missing(_libelleClasseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codeParcours};
  @override
  Parcour map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Parcour.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ParcoursTable createAlias(String alias) {
    return $ParcoursTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ParcoursTable parcours = $ParcoursTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [parcours];
}
