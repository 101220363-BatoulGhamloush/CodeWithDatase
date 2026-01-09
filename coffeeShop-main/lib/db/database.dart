import 'package:path/path.dart';


class CoffeeDatabase {
  Future<Database> getDatabase() async {
    final dbPath = await getDatabasesPath();
    Database db= await openDatabase(
      join(dbPath, 'coffee.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE cart(
            id TEXT PRIMARY KEY,
            name TEXT,
            image TEXT,
            price REAL,
            quantity INTEGER,
            size TEXT
          )
          ''',
        );

        await db.execute(
          '''
          CREATE TABLE favorites(
            id TEXT PRIMARY KEY,
            name TEXT,
            image TEXT,
            price REAL
          )
          ''',
        );
      },
    );
    return db;
  }
}
