import 'package:tafsir/models/row_model_entity.dart';

class LineModel {
  int? lineNo;

  LineModel(this.lineNo, this.lineData);

  List<RowModel>? lineData;
}
