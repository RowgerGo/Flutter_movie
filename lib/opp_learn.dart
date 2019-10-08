class Student extends Person{

  String _scholl;
  String city;
  String country;
  String name;
  Student(this._scholl, String name,int age,{this.city,this.country='china'}) : super(name,age);

}

///定义一个Dart类
class Person {

  String name;
  int age;

  Person(this.name,this.age);
  ///重写父类方法
  @override
  String toString() {
    // TODO: implement toString
    return 'name:$name,age:$age';
  }

}