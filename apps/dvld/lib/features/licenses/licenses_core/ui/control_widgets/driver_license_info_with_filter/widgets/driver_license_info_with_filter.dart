import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/driver_license_info_with_filter/logic/driver_license_info_with_filter_cubit/driver_license_info_with_filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverLicenseInfoWithFilter extends StatefulWidget {
  const DriverLicenseInfoWithFilter({super.key});

  @override
  State<DriverLicenseInfoWithFilter> createState() =>
      _DriverLicenseInfoWithFilterState();
}

class _DriverLicenseInfoWithFilterState
    extends State<DriverLicenseInfoWithFilter> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _cubit = context.read<DriverLicenseInfoWithFilterCubit>();
    final _isLoading = _cubit.state is DriverLicenseInfoWithFilterCubitLoading;

    return Container(
      child: Row(
        spacing: 10,
        children: [
          Text('License ID : '),
          SizedBox(
            width: 200,
            child: AppTextField(
              label: 'License ID',
              controller: _controller,
              autoFocus: true,
              keyboardType: TextInputType.number,
              inputFormatter: [FilteringTextInputFormatter.digitsOnly],
              onFieldSubmitted: (p0) =>
                  _cubit.findLicenseDetailsInfoById(licenseId: int.parse(p0)),
            ),
          ),
          AppButton.custom(
            label: 'Search',
            icon: _isLoading
                ? SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      color: Colors.green,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.search, color: Colors.white, size: 20),
            loading: _isLoading,
            onPressed: () => _cubit.findLicenseDetailsInfoById(
              licenseId: int.parse(_controller.text.trim()),
            ),
          ),
        ],
      ),
    );
  }
}
