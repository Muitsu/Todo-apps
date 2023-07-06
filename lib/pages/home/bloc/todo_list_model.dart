class TodoListModel {
  int? id;
  String? title;
  String? startDate;
  String? endDate;
  int? status;

  TodoListModel(
      {this.id, this.title, this.startDate, this.endDate, this.status});

  TodoListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    return data;
  }

  TodoListModel copyWith({
    int? id,
    String? title,
    String? startDate,
    String? endDate,
    int? status = 0,
  }) {
    return TodoListModel(
        id: id ?? this.id,
        title: title ?? this.title,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        status: status ?? this.status);
  }
}
