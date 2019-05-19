class SpringMass{
  NeighborMass[] neighbors;
  final int ls[]={60,60,60,60,60,60,60,60,120,120,120,120};
  PVector pos_t1,pos_t2,a;
  boolean pinned;
  //static final float m=3,k=0.75,beta=4,g=9.8,dt=0.1;
  //change m later
  static final float m=6,k=0.75,beta=4,g=9.8,dt=0.1;
  public SpringMass(NeighborMass[] neighbors,PVector pos,boolean flag)
  {
    this.neighbors=neighbors;
    this.pos_t1=new PVector(pos.x,pos.y,pos.z);
    this.pos_t2=new PVector(pos.x,pos.y,pos.z);
    a=new PVector(0,0,0);
    pinned=flag;
    
  }
  public void handleCollistionWithBall(SphereObject obj)
  {
       PVector angleWithPos=new PVector(-pos_t1.x+obj.center.x,pos_t1.y-obj.center.y
       ,pos_t1.z-obj.center.z);
       
       angleWithPos.normalize();
       
       pos_t1.x+=angleWithPos.x*0.5;
       pos_t1.y+=angleWithPos.y*0.5;
       pos_t1.z+=angleWithPos.z*0.5;
  }
  public void handleCollistionWithCylinder(Cylinder obj)
  {
     PVector temp=obj.computeProjection(pos_t1);
     PVector angleWithPos=new PVector(-pos_t1.x+temp.x,pos_t1.y-temp.y
       ,pos_t1.z-temp.z);
         angleWithPos.normalize();
          
         
         boolean flag1=obj.hasCrossedFaceTwo(pos_t1);
         boolean flag2=obj.hasCrossedFaceOne(pos_t1);
          if(flag1 || flag2)
          {
               pos_t1.x+=1.2;
               pos_t1.y+=1.2;
          }
          else{
              pos_t1.y+=angleWithPos.y*0.5;
              pos_t1.z+=angleWithPos.z*0.5; 
          }
  }
  public void handleCollistionWithCube(CubeObject obj)
   {
       PVector angleWithPos=new PVector(-pos_t1.x+obj.center.x,pos_t1.y-obj.center.y
       ,pos_t1.z-obj.center.z);
       angleWithPos.normalize();
       
       int faceIdx=0;
       for(int i=0;i<6;i++)
         {
           boolean flag=obj.faces[i].hasCrossedThisFace(i,pos_t1);
           if(flag)
           {
               faceIdx=i;
               break;
           }
         }
       if(faceIdx==0 || faceIdx==1)
               {
                  pos_t1.y+=angleWithPos.y*0.32;
               }
       else if(faceIdx==2 || faceIdx==3)
               {
                 pos_t1.x+=angleWithPos.x*0.32;
               }
        else if(faceIdx==4 || faceIdx==5){
                 pos_t1.z+=angleWithPos.z*0.32;
                 
           }
   }
  
  public void updateAcc(float otherBeta)
  {
    PVector v=new PVector(0,0,0);
    a=new PVector(0,0,0);
    v.x = (pos_t1.x - pos_t2.x )/dt;
    v.y=(pos_t1.y-pos_t2.y )/dt;
    v.z=(pos_t1.z-pos_t2.z )/dt;
    
    float kToUse=k;
    
    
    for(int idx=0;idx<neighbors.length;idx++)
    {
      if(neighbors[idx]==null)
        continue;
      int l=ls[idx];
     if(neighbors[idx].isPinned)
     {
       kToUse*=3;
     }
      
      float d=dist(pos_t1.x,pos_t1.y,pos_t1.z,neighbors[idx].pos.x
      ,neighbors[idx].pos.y,neighbors[idx].pos.z);
      d=d-l;
      PVector angleFromParent=new PVector(pos_t1.x-neighbors[idx].pos.x
      ,neighbors[idx].pos.y-pos_t1.y,neighbors[idx].pos.z-pos_t1.z);
      angleFromParent.normalize();
        
      PVector offset=new PVector(angleFromParent.x*d,-angleFromParent.y*d,-angleFromParent.z*d);
      //offset.normalize();
    
      
      a.x+=(-1*(kToUse/m) *offset.x);
      a.y+=(-1*(kToUse/m) *offset.y);
      a.z+=(-1*(kToUse/m) *offset.z);
      
      kToUse=k;
  
    }
    a.x+=(-1*(otherBeta/m)*v.x*dt);
    a.y+=(-1*(otherBeta/m)*v.y*dt);
    a.z+=(-1*(otherBeta/m)*v.z*dt);
    
    a.y+=g;
  }
  public void verlet(PVector pos_t1,PVector pos_t2)
  {
    
    float temp=pos_t1.x;
    pos_t1.x = 2*pos_t1.x - pos_t2.x + a.x*dt*dt ;
    pos_t2.x=temp;    
    
    temp=pos_t1.y;
    pos_t1.y = 2*pos_t1.y - pos_t2.y + a.y*dt*dt ;
    pos_t2.y=temp;   
    
    temp=pos_t1.z;
    pos_t1.z = 2*pos_t1.z - pos_t2.z + a.z*dt*dt ;
    pos_t2.z=temp;  
   
  }
}
