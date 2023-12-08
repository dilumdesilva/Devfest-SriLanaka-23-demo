import 'package:clean_architecture_demo/app/di.dart';
import 'package:clean_architecture_demo/domain/usecase/create_todo_usecase.dart';
import 'package:clean_architecture_demo/presentation/features/create_todo_cards/create_todo_cards_cubit.dart';
import 'package:clean_architecture_demo/presentation/features/create_todo_cards/create_todo_cards_state.dart';
import 'package:clean_architecture_demo/presentation/features/view_todo_cards/todo_cards.screen.dart';
import 'package:clean_architecture_demo/presentation/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateTodoCardsScreen extends StatefulWidget {
  const CreateTodoCardsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateTodoCardsScreenState();
}

class _CreateTodoCardsScreenState extends State<CreateTodoCardsScreen> {
  late CreateTodoCardsCubit _createTodoCardsCubit;
  late AppLocalizations l10n;

  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    initialise();
  }

  Future<void> initialise() async {
    if (mounted) {
      _createTodoCardsCubit = CreateTodoCardsCubit(
        createTodoUseCase: getItInstance.get<CreateTodoUseCase>(),
      );
    }
  }

  @override
  void didChangeDependencies() {
    l10n = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Create Todo Card'),
        ),
        body: BlocProvider(
            create: (context) => _createTodoCardsCubit,
            child: BlocConsumer<CreateTodoCardsCubit, CreateTodoCardsState>(
                listener: (context, state) => {
                      if (state is CreateTodoCardSuccess)
                        {_handleTodoCardCreationSuccess()}
                      else if (state is CreateTodoCardFailure)
                        {_handleTodoCardCreationFailure()}
                    },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case CreateTodoCardIdle:
                      return _buildBody();
                    case CreateTodoCardInProgress:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case CreateTodoCardSuccess:
                      return _buildBody();
                    case CreateTodoCardFailure:
                      return _buildBody();
                  }

                  return Center(
                    child: Text(l10n.somethingWentWrongPleaseTryAgain),
                  );
                })));
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 25.0, bottom: 20.0, left: 20.0, right: 20.0),
      child: Column(
        children: [
          _textFieldWithTitle(
              'Todo Title', 'Please enter a title here', _titleTextController),
          const SizedBox(
            height: 40,
          ),
          _textFieldWithTitle('Todo Description (optional)',
              'Please enter a description)', _descriptionTextController),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  _createTodoCardsCubit.createTodoCard(
                      _titleTextController.text,
                      _descriptionTextController.text);
                },
                child:
                    const Text('Create Todo', style: TextStyle(fontSize: 20)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textFieldWithTitle(
      String title, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: controller,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
          ),
        ),
      ],
    );
  }

  void _handleTodoCardCreationSuccess() {
    showLongToast(
        'Todo card ${_titleTextController.text} created successfully');

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const TodoCardsScreen()),
        (Route<dynamic> route) => false);
  }

  void _handleTodoCardCreationFailure() {
    showLongToast(
        'Todo card ${_titleTextController.text} creation failed, please try again!');
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _descriptionTextController.dispose();
    super.dispose();
  }
}
