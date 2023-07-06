import '../db_utils.dart';
import 'db_fields.dart';

//Constant table columns
enum DBTables {
  todoTable(
    table: CreateTable(
      tableName: TodoFields.tableName,
      column: [
        ColumnField(colName: TodoFields.id, fieldType: FieldType.idTypeNumber),
        ColumnField(colName: TodoFields.title, fieldType: FieldType.text),
        ColumnField(
            colName: TodoFields.startDate, fieldType: FieldType.dateTime),
        ColumnField(colName: TodoFields.endDate, fieldType: FieldType.dateTime),
        ColumnField(colName: TodoFields.status, fieldType: FieldType.integer),
      ],
    ),
  ),
  ;

  final CreateTable table;
  const DBTables({required this.table});
}
