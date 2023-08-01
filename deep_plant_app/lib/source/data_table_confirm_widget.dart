import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/data_add_home_page.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/widgets/data_table_list_card.dart';
import 'package:flutter/material.dart';

class GetConfirmTable extends StatefulWidget {
  final List<String> userData;
  final String text;
  final Function data;
  final String option2;
  final String option3;
  final DateTime? start;
  final DateTime? end;
  final bool selectedEtc;
  final UserData user;
  final MeatData meat;
  GetConfirmTable({
    super.key,
    required this.userData,
    required this.text,
    required this.data,
    required this.option2,
    required this.option3,
    this.start,
    this.end,
    required this.selectedEtc,
    required this.user,
    required this.meat,
  });

  @override
  State<GetConfirmTable> createState() => _GetConfirmTableState();
}

class _GetConfirmTableState extends State<GetConfirmTable> {
  final List<String> label = ['관리번호', '등록자', '관리'];

  List<String> setSpecies(List<String> source, String option3) {
    if (option3 == '소') {
      source = source.where((data) {
        List<String> parts = data.split(',');
        String dataSpecies = parts[3];
        return (dataSpecies == '소');
      }).toList();
    } else if (option3 == '돼지') {
      source = source.where((data) {
        List<String> parts = data.split(',');
        String dataSpecies = parts[3];
        return (dataSpecies == '돼지');
      }).toList();
    } else {}
    return source;
  }

  List<String> setStatus(List<String> source, String option2) {
    if (option2 == '나의 데이터') {
      source = source.where((data) {
        List<String> parts = data.split(',');
        String dataStatus = parts[6];
        return (dataStatus == widget.user.userId);
      }).toList();
    } else if (option2 == '일반 데이터') {
      source = source.where((data) {
        List<String> parts = data.split(',');
        String dataStatus = parts[5];
        return (dataStatus == 'Normal');
      }).toList();
    } else if (option2 == '연구 데이터') {
      source = source.where((data) {
        List<String> parts = data.split(',');
        String dataStatus = parts[5];
        return (dataStatus == 'Researcher');
      }).toList();
    } else {}
    return source;
  }

  @override
  Widget build(BuildContext context) {
    widget.data();
    List<String> source = widget.userData;
    source = setSpecies(source, widget.option3);
    source = setStatus(source, widget.option2);

    // 이 과정은 기존 source에 담긴 데이터를 textfield를 통해 입력받는 'text' 변수와 비교하게 된다.
    // source에 담긴 data 값을 text의 시작과 비교하고, controller를 통해 실시간적으로 정보를 교류하게 된다.
    // contains는 중간 아무 요소나 비교, startwith는 시작부터, endwith는 끝부터 비교하는 기능임을 기억해두자.

    List<String> filteredData =
        source.where((data) => data.contains(widget.text)).toList();
    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        var dataCells = filteredData[index].split(',');
        return InkWell(
          onTap: () async {
            final data = await ApiServices.getMeatData(dataCells[2]);
            widget.meat.fetchData(data);
            widget.meat.fetchDataForOrigin();

            if (!mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DataAddHome(
                  meatData: widget.meat,
                  userData: widget.user,
                ),
              ),
            );
          },
          child: DataTableListCard(
            dataCells: dataCells,
          ),
        );
      },
    );
  }
}
