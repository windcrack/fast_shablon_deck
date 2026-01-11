import 'package:fast_shablon_deck/db/database.dart';
import 'package:fast_shablon_deck/deisng/colors.dart';
import 'package:fast_shablon_deck/deisng/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;

class ModalChangeShablon extends StatefulWidget {
  final Shablon shablon;
  final VoidCallback? onShablonUpdated;
  final VoidCallback? onShablonDeleted;

  const ModalChangeShablon({
    super.key,
    required this.shablon,
    this.onShablonUpdated,
    this.onShablonDeleted,
  });

  @override
  State<ModalChangeShablon> createState() => _ModalChangeShablonState();
}

class _ModalChangeShablonState extends State<ModalChangeShablon> {
  late TextEditingController _textController;
  late AppDatabase _database;
  bool _isLoading = false;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.shablon.textUser);
    _database = AppDatabase();
  }

  Future<void> _updateShablon() async {
    if (_textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Текст шаблона не может быть пустым'),
          backgroundColor: colorRed,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final updatedShablon = Shablon(
        id: widget.shablon.id,
        textUser: _textController.text.trim(), 
        createdAt: widget.shablon.createdAt,
      );

      await _database.updateShablon(updatedShablon);
      
      if (mounted) {
        Navigator.of(context).pop();
        widget.onShablonUpdated?.call();
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Шаблон успешно обновлен'),
            backgroundColor: colorGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка обновления: $e'),
            backgroundColor: colorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _deleteShablon() async {
    setState(() {
      _isDeleting = true;
    });

    try {
      await _database.deleteShablon(widget.shablon.id);
      
      if (mounted) {
        Navigator.of(context).pop();
        widget.onShablonDeleted?.call();
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Шаблон успешно удален'),
            backgroundColor: colorGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка удаления: $e'),
            backgroundColor: colorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDeleting = false;
        });
      }
    }
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить шаблон?'),
        content: const Text('Вы уверены, что хотите удалить этот шаблон? Это действие нельзя отменить.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteShablon();
            },
            style: TextButton.styleFrom(
              foregroundColor: colorRed,
            ),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Заголовок
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Редактирование шаблона',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Поле ввода
            TextField(
              controller: _textController,
              maxLines: 5,
              minLines: 3,
              decoration: InputDecoration(
                hintText: 'Введите текст шаблона...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
              autofocus: true,
            ),
            
            const SizedBox(height: 20),
            
            // Информация о дате создания
            Text(
              'Создан: ${widget.shablon.createdAt.day}.${widget.shablon.createdAt.month}.${widget.shablon.createdAt.year}',
              style: text12,
            ),
            
            const SizedBox(height: 24),
            
            // Кнопки действий
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isDeleting ? null : _showDeleteDialog,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorRed,
                      side: const BorderSide(color: colorRed),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isDeleting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete, size: 20),
                              SizedBox(width: 8),
                              Text('Удалить'),
                            ],
                          ),
                  ),
                ),
                
                const SizedBox(width: 12),
                
                Expanded(
                  child: FilledButton(
                    onPressed: _isLoading ? null : _updateShablon,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.save, size: 20),
                              SizedBox(width: 8),
                              Text('Сохранить'),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}