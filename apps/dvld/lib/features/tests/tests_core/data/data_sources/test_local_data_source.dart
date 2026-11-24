import 'package:dvld/features/tests/tests_core/data/models/test_model.dart';

abstract class TestLocalDataSource {
  Future<TestModel> getTestInfoByID({required int testID});

  Future<List<TestModel>> getAllTests();

  Future<int> getPassedTestsCountByLocalDLApplicationID({
    required int localDLApplicationID,
  });

  Future<TestModel> getLastTestByPersonIDAndTestTypeIDAndLicenseClassID({
    required int personID,
    required int testTypeID,
    required int licenseClassID,
  });

  Future<int> getTestIDByTestAppointmentID({required int testAppointmentID});

  Future<bool> doesPassTestType({
    required int localDLApplicationID,
    required int testTypeID,
  });

  Future<bool> doesAttendTestType({
    required int localDLApplicationID,
    required int testTypeID,
  });

  Future<int> addNewTest({required TestModel testModel});

  Future<bool> updateTest({required TestModel testModel});

  Future<int> getTotalTrialsPerTest({
    required int testID,
    required int localDLApplicationID,
  });
}
