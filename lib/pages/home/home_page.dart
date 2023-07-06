import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/assets_color.dart';
import 'package:todo_app/pages/home/bloc/todo_list_bloc.dart';
import 'package:todo_app/widgets/custom_flushbar.dart';
import 'package:todo_app/widgets/custom_page_transition.dart';
import 'package:todo_app/pages/edit/todo_detail_page.dart';
import 'package:todo_app/pages/home/todo_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TodoListBloc todoListBloc;
  @override
  void initState() {
    super.initState();
    todoListBloc = Provider.of<TodoListBloc>(context, listen: false);
    todoListBloc.add(FetchTodoList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AssetsColor.lightGrey,
      appBar: AppBar(title: const Text('To-Do List')),
      body:
          BlocConsumer<TodoListBloc, TodoListState>(listener: (context, state) {
        if (state is SuccessChangeTodoList) {
          CustomFlusbar.showSuccess(context,
              color: Colors.blue, message: 'Status has been updated');
        }
      }, builder: (context, state) {
        if (state is LoadingTodoList) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is EmptyTodoList) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.task_outlined,
                  size: 60,
                ),
                Text('Nothing on your to-do list yet'),
              ],
            ),
          );
        } else if (state is LoadedTodoList) {
          final todoListData = state.listTodo;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 60),
              child: Column(
                  children: List.generate(
                todoListData.length,
                (index) => TodoWidget(
                  title: todoListData[index].title!,
                  onTap: () {
                    Navigator.push(
                        context,
                        CustomPageTransition.slideToPage(
                            page: TodoDetailPage(
                              isEdit: true,
                              model: todoListData[index],
                            ),
                            slide: SlideFrom.right));
                  },
                  startDate: DateTime.parse(todoListData[index].startDate!),
                  endDate: DateTime.parse(todoListData[index].endDate!),
                  isComplete: todoListData[index].status == 0,
                  onChanged: (val) => todoListBloc.add(ChangeStatus(
                      model: todoListData[index], status: val! ? 0 : 1)),
                ),
              )),
            ),
          );
        } else {
          return const Text('error');
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            CustomPageTransition.slideToPage(
              page: const TodoDetailPage(isEdit: false),
              slide: SlideFrom.right,
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
