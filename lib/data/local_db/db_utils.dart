//A class that simplify Create Table query
class CreateTable {
  final String tableName;
  final List<ColumnField> column;
  const CreateTable({required this.tableName, required this.column});

  String toCreate() {
    final data = column.map((col) => col.toColumn()).toList();
    return '''
    CREATE TABLE $tableName(
     ${data.join(',')}
    )
    ''';
  }
}

class ColumnField {
  final String colName;
  final FieldType fieldType;
  const ColumnField({required this.colName, required this.fieldType});

  String toColumn() {
    return '$colName ${fieldType.name}';
  }
}

enum FieldType {
  idTypeNumber(name: 'INTEGER PRIMARY KEY AUTOINCREMENT'),
  text(name: 'TEXT'),
  char1(name: 'CHAR(1)'),
  blob(name: 'BLOB'),
  date(name: 'DATE'),
  dateTime(name: 'DATETIME DEFAULT CURRENT_TIMESTAMP'),
  boolType(name: 'BOOLEAN'),
  integer(name: 'INTEGER'),
  decimal(name: 'DECIMAL');

  final String name;
  const FieldType({required this.name});
}
