import 'package:cubit/app/pages/home/cubits/todo_cubit.dart';
import 'package:cubit/app/pages/home/cubits/todo_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TodoCubit cubit;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<TodoCubit>(context);
    cubit.stream.listen((state) {
      if(state is ErrorTodoState){
        
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Ação ao clicar no ícone à esquerda
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Ação ao clicar no botão de ação à direita
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder(
              bloc: cubit,
              builder: (context, state) {
                if (state is InitialToDoState) {
                  return const Center(
                    child: Text('Nenhuma tarefa foi adicionada ainda'),
                  );
                } else if (state is LoadingTodoState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedTodoState) {
                  return _buildTodoList(state.todos);
                } else {
                  return _buildTodoList(cubit.todos);
                }
              }),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.03),
                  offset: const Offset(0, -5),
                  blurRadius: 4,
                )
              ]),
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            hintText: 'Digite um nome',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            )),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        cubit.addToDo(todo: _nameController.text);
                        _nameController.clear();
                      },
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Center(
                            child: Icon(Icons.add, color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTodoList(List<String> todos) {
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Center(child: Text(todos[index][0])),
            ),
            title: Text(todos[index]),
            trailing: IconButton(
                onPressed: () {
                  cubit.removeToDo(index: index);
                },
                icon: const Icon(Icons.delete, color: Colors.red)),
          );
        });
  }
}
