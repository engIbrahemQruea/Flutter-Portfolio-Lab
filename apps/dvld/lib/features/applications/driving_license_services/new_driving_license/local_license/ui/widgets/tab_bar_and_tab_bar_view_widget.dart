import 'package:dvld/core/helpers/extensions_x/date_time_extensions_x.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/helepers/add_update_local_driving_license_application_screen_controllers.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/logic/add_update_local_driving_license_application_screen/add_update_local_dr_li_application_screen_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/application_info_tab_widget.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/person_info_tab_widget.dart';
import 'package:dvld/features/login/presentation/screens/widgets/login_widgets.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/cubit/person_selector_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarAndTabBarViewWidget extends StatefulWidget {
  const TabBarAndTabBarViewWidget({super.key});

  @override
  State<TabBarAndTabBarViewWidget> createState() =>
      _TabBarAndTabBarViewWidgetState();
}

class _TabBarAndTabBarViewWidgetState extends State<TabBarAndTabBarViewWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  late AddUpdateLocalDrivingLicenseApplicationScreenControllers _controllers;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _controllers = AddUpdateLocalDrivingLicenseApplicationScreenControllers();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        context
            .read<AddUpdateLocalDrLiApplicationScreenCubit>()
            .onChangeTabIndex(valueIndex: _tabController.index);
      }
    });
  }

  void _initControllers(AddUpdateLocalDrLiApplicationScreenCubitState state) {
    _controllers.dLApplicationIdController.text =
        state.localDriLiceApplicationId.toString() ?? '[ ??? ]';
    _controllers.createdByUserIdController.text = state.isAddMode
        ? state.createdByUser?.userName ?? '[ ??? ]'
        : state.userEntity?.userName ?? '[ ??? ]';
    _controllers.applicationDateController.text =
        state.applicationDate.toFormattedDate;
    _controllers.applicationFeesController.text = state.applicationFee
        .toString();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      AddUpdateLocalDrLiApplicationScreenCubit,
      AddUpdateLocalDrLiApplicationScreenCubitState
    >(
      listenWhen: (previous, current) =>
          previous.selectedTabIndex != current.selectedTabIndex ||
          previous.loadLocalDrLiAppInfoStatus !=
              current.loadLocalDrLiAppInfoStatus,
      buildWhen: (previous, current) =>
          previous.loadLocalDrLiAppInfoStatus !=
          current.loadLocalDrLiAppInfoStatus,
      listener: (context, state) {
        _tabController.animateTo(state.selectedTabIndex);
        if (state.loadLocalDrLiAppInfoStatus.isSuccess ||
            state.saveButtonStatus.saveStatus.isSuccess) {
          _initControllers(state);
        }

        if (state.loadLocalDrLiAppInfoStatus.isSuccess) {
          context.read<PersonSelectorCubit>().loadInfoPersonByPersonID(
            personID: state.personSelectedId,
          );
        }
        // if (!state.hasPersonSelectedId) {
        //   AppDialogs.showFailure(
        //     context: context,
        //     title: 'Error Person Not Selected',
        //     buttonText: 'Try Again,select a person',
        //     message: 'Select a person from Search Filter to continue',
        //   );
        // }
      },
      builder: (context, state) {
        if (state.loadLocalDrLiAppInfoStatus.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.loadLocalDrLiAppInfoStatus.isFailure) {
          return Center(child: Text('${state.errorMessage}'));
        }
        return Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(
              width: 400,
              child: TabBar(
                labelColor: Colors.blue,
                controller: _tabController,
                unselectedLabelColor: Colors.grey,
                mouseCursor: WidgetStateMouseCursor.clickable,
                tabs: const [
                  Tab(text: 'Person Information'),
                  Tab(text: 'Application Information'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  const PersonInfoTabWidget(),
                  ApplicationInfoTabWidget(controllers: _controllers),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
