import 'package:flutter/material.dart';
import 'package:journalapp/data/journal_edit.dart';

class EditEntry extends StatefulWidget {
  final bool add;
  final int index;
  final JournalEdit journalEdit;
  const EditEntry(
      {required this.add,
      required this.index,
      required this.journalEdit,
      super.key});

  @override
  State<EditEntry> createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {
  // JournalEdit _journalEdit;
  // String _title;
  // DateTime _selectedDate;
  final TextEditingController _moodController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final FocusNode _moodFocus = FocusNode();
  final FocusNode _noteFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
