class Cylinder{
  PVector pt1,pt2,center;
  int sides;
  float r1,r2,h;
  Cylinder(int sides, float r1, float r2, float h,PVector center)
  {
    this.r1=r1;
    this.r2=r2;
    this.h=h;
    this.sides=sides;
    this.center=center;
  // pt1=new PVector(center.x,center.y,center.z-h/2-40);
    //pt2=new PVector(center.x,center.y,center.z+h/2+40);
    
    // pt1=new PVector(center.x,center.y,center.z-h/2-30);
    //pt2=new PVector(center.x,center.y,center.z+h/2+30);
    pt1=new PVector(center.x-h/2-10,center.y,center.z);
    pt2=new PVector(center.x+h/2+10,center.y,center.z);
   
    
    
  }
  
  boolean hasCrossedFaceOne(PVector pt)
{
   //
  if(pow(pt.z-pt2.z,2)+pow(pt.y-pt2.y,2)<=r1*r1)
  {
    return pt.x<=pt2.x && pt.x>=pt2.x-2;
  }
  return false;
}

boolean hasCrossedFaceTwo(PVector pt)
{
   //
  if(pow(pt.z-pt1.z,2)+pow(pt.y-pt1.y,2)<=r1*r1)
  {
    return pt.x>=pt1.x && pt.x<=pt1.x+2;
  }
  return false;
}
  public void drawPoints()
  {
    pushMatrix();
    translate(pt1.x,pt1.y,pt1.z);
    sphere(20);
    popMatrix();
    
    pushMatrix();
    translate(pt2.x,pt2.y,pt2.z);
    sphere(20);
    popMatrix();
  }
   void Draw2()
  {
    drawPoints();
    pushMatrix();
    //rotateX(-90);
    translate(center.x,center.y,center.z);
    float angle = 360 / sides;
    float halfHeight = h / 2;
    // top
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r1;
        float y = sin( radians( i * angle ) ) * r1;
        vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);
    // bottom
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r2;
        float y = sin( radians( i * angle ) ) * r2;
        vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    // draw body
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x1, y1, -halfHeight);
        vertex( x2, y2, halfHeight);
    }
    endShape(CLOSE);
    //drawPoints();
    popMatrix();
}
  void Draw()
  {
    drawPoints();
    pushMatrix();
    translate(center.x,center.y,center.z);
    float angle = 360 / sides;
    float halfHeight = h / 2;
    // top
    beginShape();
    for (int i = 0; i < sides; i++) {
        float z = cos( radians( i * angle ) ) * r1;
        float y = sin( radians( i * angle ) ) * r1;
        vertex( -halfHeight, y,z );
    }
    endShape(CLOSE);
    // bottom
    beginShape();
    for (int i = 0; i < sides; i++) {
        float z = cos( radians( i * angle ) ) * r2;
        float y = sin( radians( i * angle ) ) * r2;
        vertex( halfHeight, y, z);
    }
    endShape(CLOSE);
    // draw body
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float z1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        float z2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( -halfHeight, y1, z1);
        vertex( halfHeight, y2, z2);
    }
    endShape(CLOSE);
    //drawPoints();
    popMatrix();
} 
float L2Norm(PVector p)
{
  return sqrt(p.x*p.x+p.y*p.y+p.z*p.z);
}
boolean hasCollided(PVector q)
{
   PVector vec = PVector.sub(pt2 , pt1);
   PVector temp=new PVector(vec.x,vec.y,vec.z);
   temp.normalize();
   temp.x*=r1;
   temp.y*=r1;
   temp.z*=r1;
   
  
   boolean flag1=(PVector.dot(PVector.sub(q,pt1),vec))>=0;
   boolean flag2=(PVector.dot(PVector.sub(q,pt2),vec))<=0;
   PVector tempFlag3=new PVector(0,0,0);
   tempFlag3=PVector.cross(PVector.sub(q, pt1), vec,tempFlag3);
   boolean flag3=L2Norm(tempFlag3)/L2Norm(vec)<=r1*1.1;
   //println(flag1,flag2,flag3);
   return flag1 && flag2 && flag3;
   
}
PVector computeProjection( PVector A) {
    float di=dist(pt2.x,pt2.y,pt2.z, pt1.x,pt1.y,pt1.z);
    PVector d = PVector.sub(pt2 , pt1);
    float dix=d.x / di;
    float diy=d.y / di;
    float diz=d.z / di;
    d= new PVector (dix ,diy,diz);
    PVector v = PVector.sub(A , pt1);
    float t =PVector.dot(v,d);
    PVector P =new PVector (t*d.x ,d.y*t,d.z*t);
    P = PVector.add(pt1 , P);
    return P ;
}
}
