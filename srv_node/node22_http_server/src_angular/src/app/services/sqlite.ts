/*import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class Sqlite {
  
}
*/

import { Injectable } from '@angular/core';
Injectable({
  providedIn: 'root',
})
//import { CapacitorSQLite, SQLiteDBConnection } from '@capacitor-community/sqlite';
//import { Capacitor } from '@capacitor/core';
import {
  CapacitorSQLite, SQLiteDBConnection, SQLiteConnection, capSQLiteSet,
  capSQLiteChanges, capSQLiteValues, capEchoResult, capSQLiteResult,
  capNCDatabasePathResult
} from '@capacitor-community/sqlite';

/*const sqlite = new SQLiteConnection(CapacitorSQLite);
const database: SQLiteDBConnection = await this.sqlite.createConnection(
  databaseName,
  encrypted,
  mode,
  version,
  readOnly
);*/
//let { rows } = database.query('SELECT somevalue FROM sometable');

export class Sqlite {

  public db: SQLiteDBConnection | null = null;

  async initializeDatabase() {
    try {
      const dbName = 'example.db';
      // @ts-ignore: Object is possibly 'null'.
      this.db = await CapacitorSQLite.createConnection({
        database: dbName,
        version: 1,
      });
      // @ts-ignore: Object is possibly 'null'.
      await this.db.open();
      // @ts-ignore: Object is possibly 'null'.
      await this.db.execute(`
        CREATE TABLE IF NOT EXISTS items (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          description TEXT
        );
      `);
    } catch (error) {
      console.error('Database initialization failed:', error);
    }
  }

  async getItems(): Promise<any[]> {
    const result = await this.db?.query('SELECT * FROM items;');
    return result?.values || [];
  }

  async addItem(name: string, description: string) {
    await this.db?.run('INSERT INTO items (name, description) VALUES (?, ?);', [name, description]);
  }

  async updateItem(id: number, name: string, description: string) {
    await this.db?.run('UPDATE items SET name = ?, description = ? WHERE id = ?;', [name, description, id]);
  }

  async deleteItem(id: number) {
    await this.db?.run('DELETE FROM items WHERE id = ?;', [id]);
  }
}



/*
import { Injectable } from '@angular/core';
import { CapacitorSQLite, SQLiteDBConnection } from '@capacitor-community/sqlite';

@Injectable({
  providedIn: 'root',
})
export class Sqlite {
  private db: SQLiteDBConnection | null = null;

  async initializeDatabase() {
    try {
      const dbName = 'example.db';
      this.db = await CapacitorSQLite.createConnection({
        database: dbName,
        version: 1,
      });
      await this.db.open();
      await this.db.execute(`
        CREATE TABLE IF NOT EXISTS items (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          description TEXT
        );
      `);
    } catch (error) {
      console.error('Database initialization failed:', error);
    }
  }

  async getItems(): Promise<any[]> {
    const result = await this.db?.query('SELECT * FROM items;');
    return result?.values || [];
  }

  async addItem(name: string, description: string) {
    await this.db?.run('INSERT INTO items (name, description) VALUES (?, ?);', [name, description]);
  }

  async updateItem(id: number, name: string, description: string) {
    await this.db?.run('UPDATE items SET name = ?, description = ? WHERE id = ?;', [name, description, id]);
  }

  async deleteItem(id: number) {
    await this.db?.run('DELETE FROM items WHERE id = ?;', [id]);
  }
}
*/

