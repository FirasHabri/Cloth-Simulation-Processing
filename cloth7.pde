import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
boolean[][] f;
MassNet massNet;

int n=10,m=10;

PeasyCam cam;

CubeObject temp;

void setup()
{
  size(1280,720,P3D);
  //frameRate(2);
  cam=new PeasyCam(this,1200);
  f=new boolean[n][m];
  
  for(int i=0;i<n;i++)
  {
      for(int j=0;j<m;j++)
        f[i][j]=false;
  }
  //example 1
  
  massNet=new MassNet(n,m,f,true);
  //sphere example
 // massNet.addNewSphere(new SphereObject(new PVector(300,500,400),400));
  //cylinder example
  //massNet.addNewCylinder(new Cylinder(120, 200, 200,800,new PVector(300,400,200)));
  // massNet.addNewCylinder(new Cylinder(120, 200, 200,800,new PVector(100,400,200)));
  //cube example
  massNet.addNewCube(new CubeObject(600,600,600,new PVector(300,700,100)));
  //massNet.addNewCube(new CubeObject(500,500,500,new PVector(600,300,100)));*/
  
  //example 2
  /*massNet=new MassNet(n,m,f,false);
  massNet.addNewSphere(new SphereObject(new PVector(300,500,400),350));
  massNet.addNewSphere(new SphereObject(new PVector(800,500,400),350));
  massNet.addNewSphere(new SphereObject(new PVector(500,500,800),350));
  */
  
}

void draw()
{
  background(51);
  
  int curTime=millis()/1000;
  
  
  translate(-600,-200);
  
  
  
  
  massNet.update();
  
  
   //rect(10,10,1000,1000);
  
  
}
