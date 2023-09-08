import 'package:final_project/core/util/api_base_helper.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/category/repo/category_repo.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/mail/repo/mail_repo.dart';

class SearchRepository with ApiBaseHelper {
  Future<Map<String, List<Mail>>> search({
    String? searchFor,
    String? startDate,
    String? endDate,
    int? statusId,
  }) async {
    String endpoint = 'search?'
        'text${searchFor != null ? '=$searchFor' : ''}'
        '&start${startDate != null ? '=$startDate' : ''}'
        '&end${endDate != null ? '=$endDate' : ''}'
        '&status_id${statusId != null ? '=$statusId' : ''}';
    final response = await get(endpoint);
    print(endpoint);
    final List<Mail> mails = Mail.mapValueToList(response['mails']);
    print('search lenght ${mails.length}');
    final List<Category> categories =
        await CategoryRepository().getAllCategory();
    Map<String, List<Mail>> data = {};
    data.filterMailsByCategory(categories, mails);
    data.removeWhere((key, value) => value.isEmpty);
    data.sortMailMap();

    return data;
  }
}
