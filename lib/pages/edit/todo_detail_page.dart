import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/edit/bloc/manage_todo_list_bloc.dart';
import 'package:todo_app/pages/home/bloc/todo_list_bloc.dart';
import 'package:todo_app/pages/home/bloc/todo_list_model.dart';
import 'package:todo_app/widgets/custom_flushbar.dart';
import 'package:todo_app/widgets/primary_textfield.dart';

class TodoDetailPage extends StatefulWidget {
  final bool isEdit;
  final TodoListModel? model;
  const TodoDetailPage({super.key, required this.isEdit, this.model});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController startDateCtrl = TextEditingController();
  TextEditingController endDateCtrl = TextEditingController();
  late DateTimeRange dateRange;
  late ManageTodoListBloc manageBloc;
  @override
  void initState() {
    super.initState();
    manageBloc = Provider.of<ManageTodoListBloc>(context, listen: false);
    //initiate value
    dateRange = DateTimeRange(
        start: widget.model != null
            ? DateTime.parse(widget.model!.startDate!)
            : DateTime.now(),
        end: widget.model != null
            ? DateTime.parse(widget.model!.endDate!)
            : DateTime.now().add(const Duration(days: 1)));
    if (widget.model != null) {
      titleCtrl.text = widget.model!.title!;
      startDateCtrl.text =
          _convertDateToUserFormat(DateTime.parse(widget.model!.startDate!));
      endDateCtrl.text =
          _convertDateToUserFormat(DateTime.parse(widget.model!.endDate!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${!widget.isEdit ? 'Add new' : 'Update'} To-Do List'),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.chevron_left)),
        actions: [
          Visibility(
              visible: widget.isEdit,
              child: IconButton(
                  onPressed: () {
                    manageBloc.add(DeleteTodoList(todoModel: widget.model!));
                  },
                  icon: const Icon(Icons.delete)))
        ],
      ),
      body: BlocListener<ManageTodoListBloc, ManageTodoListState>(
        listener: (context, state) {
          if (state is SucceesInsertTodoList) {
            Navigator.pop(context);
            CustomFlusbar.showSuccess(context,
                message: 'Successfully added task');
            context.read<TodoListBloc>().add(FetchTodoList());
          } else if (state is ErrorInsertTodoList) {
            CustomFlusbar.showUnsuccess(context, message: 'Error Adding task');
          } else if (state is SucceesUpdateTodoList) {
            CustomFlusbar.showSuccess(context,
                message: 'Successfully update task');
            context.read<TodoListBloc>().add(FetchTodoList());
          } else if (state is ErrorUpdateTodoList) {
            CustomFlusbar.showUnsuccess(context, message: 'Error update task');
          } else if (state is SucceesDeleteTodoList) {
            Navigator.pop(context);
            CustomFlusbar.showSuccess(context,
                message: 'Successfully delete task');
            context.read<TodoListBloc>().add(FetchTodoList());
          } else if (state is ErrorDeleteTodoList) {
            CustomFlusbar.showUnsuccess(context, message: 'Error update task');
          }
        },
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PrimaryTextField(
                    controller: titleCtrl,
                    label: 'To-Do Title',
                    hintText: 'Please key in your To Do title here',
                    maxLines: 5,
                    validator: (title) => title != null && title.isEmpty
                        ? 'Enter your title'
                        : null,
                  ),
                  PrimaryTextField(
                    controller: startDateCtrl,
                    label: 'Start Date',
                    hintText: 'Select a date',
                    onTap: () => _pickDateRange(
                        startCtrl: startDateCtrl, endCtrl: endDateCtrl),
                    isDatePicker: true,
                    validator: (date) => date != null && date.isEmpty
                        ? 'Choose start date'
                        : null,
                  ),
                  PrimaryTextField(
                    controller: endDateCtrl,
                    label: 'Estimate End Date',
                    hintText: 'Select a date',
                    onTap: () => _pickDateRange(
                        startCtrl: startDateCtrl, endCtrl: endDateCtrl),
                    isDatePicker: true,
                    validator: (date) =>
                        date != null && date.isEmpty ? 'Choose end date' : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 70,
        child: ElevatedButton(
          onPressed: () {
            final form = formKey.currentState!;
            if (!form.validate()) return;
            if (!widget.isEdit) {
              //calling bloc for insert data
              manageBloc.add(InsertTodoList(
                  todoModel: TodoListModel(
                title: titleCtrl.text,
                startDate: dateRange.start.toString(),
                endDate: dateRange.end.toString(),
                status: 1,
              )));
            } else {
              //calling bloc for update data
              manageBloc.add(UpdateTodoList(
                  todoModel: widget.model!.copyWith(
                title: titleCtrl.text,
                startDate: dateRange.start.toString(),
                endDate: dateRange.end.toString(),
              )));
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          child: Text(
            !widget.isEdit ? 'Create Now' : 'Update Data',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  Future _pickDateRange(
      {required TextEditingController startCtrl,
      required TextEditingController endCtrl}) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (newDateRange == null) return;
    setState(() {
      dateRange = newDateRange;
      startCtrl.text = _convertDateToUserFormat(dateRange.start);
      endCtrl.text = DateFormat('dd MMM yyyy').format(dateRange.end);
    });
  }

  String _convertDateToUserFormat(DateTime date) =>
      DateFormat('dd MMM yyyy').format(date);
}
