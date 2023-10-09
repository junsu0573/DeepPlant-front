import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_pop_up.dart';
import 'package:structure/components/table_list_card.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/viewModel/management_data_view_model.dart';
import 'package:structure/viewModel/management_normal_view_model.dart';

class CustomManagementTable extends StatefulWidget {
  final List<String> userSource;
  const CustomManagementTable({super.key, required this.userSource});

  @override
  State<CustomManagementTable> createState() => _CustomManagementTableState();
}

class _CustomManagementTableState extends State<CustomManagementTable> {
  @override
  Widget build(BuildContext context) {
    List<String> source = widget.userSource;
    context.read<ManagementDataViewModel>().manageDataState();
    source = context.read<ManagementDataViewModel>().setSpecies(source);
    source = context.read<ManagementDataViewModel>().setStatus(source);
    List<String> filteredSource = source.where((data) => data.contains(context.read<ManagementDataViewModel>().search)).toList();

    return ListView.builder(
      itemCount: filteredSource.length,
      itemBuilder: (context, index) {
        var sourceCells = filteredSource[index].split(',');
        return InkWell(
          onTap: () async {
            final data = await RemoteDataSource.getMeatData(sourceCells[2]);
            print(data);
            // widget.meat.fetchData(data);
            // widget.meat.fetchDataForOrigin();

            if (!mounted) return;
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DataAddHome(
            //       meatData: widget.meat,
            //       userData: widget.user,
            //     ),
            //   ),
            // );
          },
          child: TableListCard(
            sourceCells: sourceCells,
          ),
        );
      },
    );
  }
}

class CustomManagementNormal extends StatefulWidget {
  final List<String> userSource;
  const CustomManagementNormal({super.key, required this.userSource});

  @override
  State<CustomManagementNormal> createState() => _CustomManagementNormalState();
}

class _CustomManagementNormalState extends State<CustomManagementNormal> {
  @override
  Widget build(BuildContext context) {
    context.read<ManagementNormalViewModel>().setTime();
    context.read<ManagementNormalViewModel>().manageDataState();
    List<String> source = widget.userSource;

    context.read<ManagementNormalViewModel>().sortUserData(source);
    source = context.read<ManagementNormalViewModel>().setDay(source);

    List<String> filteredData = source.where((data) => data.contains(context.read<ManagementDataViewModel>().search)).toList();

    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        var dataCells = filteredData[index].split(',');
        String time = dataCells[0];
        DateTime dTime = DateTime.parse(time);

        return Consumer<ManagementNormalViewModel>(
          builder: (context, viewModel, child) => InkWell(
            onTap: () async {
              if ((dTime.isAfter(viewModel.threeDaysAgo!) && dTime.isBefore(viewModel.toDay!)) && dataCells[4] == '대기중') {
                final data = await RemoteDataSource.getMeatData(dataCells[2]);
                print(data);
                // widget.meat.fetchData(data);
                // await widget.meat.fetchDataForOrigin();
                if (!mounted) return;
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ShowStep(
                //       userData: widget.user,
                //       meatData: widget.meat,
                //       isEdited: true,
                //     ),
                //   ),
                // );
              } else if ((dataCells[4] == '승인')) {
                showDataManageSucceedPopup(context);
              } else if ((dataCells[4] == '반려')) {
                showDataManageFailurePopup(context);
              } else {
                showDataManageLatePopup(context);
              }
            },
            child: TableListCard(
              sourceCells: dataCells,
            ),
          ),
        );
      },
    );
  }
}
