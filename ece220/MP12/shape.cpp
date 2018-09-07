#include "shape.hpp"



//Base class
//Please implement Shape's member functions
//constructor, getName()
//
//Base class' constructor should be called in derived classes'
//constructor to initizlize Shape's private variable
Shape::Shape(string name){
  name_ = name;
}

string Shape::getName()
{
  return name_;
}


//Rectangle
//Please implement the member functions of Rectangle:
//constructor, getArea(), getVolume(), operator+, operator-
//@@Insert your code here

Rectangle::Rectangle(double width, double length):Shape("Rectangle"){
  width_ = width;
  length_ = length;
}

Rectangle Rectangle::operator + (const Rectangle& rec){
  double newlength;
  double newwidth;
  newlength = this->length_ + rec.length_;
  newwidth = this->width_ + rec.width_;
  return Rectangle(newlength, newwidth);
}

Rectangle Rectangle::operator - (const Rectangle& rec){
  double newlength;
  double newwidth;
  if (this->length_ - rec.length_ > 0)
  {
    newlength = this->length_ - rec.length_;
  }
  else
  {
    newlength = 0;
  }
  if (this->width_ - rec.width_ > 0)
  {
    newwidth = this->width_ - rec.width_;
  }
  else
  {
    newwidth = 0;
  }
  return Rectangle(newwidth,newlength);
}
double Rectangle::getArea(){
  return (this->length_ *  this->width_);
}
double Rectangle::getVolume(){
  return 0;
}
double Rectangle::getWidth(){return width_;}
double Rectangle::getLength(){return length_;}


//Circle
//Please implement the member functions of Circle:
//constructor, getArea(), getVolume(), operator+, operator-
//@@Insert your code here
Circle::Circle(double radius):Shape("Circle"){
  radius_ = radius;
}
Circle Circle::operator + (const Circle& cir){
  double newradius;
  newradius = this->radius_ + cir.radius_;
  return Circle(newradius);
}

Circle Circle::operator - (const Circle& cir){
  double newradius;
  if (this->radius_ - cir.radius_ > 0)
  {
    newradius = this->radius_ - cir.radius_;
  }
  else
  {
    newradius = 0;
  }
  return Circle(newradius);
}
double Circle::getArea(){
  return ( this->radius_ * this->radius_ * M_PI) ;
}
double Circle::getVolume(){
  return 0;
}
double Circle::getRadius(){return radius_;}

//Sphere
//Please implement the member functions of Sphere:
//constructor, getArea(), getVolume(), operator+, operator-
//@@Insert your code here
Sphere::Sphere(double radius):Shape("Sphere"){
  radius_ = radius;
}
Sphere Sphere::operator + (const Sphere& sph){
  double newraidus;
  newraidus = this->radius_ + sph.radius_;
  return Sphere(newraidus);
}
Sphere Sphere::operator - (const Sphere& sph){
  double newraidus;
  if (this->radius_ - sph.radius_ > 0)
  {
    newraidus = this->radius_ - sph.radius_;
  }
  else
  {
    newraidus = 0;
  }
  return Sphere(newraidus);
}
double Sphere::getArea(){
  return ( 4 * M_PI * this->radius_ * this->radius_);
}
double Sphere::getVolume(){
  return ( (4.0 / 3.0) * this->radius_ * this->radius_ * this->radius_ * M_PI);
}
double Sphere::getRadius(){return radius_;}

//Rectprism
//Please implement the member functions of RectPrism:
//constructor, getArea(), getVolume(), operator+, operator-
//@@Insert your code here
RectPrism::RectPrism(double width, double length, double height):Shape("RectPrism"){
  width_ = width;
  length_ = length;
  height_ = height;
}
RectPrism RectPrism::operator + (const RectPrism& rectp){
  double newlength;
  double newwidth;
  double newheight;
  newlength = this->length_ + rectp.length_;
  newheight = this->height_ + rectp.height_;
  newwidth = this->width_ + rectp.width_;
  return RectPrism(newwidth,newlength,newheight);
}
RectPrism RectPrism::operator - (const RectPrism& rectp){
  double newlength;
  double newwidth;
  double newheight;
  if (this->length_ - rectp.length_ > 0)
  {
    newlength =  this->length_ - rectp.length_;
  }
  else
  {
    newlength = 0;
  }
  if (this->width_ - rectp.width_ > 0)
  {
    newwidth = this->width_ - rectp.width_;
  }
  else
  {
    newwidth = 0;
  }
  if (this->height_ - rectp.height_ > 0)
  {
    newheight = this->height_ - rectp.height_;
  }
  else
  {
    newheight = 0;
  }
  return RectPrism(newwidth,newlength,newheight);
}
double RectPrism::getArea(){
  return ( 2 * ( (this->length_ * this->width_)+ (this->length_ *this->height_)+(this->height_ * this->width_) ));
}
double RectPrism::getVolume(){
  return ( this->length_ * this->width_ * this->height_);
}
double RectPrism::getWidth(){return width_;}
double RectPrism::getHeight(){return height_;}
double RectPrism::getLength(){return length_;}



// Read shapes from test.txt and initialize the objects
// Return a vector of pointers that points to the objects
vector<Shape*> CreateShapes(char* file_name)
{
	//@@Insert your code here
  double total_shapes,i;
  string name;
  vector<Shape*> my_shapes;
  ifstream ifs (file_name, std::ifstream::in);
  ifs >> total_shapes;
  Shape* shape_ptr;
  while (i < total_shapes)
  {

    ifs >> name;
    if (name == ("Rectangle"))
    {
      double width,length;
      ifs >> width >> length;
      shape_ptr = new Rectangle(width,length);
      i++;
    }
    if (name == ("Circle"))
    {
      double radius;
      ifs >> radius;
      shape_ptr = new Circle(radius);
      i++;
    }
    if (name == ("Sphere"))
    {
      double radius;
      ifs >> radius;
      shape_ptr = new Sphere(radius);
      i++;
    }
    if (name == ("RectPrism"))
    {
      double width,height,length;
      ifs >> width >> length >> height;
      shape_ptr = new RectPrism(width, length, height);
      i++;
    }
    my_shapes.push_back(shape_ptr);
  }
  ifs.close();
	return my_shapes; // please remeber to modify this line to return the correct value
}

// call getArea() of each object
// return the max area
double MaxArea(vector<Shape*> shapes){
	double max_area = 0;
	//@@Insert your code here
  int i;
  int size = shapes.size();
  for (i = 0; i < size; i++)
  {
    //cout << shapes[i]->getArea()<<endl;
    if (shapes[i]->getArea() > max_area )
    {
      max_area = shapes[i]->getArea();
      //cout << max_area << endl;
    }
  }
  return max_area;
}
// call getVolume() of each object
// return the max volume
double MaxVolume(vector<Shape*> shapes){
	double max_volume = 0;
	//@@Insert your code here
  int size = shapes.size();
  int i;
  for (i = 0 ;i<size; i++)
  {
    if (shapes[i]->getVolume() > max_volume)
    {
      max_volume = shapes[i]->getVolume();
    }
  }
  return max_volume;
}
