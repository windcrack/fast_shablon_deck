import 'package:drift/drift.dart' as drift;
import 'package:fast_shablon_deck/db/database.dart';
import 'package:flutter/material.dart';

class Modaladdshablon extends StatefulWidget {
  final VoidCallback? onShablonAdded;
  
  const Modaladdshablon({super.key, this.onShablonAdded});

  @override
  State<Modaladdshablon> createState() => _ModaladdshablonState();
}

class _ModaladdshablonState extends State<Modaladdshablon> {
  final TextEditingController _textController = TextEditingController();
  late AppDatabase _database;
  bool _isLoading = false;

  
  
  @override
  void initState(){
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async{
    _database = AppDatabase();
  }

  @override
  void dispose() {
    _textController.dispose();
    _database.close();
    super.dispose();
  }

  Future<void> _addShablon() async {
    if(_textController.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите текс шаблона')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final companion = ShablonsCompanion(
        textUser: drift.Value(_textController.text.trim()) 
      );

      await _database.insertShablon(companion);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Шаблон успешно добавлен')),
      );

      _textController.clear();

      widget.onShablonAdded?.call();

      if (mounted) {
        Navigator.of(context).pop();
      }

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ошибка добавления'),
          backgroundColor: Colors.red,
        ),
      );
      
    }finally{
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Добавьте шаблон',
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _textController,
                style: const TextStyle(fontSize: 22.0),
                maxLines: 10,
                minLines: 5,
                decoration: const InputDecoration(
                  hintText: "Вставьте текст..."
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _isLoading ? null : _addShablon, 
                    child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Добавить',
                          style: TextStyle(fontSize: 16),
                        ),
                  ),
                  TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            Navigator.of(context).pop();
                          },
                    style: TextButton.styleFrom(
                      minimumSize: const Size(120, 48),
                    ),
                    child: const Text(
                      'Отмена',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              )
          ],
        ),
      )
    );
  }
}