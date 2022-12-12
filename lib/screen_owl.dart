import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:test_owl/helper.dart';

class TestOwl extends StatefulWidget {
  const TestOwl({super.key});

  @override
  State<TestOwl> createState() => _TestOwlState();
}

class _TestOwlState extends State<TestOwl> {
  List<Map<String, dynamic>> submit = [];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    TextEditingController nameCo = TextEditingController();
    TextEditingController provinsiCo = TextEditingController();

    void getData() async {
      final data = await HaiSql.getProvinsi();

      setState(() {
        submit = data;
      });
    }

    Future<void> addData() async {
      await HaiSql.createData(nameCo.text, provinsiCo.text);

      getData();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Container(
        padding: EdgeInsets.only(right: 15, left: 15, top: 15),
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Text('Nama :')),
                  Expanded(
                    child: TextFormField(
                      controller: nameCo,
                      decoration: InputDecoration(
                        label: Text('Nama'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: Text('Alamat : ')),
                  Expanded(
                    child: TextFormField(
                      controller: provinsiCo,
                      decoration: InputDecoration(
                        label: Text('Alamat'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2)),
                      ),
                    ),
                  ),
                ],
              ),

              //jaliiii
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    await addData();
                  },
                  child: Text('Simpan')),
              SizedBox(height: 20),

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5, left: 50),
                    height: 30,
                    width: 181,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      'Nama',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5, left: 60),
                      height: 30,
                      width: 181,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        'Alamat',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),

              Container(
                  child: AnimationLimiter(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: submit.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                                position: index,
                                child: SlideAnimation(
                                    verticalOffset: 50,
                                    child: FadeInAnimation(
                                      child: shinee(context, index),
                                    )));
                          }))),

              //OutputData(),
            ],
          ),
        ),
      ),
    );
  }

  Widget shinee(BuildContext context, int index) {
    return (submit.length != 0)
        ? OutputData(
            nama: submit[index]['username'],
            provinsi: submit[index]['provinsi'],
          )
        : Container();
  }
}

class OutputData extends StatelessWidget {
  final String? nama;
  final String? provinsi;
  const OutputData({
    this.nama,
    this.provinsi,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(top: 5, left: 50),
          height: 30,
          width: 181,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: Colors.grey),
          ),
          child: Text(
            nama!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 5, left: 60),
            height: 30,
            width: 181,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: Colors.grey),
            ),
            child: Text(
              provinsi!,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
