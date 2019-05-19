class CubeObject {
  float w, h, d;
  public float diameter;
  Face[] faces;
  
  PVector maxCor,minCor,center;
  void generateFaces(PVector[] ver)
  {
    faces=new Face[6];
    faces[0]=new Face(ver[0],ver[1],ver[2],ver[3],2,ver[5].y);
    faces[1]=new Face(ver[4],ver[5],ver[6],ver[7],2,ver[0].y);
    
    faces[2]=new Face(ver[0],ver[2],ver[4],ver[6],1,ver[1].x);
    faces[3]=new Face(ver[1],ver[3],ver[5],ver[7],1,ver[0].x);
    
    faces[4]=new Face(ver[0],ver[1],ver[4],ver[5],3,ver[2].z);
    faces[5]=new Face(ver[2],ver[3],ver[6],ver[7],3,ver[0].z);
    
  }
  
  CubeObject(float w,float h,float d,PVector center)
  {
    this.center=center;
    
    this.w=w;
    this.h=h;
    this.d=d;
    PVector[] ver=new PVector[8];
    ver[0]=new PVector(center.x-w/2,center.y-h/2,center.z-d/2);
    ver[1]=new PVector(center.x+w/2,center.y-h/2,center.z-d/2);
    ver[2]=new PVector(center.x-w/2,center.y-h/2,center.z+d/2);
    ver[3]=new PVector(center.x+w/2,center.y-h/2,center.z+d/2);
    
    ver[4]=new PVector(center.x-w/2,center.y+h/2,center.z-d/2);
    ver[5]=new PVector(center.x+w/2,center.y+h/2,center.z-d/2);
    ver[6]=new PVector(center.x-w/2,center.y+h/2,center.z+d/2);
    ver[7]=new PVector(center.x+w/2,center.y+h/2,center.z+d/2);
    
    generateFaces(ver);
    //maxCor=new PVector(w/2+center.x,h/2+center.y,d/2+center.z);
    //minCor=new PVector(-w/2+center.x,-h/2+center.y,-d/2+center.z);
    
    
    //maxCor=new PVector(w/2+center.x+20,h/2+center.y+20,d/2+center.z+20);
    //minCor=new PVector(-w/2+center.x-20,-h/2+center.y-20,-d/2+center.z-20);
    
    maxCor=new PVector(w/2+center.x+30,h/2+center.y+30,d/2+center.z+30);
    minCor=new PVector(-w/2+center.x-30,-h/2+center.y-30,-d/2+center.z-30);
    
  //  maxCor=new PVector(w/2+center.x+60,h/2+center.y+60,d/2+center.z+60);
    //minCor=new PVector(-w/2+center.x-60,-h/2+center.y-60,-d/2+center.z-60);
    
    diameter=sqrt(w*w+h*h);
  }
  boolean flag=false;
  boolean hasCollided(PVector pt)
  {
      boolean flag1=pt.x>=minCor.x && pt.x<=maxCor.x;
      boolean flag2=pt.y>=minCor.y && pt.y<=maxCor.y;
      boolean flag3=pt.z>=minCor.z && pt.z<=maxCor.z;
      
      return flag1 && flag2 && flag3;
  }
  void drawFaces()
  {
    faces[5].Draw();
      //for(int i=0;i<6;i++)
       //faces[i].Draw();
  }
  public void Draw()
  {
     pushMatrix();
     translate(center.x,center.y,center.z);
     box(w-60, h-60, d-60);
     popMatrix();
     
     //drawFaces();
  }
  
}
