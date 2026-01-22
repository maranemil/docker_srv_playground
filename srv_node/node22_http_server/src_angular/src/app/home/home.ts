import { Component } from '@angular/core';
import { RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';
import { CommonModule } from '@angular/common';
//import { ApiService } from 'src/app/services/api.service';
//import { Country } from 'src/app/types/api';

@Component({
  selector: 'app-home',
  // @ts-ignore:
  imports: [CommonModule, RouterLink, RouterLinkActive],
  templateUrl: './home.html',
  styleUrl: './home.css',
})
export class Home {

}
