import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/table_list_card.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/viewModel/management_data_view_model.dart';

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
