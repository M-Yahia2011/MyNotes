import '../lib/helpers/database_helper.dart';

void main() {
  // DBHelper dbHelper = DBHelper.db;
}

Future<void> testGetDatabase(DBHelper dbHelper) async {
  try {
    await dbHelper.getDatabase;
  } catch (error) {
    throw error;
  }
}


//  try {} catch (error) {
//     throw error;
//   }