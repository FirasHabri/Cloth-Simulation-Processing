class MassNet{
  ArrayList<SphereObject>sphereList;
  ArrayList<Cylinder>cylinderList;
  ArrayList<CubeObject>cubeList;
  
  int n,m;
  static final int l=60,off=6;
  int di[]={0,0,-1,1,-1,1,1,-1,0,0,-2,2};
  int dj[]={-1,1,0,0,1,-1,1,-1,-2,2,0,0};
  
  SpringMass[][] net;
  
  boolean handleCollisions;
  
  PImage unikitty;
  
  public MassNet(int r,int c,boolean[][] flags,boolean handleCollisions)
  {
    n=r;
    m=c;
    this.handleCollisions=handleCollisions;
    buildNet(n,m,flags);
    for(int i=0;i<n;i++)
    {
      for(int j=0;j<m;j++)
      {
        initNeighbors(i,j);
      }
    }
    createObjectsLists();
    
  }
  
  //has to do with external objects and their collision
  void createObjectsLists()
  {
   sphereList=new ArrayList<SphereObject>();
   cylinderList=new ArrayList<Cylinder>();
   cubeList=new ArrayList<CubeObject>();
  }
  public void addNewSphere(SphereObject s)
  {
    sphereList.add(s);
  }
  public void addNewCylinder(Cylinder s)
  {
    cylinderList.add(s);
  }
  public void addNewCube(CubeObject s)
  {
    cubeList.add(s);
  }
  void drawExternalObjects()
  {
    for(int k=0;k<sphereList.size();k++)
     {
        sphereList.get(k).Draw();
     }
     for(int k=0;k<cylinderList.size();k++)
     {
        cylinderList.get(k).Draw();
     }
      for(int k=0;k<cubeList.size();k++)
     {
        cubeList.get(k).Draw();
     }
  }
  
  
  public void unPin(int i,int j)
  {
    net[i][j].pinned=false;
  }
  
  
 boolean valid(int i,int j)
  {
    if(i>=0 && i<n && j>=0 && j<m)
      return true;
    return false;
  }
void buildNet(int n,int  m,boolean[][] flags)
{
  unikitty = loadImage("cat.jpg");
  //println(unikitty);
  net=new SpringMass[n][m];
  int off_x=0,off_y=0,off_z=0;
  for(int i=0;i<n;i++)
  {
    for(int j=0;j<m;j++)
    {
      net[i][j]=new SpringMass(null,new PVector(off_x,off_y,off_z),flags[i][j]);
      off_x+=l+off;
    }
    //off_y+=l+off;
    off_z+=l+off;
    off_x=0;
  }
  
}
  
  
  void initNeighbors(int i,int j)
  {

     net[i][j].neighbors=new NeighborMass[di.length];
     for(int k=0;k<di.length;k++)
     {
       int u=i+di[k];
       int v=j+dj[k];
       if(!valid(u,v))
         {
           net[i][j].neighbors[k]=null;
         }
        else{
         PVector pos=net[u][v].pos_t1;
         net[i][j].neighbors[k]=new NeighborMass(new PVector(pos.x,pos.y,pos.z),net[u][v].pinned);
        }
     }
     
  }
  void updateNeighborsPos(int i,int j)
  {
     //net[i][j];
     for(int k=0;k<di.length;k++)
     {
       int u=i+di[k];
       int v=j+dj[k];
       if(!valid(u,v))
         continue;
       net[i][j].neighbors[k].pos.x=net[u][v].pos_t1.x;
       net[i][j].neighbors[k].pos.y=net[u][v].pos_t1.y;
       net[i][j].neighbors[k].pos.z=net[u][v].pos_t1.z;
     }
  }
  void handleExternalCollisions(int i,int j)
  {
        boolean hasEverCollided=false;
        
        //handle collisions with the ball
        for(int k=0;k<sphereList.size();k++)
        {
        boolean collided=sphereList.get(k).hasCollided(net[i][j].pos_t1);
        hasEverCollided=hasEverCollided || collided;
         if(collided)
              {
                net[i][j].handleCollistionWithBall(sphereList.get(k));
              }
        }
        //now handle collisions with cylinders
        //handleCollistionWithCylinder
        for(int k=0;k<cylinderList.size();k++)
        {
        boolean collided=cylinderList.get(k).hasCollided(net[i][j].pos_t1);
        hasEverCollided=hasEverCollided || collided;
         if(collided)
              {
                net[i][j].handleCollistionWithCylinder(cylinderList.get(k));
              }
        }
        //handle collision with cubes
        for(int k=0;k<cubeList.size();k++)
        {
        boolean collided=cubeList.get(k).hasCollided(net[i][j].pos_t1);
        hasEverCollided=hasEverCollided || collided;
         if(collided)
              {
                net[i][j].handleCollistionWithCube(cubeList.get(k));
              }
        }
        
        if(hasEverCollided)
        {
          net[i][j].updateAcc(30);
        }
        else{
          net[i][j].updateAcc(30);
        }
        net[i][j].verlet(net[i][j].pos_t1,net[i][j].pos_t2);
  }
  void takeObjectShape(int i,int j)
  {
        boolean hasEverCollided=false;
        
        //handle collisions with the ball
        for(int k=0;k<sphereList.size();k++)
        {
        boolean collided=sphereList.get(k).hasCollided(net[i][j].pos_t1);
        hasEverCollided=hasEverCollided || collided;
        }
        //now handle collisions with cylinders
        //handleCollistionWithCylinder
        for(int k=0;k<cylinderList.size();k++)
        {
        boolean collided=cylinderList.get(k).hasCollided(net[i][j].pos_t1);
        hasEverCollided=hasEverCollided || collided;
        }
        //handle collision with cubes
        for(int k=0;k<cubeList.size();k++)
        {
        boolean collided=cubeList.get(k).hasCollided(net[i][j].pos_t1);
        hasEverCollided=hasEverCollided || collided;
        }
     if(!hasEverCollided)
        {
           net[i][j].updateAcc(30);
           net[i][j].verlet(net[i][j].pos_t1,net[i][j].pos_t2);
        }
        
  }
  void update()
  {
    for(int i=0;i<n;i++)
    {
      for(int j=0;j<m;j++)
      {
        updateNeighborsPos(i,j);
        if(net[i][j].pinned){
          continue;
        }
        if(handleCollisions)
        handleExternalCollisions(i,j);
        else 
          takeObjectShape(i,j);
      }
      
      
    }
    
    
    
  Draw();
  
  drawExternalObjects();
  //uncomment this section
  //checkInnerCollisions();
  }
  void checkInnerCollisions()
  {
    for(int i=0;i<n;i++)
    {
      for(int j=0;j<m;j++)
      {
        for(int k=0;k<n;k++)
        {
          for(int z=0;z<m;z++)
          {
           
              float d=dist(net[i][j].pos_t1.x,net[i][j].pos_t1.y,net[i][j].pos_t1.z,
              net[k][z].pos_t1.x,net[k][z].pos_t1.y,net[k][z].pos_t1.z);
              if(d<50)
              {
                
                int sum=abs(i-k)+abs(j-z);
                //println(sum);
                if(sum<4)
                  continue;
                 
                 PVector angleFromParent=new PVector(net[i][j].pos_t1.x-net[k][z].pos_t1.x
                ,net[k][z].pos_t1.y-net[i][j].pos_t1.y,net[k][z].pos_t1.z-net[i][j].pos_t1.z);
                angleFromParent.normalize();
                
                net[i][j].pos_t1.x-=angleFromParent.x*0.1;
                net[i][j].pos_t1.y-=angleFromParent.y*0.1;
                net[i][j].pos_t1.z-=angleFromParent.z*0.1;
                
                net[k][z].pos_t1.x+=angleFromParent.x*0.1;
                net[k][z].pos_t1.y+=angleFromParent.y*0.1;
                net[k][z].pos_t1.z+=angleFromParent.z*0.1;
               
            }
            
            
          }
        }
      }
    }
  }
  void Draw()
  {
    textureMode(NORMAL);
  for (int j = 0; j < n-1; j++) {
    beginShape(TRIANGLE_STRIP);
    texture(unikitty);
    for (int i = 0; i < m; i++) {
      float x1 = net[i][j].pos_t1.x;
      float y1 = net[i][j].pos_t1.y;
      float z1 = net[i][j].pos_t1.z;
      float u = map(i, 0, n-1, 0, 1);
      float v1 = map(j, 0, m-1, 0, 1);
      vertex(x1, y1, z1, u, v1);
      float x2 = net[i][j+1].pos_t1.x;
      float y2 = net[i][j+1].pos_t1.y;
      float z2 = net[i][j+1].pos_t1.z;
      float v2 = map(j+1, 0, n-1, 0, 1);
      vertex(x2, y2, z2, u, v2);
    }
    endShape();
  }
  }
  
  
}
