import 'package:clean_architecture_demo/app/di.dart';
import 'package:clean_architecture_demo/domain/entity/todo_entity.dart';
import 'package:clean_architecture_demo/domain/usecase/delete_todo_usecase.dart';
import 'package:clean_architecture_demo/domain/usecase/get_todos_usecase.dart';
import 'package:clean_architecture_demo/domain/usecase/pin_todo_usecase.dart';
import 'package:clean_architecture_demo/presentation/features/create_todo_cards/create_todo_cards_screen.dart';
import 'package:clean_architecture_demo/presentation/features/view_todo_cards/todo_cards_state.dart';
import 'package:clean_architecture_demo/presentation/features/view_todo_cards/todo_crads_cubit.dart';
import 'package:clean_architecture_demo/presentation/resources/assets_manager.dart';
import 'package:clean_architecture_demo/presentation/resources/font_manager.dart';
import 'package:clean_architecture_demo/presentation/resources/values_manager.dart';
import 'package:clean_architecture_demo/presentation/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TodoCardsScreen extends StatefulWidget {
  const TodoCardsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodoCardsScreenState();
}

class _TodoCardsScreenState extends State<TodoCardsScreen> {
  late TodoCardsCubit _todoCardsCubit;
  late AppLocalizations l10n;

  @override
  void initState() {
    super.initState();
    initialise();
  }

  Future<void> initialise() async {
    if (mounted) {
      _todoCardsCubit = TodoCardsCubit(
          getTodosUseCase: getItInstance.get<GetTodosUseCase>(),
          deleterTodoUseCase: getItInstance.get<DeleteTodoUseCase>(),
          pinTodoUseCase: getItInstance.get<PinTodoUseCase>());

      _todoCardsCubit.getTodoCards();
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
          title: Text(l10n.myTodos),
        ),
        body: BlocProvider(
            create: (context) => _todoCardsCubit,
            child: BlocBuilder<TodoCardsCubit, TodoCardsState>(
                builder: (context, state) {
              switch (state.runtimeType) {
                case GetTodoCardsInProgress:
                case PinTodoCardInProgress:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case GetTodoCardsSuccess:
                case DeleteTodoCardSuccess:
                case PinTodoCardSuccess:
                  final todoCards = state.todoCards;
                  return _buildBody(todoCards ?? []);
                case GetTodoCardsFailure:
                case DeleteTodoCardFailure:
                case PinTodoCardFailure:
                  return Center(
                    child: Column(
                      children: [
                        const Icon(Icons.error,
                            size: AppSize.s50, color: Colors.red),
                        Text(state.failure!.message),
                      ],
                    ),
                  );
              }

              return Center(
                child: Text(l10n.somethingWentWrongPleaseTryAgain),
              );
            })),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              //TODO: move to a router constants
              final createTodoCardsScreenRoute = MaterialPageRoute(
                  builder: (context) => const CreateTodoCardsScreen());
              Navigator.push(context, createTodoCardsScreenRoute);
            },
            child: const Icon(Icons.add)));
  }

  Widget _buildBody(List<TodoEntity> todoCards) {
    return todoCards.isEmpty
        ? _buildTodoCardsBodyWhenNoTodos()
        : LayoutBuilder(builder: (context, dimens) {
            return ListView.builder(
              itemCount: todoCards.length,
              itemBuilder: (context, index) {
                return _buildCard(todoCards[index]);
              },
            );
          });
  }

  Widget _buildTodoCardsBodyWhenNoTodos() {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.error, size: AppSize.s50, color: Colors.grey),
          Text(l10n.noTodosFoundCreateYourFirstTodo),
        ],
      ),
    );
  }

  //TODO: extract out as a widget TodoCard
  Widget _buildCard(TodoEntity todoCard) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p20, left: AppPadding.p16, right: AppPadding.p16),
      child: Dismissible(
        key: Key(todoCard.id),
        secondaryBackground: Container(
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: AppPadding.p16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.delete, color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p8),
                      child: Text(l10n.delete,
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            )),
        background: Container(
            color: Colors.green,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: AppPadding.p16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage(AssetsManager.icons.pinIcon),
                      color: Colors.white,
                      size: AppSize.s20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p8),
                      child: todoCard.isPinned
                          ? Text(l10n.unPin,
                              style: const TextStyle(color: Colors.white))
                          : Text(l10n.pinToTop,
                              style: const TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            )),
        onDismissed: (direction) async {
          if (direction == DismissDirection.endToStart) {
            _todoCardsCubit.deleteTodoCard(todoCard);
          } else if (direction == DismissDirection.startToEnd) {
            _todoCardsCubit.pinTodoCard(todoCard);
          }
        },
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            return await _isDeletionConfirmed();
          } else if (direction == DismissDirection.startToEnd) {
            return true;
          }
          return null;
        },
        child: Card(
            elevation: 2,
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p12,
                      left: AppPadding.p20,
                      right: AppPadding.p20),
                  child: SizedBox(
                    height: AppSize.s100,
                    width: getTodoCardTextAreaWidth(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(todoCard.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: FontSize.s20,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: AppSize.s8),
                        Text(todoCard.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: FontSize.s14)),
                        const SizedBox(height: AppSize.s18),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: AppPadding.p8, top: AppPadding.p8),
                  child: Visibility(
                    visible: todoCard.isPinned,
                    child: ImageIcon(
                      AssetImage(AssetsManager.icons.pinIcon),
                      color: Colors.red,
                      size: AppSize.s20,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Future<bool> _isDeletionConfirmed() async {
    Future<bool> isDeletionConfirmed = Future(() => false);
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(l10n.confirm),
              content: Text(l10n.areYouSureYouWantToDeleteThisTodo),
              actions: <Widget>[
                TextButton(
                  child: Text(l10n.yesText),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    isDeletionConfirmed = Future(() => true);
                  },
                ),
                TextButton(
                  child: Text(l10n.cancelText),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    isDeletionConfirmed = Future(() => false);
                  },
                )
              ],
              elevation: AppSize.s24,
            ));
    return isDeletionConfirmed;
  }
}
