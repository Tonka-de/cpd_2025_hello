import 'package:postgres/postgres.dart';

/// A service class for managing PostgreSQL database operations for the todo app.
///
/// This class provides static methods to connect to a PostgreSQL database,
/// create the required table if it does not exist, and perform CRUD operations
/// (Create, Read, Update, Delete) on todo items.
///
/// Usage:
///   - Call [prepareDatabase] once at app startup to initialize the database.
///   - Use [addTodo], [updateTodo], [deleteTodo], and [loadTodos] for CRUD operations.
class PostgreService {
  /// A future that resolves to an open PostgreSQL [Connection].
  ///
  /// The connection is configured to connect to a local PostgreSQL instance
  /// with the database 'todosdb', user 'postgres', and password 'secret'.
  static final _futureConn = Connection.open(
    Endpoint(
      host: 'localhost',
      database: 'todosdb',
      username: 'postgres',
      password: 'secret',
      port: 5432,
    ),
    settings: ConnectionSettings(sslMode: SslMode.disable),
  );

  /// The active PostgreSQL connection instance.
  static Connection? _conn;

  /// Opens the PostgreSQL connection and ensures the 'todos' table exists.
  ///
  /// This method should be called before any other database operations.
  /// It creates the 'todos' table if it does not already exist.
  static Future<void> prepareDatabase() async {
    _conn = await _futureConn;
    await _conn!.execute(
      "CREATE TABLE IF NOT EXISTS todos ( id SERIAL PRIMARY KEY, name TEXT NOT NULL, status TEXT NOT NULL, deadline TIMESTAMP NOT NULL DEFAULT NOW() )",
    );
  }

  /// Loads all todo items from the database.
  ///
  /// Returns a [Result] containing all rows from the 'todos' table.
  static Future<Result> loadTodos() async {
    return await _conn!.execute("SELECT * FROM todos");
  }

  /// Adds a new todo item to the database.
  ///
  /// [name] - The name of the todo item.
  /// [status] - The status of the todo item.
  /// [deadline] - The deadline for the todo item.
  static Future<void> addTodo(
    String name,
    String status,
    DateTime deadline,
  ) async {
    await _conn!.execute(
      Sql.named(
        "INSERT INTO todos (name, status, deadline) VALUES (@name, @status, @deadline)",
      ),
      parameters: {"name": name, "status": status, "deadline": deadline},
    );
  }

  /// Updates an existing todo item in the database.
  ///
  /// [id] - The ID of the todo item to update.
  /// [name] - The new name of the todo item.
  /// [status] - The new status of the todo item.
  /// [deadline] - The new deadline for the todo item.
  static Future<void> updateTodo(
    int id,
    String name,
    String status,
    DateTime deadline,
  ) async {
    await _conn!.execute(
      Sql.named(
        "UPDATE todos SET name = @name, status = @status, deadline = @deadline WHERE id = @id",
      ),
      parameters: {
        "id": id,
        "name": name,
        "status": status,
        "deadline": deadline,
      },
    );
  }

  /// Deletes a todo item from the database by its [id].
  static Future<void> deleteTodo(int id) async {
    await _conn!.execute(
      Sql.named("DELETE FROM todos WHERE id = @id"),
      parameters: {"id": id},
    );
  }
}
