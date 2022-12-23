import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas_biodata_flutter/database/DbHelper.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  DbHelper dbhelper = DbHelper();
  TextEditingController nameController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int _value = 1;

  @override
  void initState() {
    // TODO: implement initState
    dbhelper.database();
    super.initState();
  }

  // Variable/State untuk mengambil tanggal
  DateTime selectedDate = DateTime.now();

  //  Initial SelectDate FLutter
  Future<void> _selectDate(BuildContext context) async {
    // Initial DateTime FIinal Picked
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1999, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      print(formattedDate);
      setState(() {
        selectedDate = picked;
        dateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Biodata"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nim"),
              TextField(
                keyboardType: TextInputType.number,
                controller: nimController,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Nama"),
              TextField(
                controller: nameController,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Alamat"),
              TextField(
                controller: alamatController,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Jenis Kelamin"),
              ListTile(
                title: Text("Laki-laki"),
                leading: Radio(
                    groupValue: _value,
                    value: 1,
                    onChanged: (value) {
                      setState(() {
                        _value = int.parse(value.toString());
                      });
                    }),
              ),
              ListTile(
                title: Text("Perempuan"),
                leading: Radio(
                    groupValue: _value,
                    value: 2,
                    onChanged: (value) {
                      setState(() {
                        _value = int.parse(value.toString());
                      });
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Tanggal Lahir"),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Masukkan Tanggal",
                ),
                onTap: () {
                  _selectDate(context);
                },
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    int idInsert = await dbhelper.insert({
                      'name': nameController.text,
                      'alamat': alamatController.text,
                      'type': _value,
                      'nim': nimController.text,
                      'created_at': dateController.text,
                      'updated_at': dateController.text,
                    });
                    print("sudah masuk : " + idInsert.toString());
                    Navigator.pop(context);
                  },
                  child: Text("Simpan")),
            ],
          ),
        )),
      ),
    );
  }
}
