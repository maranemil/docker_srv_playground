
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
//import { Routes } from '@angular/router';
import { ListComponent } from './list/list';
import { FormComponent } from './form/form';
import { Home } from './home/home';

export const routes: Routes = [
  //{ path: '', redirectTo: 'main', pathMatch: 'full'},
  //{ path: 'main', component: ListComponent},


  //{ path: '', redirectTo: '/', pathMatch: 'full' },
  //{ path: '**', component: RouteNotFoundComponent },
  { path: '', component: Home },
  { path: 'list', component: ListComponent },
  { path: 'form', component: FormComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
