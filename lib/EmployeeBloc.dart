//TODO imports

//TODO List of employees
//TODO Stream controllers

//TODO Stream sink getter

//TODO Constructor - add data ; listen to changes

//TODO Core functions

//TODO dispose

import 'dart:async';
import 'Employee.dart';
class EmployeeBloc{
  // sink is add in pipe
  // stream to get data from pipe
  // by pipe = data flow
  //List of employeee

  List<Employee> _employeeList = [
    Employee(1, "Telle Whitney", 100.0),
    Employee(2, "Mark zuk", 200.0),
    Employee(3, "Steve Jobs", 300.0),
    Employee(4, "Sundar Pichai",400.0),
    Employee(5, "Lary Page", 500.0),
    Employee(6, "Sergey Brin", 600.0)
  ];
  //functions transformation of data
  final _employeeListStreamController = StreamController<List<Employee>>();

  //for inc and dec
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  //getters
  Stream<List<Employee>> get employeeListStream => _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink => _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement => _employeeSalaryIncrementStreamController;

  StreamSink<Employee> get employeeSalaryDecrement => _employeeSalaryDecrementStreamController;


  //Constructor - add data ; listen to changes
  EmployeeBloc()
  {
     _employeeListStreamController.add(_employeeList);

     _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);

     _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  // Core functions
  _incrementSalary(Employee employee){
    double salary = employee.salary;

    double incrementedSalary = salary * 20/100 ;
    _employeeList[employee.id-1].salary = (salary + incrementedSalary).roundToDouble();

    employeeListSink.add(_employeeList);
  }
  _decrementSalary(Employee employee){
    double salary = employee.salary;

    double decrementedSalary = salary * 20/100 ;
    _employeeList[employee.id-1].salary = (salary - decrementedSalary).roundToDouble();

    employeeListSink.add(_employeeList);
  }

   //dispose
  void dispose(){
    //all declared stream need to be disclose as its good practise to use your resources
    //free your resources
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListStreamController.close();
  }

}

