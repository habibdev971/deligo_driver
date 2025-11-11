
import 'package:intl/intl.dart';

String isoDateFormater({required String? isoDateTime}){
  try{
    if(isoDateTime == null)return 'N/A';
    final dateTime = DateTime.parse(isoDateTime).toLocal();
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }catch(e){
    return 'N/A';
  }
}