import 'package:fast_shablon_deck/db/database.dart';
import 'package:fast_shablon_deck/deisng/colors.dart';
import 'package:fast_shablon_deck/deisng/text_styles.dart';
import 'package:fast_shablon_deck/screens/modal_add_shablon.dart';
import 'package:fast_shablon_deck/screens/modal_change_shablon.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/services.dart';


class FastShablonHomePage extends StatefulWidget {
  const FastShablonHomePage({super.key, required this.title});
  final String title;

  @override
  State<FastShablonHomePage> createState() => _FastShablonHomePageState();
}

class _FastShablonHomePageState extends State<FastShablonHomePage> {
  late AppDatabase _database;
  final TextEditingController _userSearch = TextEditingController();
  List<Shablon> _shablons = [];
  List<Shablon> _filtesShablons = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initDatabase();
    _userSearch.addListener(_onSeachChange);
  }

  Future<void> _initDatabase() async {
    _database = AppDatabase();
    await _loadShablons();
  }

  Future<void> _loadShablons() async {
    try {
      final shablons = await _database.allShablons;
      setState(() {
        _shablons = shablons;
        _filtesShablons = shablons;
        _isLoading = false;
      });
    } catch (e) {
      // print('Ошибка загрузки шаблонов: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Modaladdshablon(
          onShablonAdded: () {
            // Обновляем список после добавления
            _loadShablons();
          },
        );
      },
    );
  }

  void _showEditModal(Shablon shablon){
    showDialog(
      context: context, 
      builder: (BuildContext builder){
        return ModalChangeShablon(
          shablon: shablon,
          onShablonUpdated: (){
            _loadShablons();
          },
          onShablonDeleted: () {
            _loadShablons();
          },
        );
      }
    );
  }

  void _onSeachChange(){
    final query = _userSearch.text.toLowerCase().trim();
    setState(() {
      if(query.isEmpty){
        _filtesShablons = _shablons;
      }else{
          _filtesShablons = _shablons.where((item) => item.textUser.toLowerCase().contains(query)).toList();
      }
      
    });
  }

  Future<void> _copyToClipboard(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      
      // Показываем уведомление о успешном копировании
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check, color: colorWhite),
                SizedBox(width: 8),
                Text('Текст скопирован в буфер обмена'),
              ],
            ),
            backgroundColor: colorGreen,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка копирования: $e'),
            backgroundColor: colorRed,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _filtesShablons.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.note_add,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Нет сохраненных шаблонов',
                        style: text18,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Нажмите "+" чтобы добавить первый шаблон',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Количество колонок
                    crossAxisSpacing: 8.0, // Расстояние между колонками
                    mainAxisSpacing: 8.0, // Расстояние между строками
                    childAspectRatio: 3, // Соотношение ширины к высоте (настройте под себя)
                  ),
                  itemCount: _filtesShablons.length,
                  itemBuilder: (context, index) {
                    final shablon = _filtesShablons[index];
                    return Card(
                      // margin: const EdgeInsets.only(bottom: 8.0),
                      elevation: 2,
                      child: InkWell(
                        onTap: () => _copyToClipboard(shablon.textUser),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              // Индекс
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              
                              // Текст шаблона
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      shablon.textUser.length > 100
                                          ? '${shablon.textUser.substring(0, 100)}...'
                                          : shablon.textUser,
                                      style: const TextStyle(fontSize: 16),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Нажмите, чтобы скопировать',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Иконка копирования
                              IconButton(
                                icon: const Icon(
                                  Icons.content_copy,
                                  color: Colors.blue,
                                ),
                                onPressed: () => _copyToClipboard(shablon.textUser),
                                tooltip: 'Копировать',
                              ),
                              // Иконка редактирования
                              IconButton(
                                icon: const Icon(
                                  Icons.edit_document,
                                  color: colorBlue,
                                ),
                                onPressed: () => _showEditModal(shablon),
                                tooltip: 'Редактировать',
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
            controller: _userSearch,
            decoration: InputDecoration(
              hintText: 'Поиск...',
              suffixIcon: IconButton(
                onPressed: () => _userSearch.clear(),
                icon: const Icon(Icons.clear),
              ),
            )
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showModal,
        tooltip: 'Добавить шаблон',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
