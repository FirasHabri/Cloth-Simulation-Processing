class SphereObject{
  PVector center;
  float radius;
  public SphereObject(PVector center,float radius)
  {
      this.center=center;
      this.radius=radius;
  }
  public void Draw()
  {
    pushMatrix();
    noStroke();
    translate(center.x,center.y,center.z);
    sphere(radius);
    popMatrix();
  }
  public boolean hasCollided(PVector particlePos)
  {
    float d=dist(center.x,center.y,center.z,particlePos.x,particlePos.y,particlePos.z);
    if(d<=radius+10)
    {
        return true;
    }

    return false;
  }
}
