import 'package:get/get.dart';
import '../models/reseller_details_model.dart';
import '../services/reserller_details_service.dart';

class ResellerDetailsController extends GetxController {
  var isLoading = false.obs;

  var resellerDetails = ResellerDetailsModel().obs;

  void fetchResellerDetails(String ID) async {
    try {
      isLoading(true);
      await ReserllerDetailsApi().fetchDetails(ID).then((value) {
        resellerDetails.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
