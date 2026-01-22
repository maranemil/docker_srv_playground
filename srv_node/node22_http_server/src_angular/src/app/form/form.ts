/*import { Component } from '@angular/core';

@Component({
  selector: 'app-form',
  imports: [],
  templateUrl: './form.html',
  styleUrl: './form.css',
})
export class Form {

}
*/

import { Component } from '@angular/core';
import { Sqlite } from '../services/sqlite';
//import { FormsModule } from '@angular/forms';
//import { NgModule } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';
import { CommonModule } from '@angular/common';



//import { IonicModule } from '@ionic/angular'; 
//import { ErrorHandler, NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';

@Component({
  selector: 'app-form',
  imports: [CommonModule, RouterLink, RouterLinkActive],
  styleUrl: './form.css',
  templateUrl: './form.html',
  template: `<div>HALLO</div>`,
  /*template: `
    <header> 
      <title>Add/Edit Item</title> 
    </header>
    <content>
      <form (ngSubmit)="saveItem()">
        <li>
          <label position="floating">Name</label>
          <input (ngModel)="name" name="name">
        </li>
        <li>
          <label position="floating">Description</label>
          <textarea (ngModel)="description" name="description"></textarea>
        </li>
        <button ion-button expand="full" type="submit">Save</button>         
      </form>
    </content>
  `,*/
})
export class FormComponent {
  /*name: string = '';
  description: string = '';
  constructor(
    private formBuilder: FormBuilder,
    private sqliteService: Sqlite
  ) { }



  async saveItem() {
    if (this.name) {
      await this.sqliteService.addItem(this.name, this.description);
    }
  }*/
}

