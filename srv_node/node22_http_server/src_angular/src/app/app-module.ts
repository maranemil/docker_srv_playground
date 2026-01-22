import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SQLite } from '@awesome-cordova-plugins/sqlite/ngx'; // Or @ionic-native/sqlite


@NgModule({
  declarations: [],
  imports: [
    CommonModule
  ],
  providers: [
    SQLite, // Add this
  ],
})
export class AppModule { }
