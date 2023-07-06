# To Do App
This is todo apps that keep the data using phone storage

## Getting Started

This project is using BloC as State Management and Sqflite for storing data
and to achieve the following:
- Create todo tasks
- Read todo tasks
- Update todo tasks
- Delete todo tasks

## Setup the project

To setup the app locally follow these steps :

- Git clone todo-app repo : `git clone`
- Install project package  : `flutter pub get`
- run this code on your selected emulator

## Database Schema
![image](https://drive.google.com/uc?export=view&id=11LYY5QbZ948YqepKUw-o0Oqe36x9Lttd)

- id type : `INTEGER PRIMARY KEY AUTOINCREMENT`
- title type  : `TEXT`
- start_date type : `DATETIME DEFAULT CURRENT_TIMESTAMP`
- end_date type  : `DATETIME DEFAULT CURRENT_TIMESTAMP`
- status type (0=true | 1=false): `INTEGER`

## Used Packages
- intl : `^0.18.1`
- flutter_bloc : `^8.1.3`
- provider : `^6.0.5`
- sqflite : `^2.2.8+4`
- path : `^1.8.3`
- another_flushbar : `^1.12.30`
