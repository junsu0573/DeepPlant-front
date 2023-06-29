import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:deep_plant_app/source/user_info_data_source.dart';
import 'package:deep_plant_app/source/data_page_toggle_button.dart';
import 'package:table_calendar/table_calendar.dart';

class ManageData extends StatefulWidget {
  const ManageData({super.key});

  @override
  State<ManageData> createState() => _ManageDataState();
}

class _ManageDataState extends State<ManageData> {
  final TextEditingController search = TextEditingController();
  FocusNode focusNode = FocusNode();
  String text = '';
  final List<String> label = ['관리번호', '등록자', '관리'];
  final List<String> focusData = [];
  final UserInfoData infoData = UserInfoData();
  final List<bool> _selections1 = [false, true, false, false];
  final List<bool> _selections2 = [true, false];
  String option1 = '1개월';
  String option2 = '최신순';

  _ManageDataState() {
    search.addListener(() {
      setState(() {
        text = search.text;
      });
    });
  }

  void insertOption1(String option) {
    option1 = option;
  }

  void insertOption2(String option) {
    option2 = option;
  }

  void _dataColumnSort(int columnIndex, bool ascending) {}

  List<DataColumn> getColumns() {
    List<DataColumn> dataColumn = [];
    for (var i in label) {
      if (i == '관리번호') {
        dataColumn.add(
          DataColumn(
            label: Padding(
                padding: EdgeInsets.only(right: 40.0),
                child: Text(
                  i,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
            numeric: true,
            onSort: _dataColumnSort,
          ),
        );
      } else if (i == '관리') {
        dataColumn.add(DataColumn(
            label: Padding(
                padding: EdgeInsets.only(left: 17.0),
                child: Text(
                  i,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ))));
      } else {
        dataColumn.add(DataColumn(
            label: Expanded(
                child: Text(
          i,
          style: TextStyle(
            fontSize: 15.0,
          ),
        ))));
      }
    }
    return dataColumn;
  }

  List<DataRow> getRows() {
    List<String> source = infoData.userData;
    List<DataRow> dataRow = [];
    for (var i = 0; i < source.length; i++) {
      var csvDataCells = source[i].split(',');
      List<DataCell> cells = [];
      for (var j = 0; j < csvDataCells.length - 1; j++) {
        cells.add(DataCell(Text(
          csvDataCells[j],
          style: TextStyle(
            fontSize: 15.0,
          ),
        )));
      }
      cells.add(DataCell(ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            )),
        child: Text(
          '수정',
        ),
      )));
      dataRow.add(DataRow(cells: cells));
    }
    return dataRow;
  }

  Widget getDataTable() {
    return DataTable(
      showBottomBorder: true,
      headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
      headingRowHeight: 40.0,
      columns: getColumns(),
      rows: getRows(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '데이터 열람',
        backButton: true,
        closeButton: false,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 35.0,
                child: Row(
                  children: [
                    Expanded(
                        flex: 7,
                        child: TextField(
                            textAlign: TextAlign.end,
                            focusNode: focusNode,
                            autofocus: false,
                            style: TextStyle(
                              fontSize: 13.5,
                            ),
                            controller: search,
                            cursorColor: Colors.grey[400],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10.0),
                              hintText: '관리번호검색',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              suffixIcon: focusNode.hasFocus
                                  ? IconButton(
                                      onPressed: () {
                                        search.clear();
                                        text = '';
                                      },
                                      icon: Icon(
                                        Icons.cancel,
                                        color: Colors.grey[400],
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.search),
                                    ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.2, color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.2, color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),
                                  )),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.2, color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),
                                  )),
                            ))),
                    Expanded(
                      flex: 3,
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            )),
                            builder: (BuildContext context) {
                              return Container(
                                margin: EdgeInsets.all(18.0),
                                height: 300,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        '조회기간',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      ToggleButton(
                                        insertOptionFunc: insertOption1,
                                        options: [
                                          Text('3일'),
                                          Text('1개월'),
                                          Text('3개월'),
                                          Text('직접설정'),
                                        ],
                                        isSelected: _selections1,
                                        isRadius: false,
                                        minHeight: 30.0,
                                        minWidth: 80.0,
                                      ),
                                      Text(
                                        '정렬',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      ToggleButton(
                                        insertOptionFunc: insertOption2,
                                        options: [
                                          Text('최신순'),
                                          Text('과거순'),
                                        ],
                                        isSelected: _selections2,
                                        isRadius: false,
                                        minHeight: 30.0,
                                        minWidth: 160.0,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey[800],
                                          disabledBackgroundColor: Colors.grey[400],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          height: 55.0,
                                          child: Center(
                                            child: Text(
                                              '확인',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[600],
                        ),
                        child: Text('$option1 | $option2'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: SingleChildScrollView(child: getDataTable())),
          ],
        ),
      ),
    );
  }
}
