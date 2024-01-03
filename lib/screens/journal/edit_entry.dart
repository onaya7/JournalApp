import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late JournalEdit _journalEdit;
  late String _title;
  late DateTime _selectedDate;
  final TextEditingController _moodController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final FocusNode _moodFocus = FocusNode();
  final FocusNode _noteFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _journalEdit =
        JournalEdit(action: 'Cancel', journal: widget.journalEdit.journal);
    _title = widget.add ? 'Add' : 'Edit';
    _journalEdit.journal = widget.journalEdit.journal;
    if (widget.add) {
      _selectedDate = DateTime.now();
      _moodController.text = ' ';
      _noteController.text = ' ';
    } else {
      _selectedDate = DateTime.parse(_journalEdit.journal.date);
      _moodController.text = _journalEdit.journal.mood;
      _noteController.text = _journalEdit.journal.note;
    }
  }

  @override
  void dispose() {
    _moodController.dispose();
    _noteController.dispose();
    _moodFocus.dispose();
    _noteFocus.dispose();
    super.dispose();
  }

// Date picker
  Future<DateTime> _selectDate(DateTime selectedDate) async {
    DateTime initializeDate = selectedDate;
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (pickedDate != null) {
      selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          initializeDate.hour,
          initializeDate.minute,
          initializeDate.second,
          initializeDate.microsecond,
          initializeDate.millisecond);
    }
    return selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '$_title Entry',
          ),
          automaticallyImplyLeading: false),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          TextButton(
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime pickerDate = await _selectDate(_selectedDate);
                setState(() {
                  _selectedDate = pickerDate;
                });
              },
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.calendar_today,
                    size: 22.0,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    DateFormat.yMMMEd().format(_selectedDate),
                    style: const TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black54,
                  )
                ],
              )),
          TextField(
            controller: _moodController,
            autofocus: true,
            textInputAction: TextInputAction.next,
            focusNode: _moodFocus,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
                labelText: 'Mood', icon: Icon(Icons.mood)),
            onSubmitted: (submitted) {
              FocusScope.of(context).requestFocus(_noteFocus);
            },
          ),
          TextField()
        ]),
      )),
    );
  }
}
