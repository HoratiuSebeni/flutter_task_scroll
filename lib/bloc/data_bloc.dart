import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_scroll/api/api_service.dart';


enum DataEvent { fetch }

class DataBloc extends Bloc<DataEvent, List<dynamic>> {
  final ApiService apiService = ApiService();
  int page = 0;

  DataBloc() : super([]);

  @override
  Stream<List<dynamic>> mapEventToState(DataEvent event) async* {
    if (event == DataEvent.fetch) {
      try {
        final newData = await apiService.fetchData(page);
        if (newData.isNotEmpty) {
          page++;
          yield state + newData;
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
