/*import { Component } from '@angular/core';

@Component({
  selector: 'app-list',
  imports: [],
  templateUrl: './list.html',
  styleUrl: './list.css',
})
export class List {

}
*/

import { Component, OnInit } from '@angular/core';
import { Sqlite } from '../services/sqlite';
import { RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';
import { CommonModule } from '@angular/common';


//import { IonicModule } from '@ionic/angular';
//import { ErrorHandler, NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';

@Component({
  selector: 'app-list',
  imports: [CommonModule, RouterLink, RouterLinkActive],
  templateUrl: './list.html',
  styleUrl: './list.css',
  template: `<div>HALLO</div>`,
  /*template: `
    <header>    
      <title>Item List</title>
    </header>
    <content>
      <button ion-button (click)="loadItems()">Refresh</button>   
      <ul> 
        <li *ngFor="let item of items">
          <label ion-label>
            <h2>{{ item.name }}</h2>
            <p>{{ item.description }}</p>
          </label>
          <button ion-button (click)="editItem(item)">Edit</button>
          <button ion-button color="danger" (click)="deleteItem(item.id)">Delete</button>
        </li>    
        </ul> 
    </content>
  `,*/
})

export class ListComponent {

}


/*export class ListComponent implements OnInit {

  items: any[] = [];

  constructor(private sqliteService: Sqlite) { }

  async ngOnInit() {
    //await this.sqliteService.initializeDatabase();
    //this.loadItems();
  }

  async loadItems() {
    this.items = await this.sqliteService.getItems();
  }

  editItem(item: any) {
    // Navigate to form with item data
  }

  async deleteItem(id: number) {
    await this.sqliteService.deleteItem(id);
    this.loadItems();
  }
}*/

