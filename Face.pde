class Face{
  float Min(float x1,float x2,float x3,float x4)
  {
    return min(min(x1,x2),min(x3,x4));
  }
  float Max(float x1,float x2,float x3,float x4)
  {
    return max(max(x1,x2),max(x3,x4));
  }
  
  float[] minD,maxD;
  int dumpedDimension;
  
  boolean hasCrossedThisFace(int idx,PVector pt)
  {
    
    if(idx==0)
    { 
      boolean flag1=pt.x>=minD[0] && pt.x<=maxD[0];
      boolean flag2=pt.y+40>=minD[1] && pt.y+40<=maxD[1];
      boolean flag3=pt.z>=minD[2] && pt.z<=maxD[2];
      
      return flag1&&flag2&&flag3;
        
    }
    else if(idx==1)
    {
      boolean flag1=pt.x>=minD[0] && pt.x<=maxD[0];
      boolean flag2=pt.y-40<=minD[1] && pt.y-40>=maxD[1];
      boolean flag3=pt.z>=minD[2] && pt.z<=maxD[2];
      
      return flag1&&flag2&&flag3;
        
    }
    else if(idx==2)
    {
     
      boolean flag1=pt.x+40>=minD[0] && pt.x+40<=maxD[0];
      boolean flag2=pt.y>=minD[1] && pt.y<=maxD[1];
      boolean flag3=pt.z>=minD[2] && pt.z<=maxD[2];
      
      return flag1&&flag2&&flag3;
        
    }
    else if(idx==3)
    {
      boolean flag1=pt.x-40<=minD[0] && pt.x-40>=maxD[0];
      boolean flag2=pt.y>=minD[1] && pt.y<=maxD[1];
      boolean flag3=pt.z>=minD[2] && pt.z<=maxD[2];
      
      return flag1&&flag2&&flag3;
        
    }
    
    else if(idx==4)
    {
      boolean flag1=pt.x>=minD[0] && pt.x<=maxD[0];
      boolean flag2=pt.y>=minD[1] && pt.y<=maxD[1];
      boolean flag3=pt.z-40>=minD[2] && pt.z-40<=maxD[2];
      
      return flag1&&flag2&&flag3;
        
    }
    else if(idx==5)
    {
      boolean flag1=pt.x>=minD[0] && pt.x<=maxD[0];
      boolean flag2=pt.y>=minD[1] && pt.y<=maxD[1];
      boolean flag3=pt.z+40<=minD[2] && pt.z+40>=maxD[2];
      
      return flag1&&flag2&&flag3;
        
    }
  
    
    return false;
  }
  
  public Face(PVector v1,PVector v2,PVector v3,PVector v4,int dumpedDimension,float additionalDim)
  {
      minD=new float[3];
      maxD=new float[3];
      this.dumpedDimension=dumpedDimension;
      
      if(this.dumpedDimension==1)
      {
        minD[1]=Min(v1.y,v2.y,v3.y,v4.y);
        maxD[1]=Max(v1.y,v2.y,v3.y,v4.y);
        
        minD[0]=v1.x;
        maxD[0]=additionalDim;
        
        minD[2]=Min(v1.z,v2.z,v3.z,v4.z);
        maxD[2]=Max(v1.z,v2.z,v3.z,v4.z);
       
      }
      
      if(this.dumpedDimension==2)
      {
        minD[0]=Min(v1.x,v2.x,v3.x,v4.x);
        maxD[0]=Max(v1.x,v2.x,v3.x,v4.x);
        
        minD[1]=v1.y;
        maxD[1]=additionalDim;
        
        minD[2]=Min(v1.z,v2.z,v3.z,v4.z);
        maxD[2]=Max(v1.z,v2.z,v3.z,v4.z);
       
      }
      else if(this.dumpedDimension==3)
      {
        minD[0]=Min(v1.x,v2.x,v3.x,v4.x);
        maxD[0]=Max(v1.x,v2.x,v3.x,v4.x);
        
        minD[2]=v1.z;
        maxD[2]=additionalDim;
        
        minD[1]=Min(v1.y,v2.y,v3.y,v4.y);
        maxD[1]=Max(v1.y,v2.y,v3.y,v4.y);
      }
  }
  boolean flag=false;
  public void Draw()
  {
    if(this.dumpedDimension==1)
      {
        
        stroke(255,0,0);
        beginShape();
        vertex(minD[0],minD[1],minD[2]);
        vertex(minD[0],maxD[1],minD[2]);
        vertex(minD[0],maxD[1],maxD[2]);
        vertex(minD[0],minD[1],maxD[2]);
        endShape();
        noStroke();
      }
      else if(this.dumpedDimension==2)
      {
        stroke(0,255,0);
        
        beginShape();
        vertex(minD[0],minD[1],minD[2]);
        vertex(maxD[0],minD[1],minD[2]);
        vertex(maxD[0],minD[1],maxD[2]);
        vertex(minD[0],minD[1],maxD[2]);
        endShape();
        noStroke();
      }
      else
      {
        stroke(0,0,255);
        beginShape();
        vertex(minD[0],minD[1],minD[2]);
        vertex(maxD[0],minD[1],minD[2]);
        vertex(maxD[0],maxD[1],minD[2]);
        vertex(minD[0],maxD[1],minD[2]);
        endShape();
        noStroke();
      }
      
  }
  
}
