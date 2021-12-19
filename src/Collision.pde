class Collision{// lgtm [java/unused-reference-type]
	boolean pointPoint(Point p1,Point p2){
		return (p1.x==p2.x&&p1.y==p2.y);
	}



	boolean pointCircle(Point p,Circle c){
		return (sqrt((p.x-c.x)*(p.x-c.x)+(p.y-c.y)*(p.y-c.y))<=c.r);
	}



	boolean pointLine(Point p,Line l){
		float buffer=0.1;
		return (dist(p.x,p.y,l.sx,l.sy)+dist(p.x,p.y,l.ex,l.ey)>=dist(l.sx,l.sy,l.ex,l.ey)-buffer&&dist(p.x,p.y,l.sx,l.sy)+dist(p.x,p.y,l.ex,l.ey)<=dist(l.sx,l.sy,l.ex,l.ey)+buffer);
	}



	boolean pointTri(Point p,Triangle t){
		return (abs((t.sx-p.x)*(t.my-p.y)-(t.mx-p.x)*(t.sy-p.y))+abs((t.mx-p.x)*(t.ey-p.y)-(t.ex-p.x)*(t.my-p.y))+abs((t.ex-p.x)*(t.sy-p.y)-(t.sx-p.x)*(t.ey-p.y))==abs((t.mx-t.sx)*(t.ey-t.sy)-(t.ex-t.sx)*(t.my-t.sy)));
	}



	boolean pointRect(Point p,Rect r){
		return (r.x<=p.x&&p.x<=r.x+r.w&&r.y<=p.y&&p.y<=r.y+r.h);
	}



	boolean pointPoly(Point pt,Polygone pl){
		boolean c=false;
		for (int i=0;i<pl.vl.length;i++){
			if (((pl.vl[i].y>pt.y&&pl.vl[(i+1)%pl.vl.length].y<pt.y)||(pl.vl[i].y<pt.y&&pl.vl[(i+1)%pl.vl.length].y>pt.y))&&(pt.x<(pl.vl[(i+1)%pl.vl.length].x-pl.vl[i].x)*(pt.y-pl.vl[i].y)/(pl.vl[(i+1)%pl.vl.length].y-pl.vl[i].y)+pl.vl[i].x)){
				c=!c;
			}
		}
		return c;
	}



	boolean lineCircle(Line l,Circle c){
		if (new Collision().pointCircle(new Point(l.sx,l.sy),c)||new Collision().pointCircle(new Point(l.ex,l.ey),c)){
			return true;
		}
		if (!new Collision().pointLine(new Point(l.sx+(((((c.x-l.sx)*(l.ex-l.sx))+((c.y-l.sy)*(l.ey-l.sy)))/((l.sx-l.ex)*(l.sx-l.ex)+(l.sy-l.ey)*(l.sy-l.ey)))*(l.ex-l.sx)),l.sy+(((((c.x-l.sx)*(l.ex-l.sx))+((c.y-l.sy)*(l.ey-l.sy)))/((l.sx-l.ex)*(l.sx-l.ex)+(l.sy-l.ey)*(l.sy-l.ey)))*(l.ey-l.sy))),l)){
			return false;
		}
		return (sqrt((l.sx+(((((c.x-l.sx)*(l.ex-l.sx))+((c.y-l.sy)*(l.ey-l.sy)))/((l.sx-l.ex)*(l.sx-l.ex)+(l.sy-l.ey)*(l.sy-l.ey)))*(l.ex-l.sx))-c.x)*(l.sx+(((((c.x-l.sx)*(l.ex-l.sx))+((c.y-l.sy)*(l.ey-l.sy)))/((l.sx-l.ex)*(l.sx-l.ex)+(l.sy-l.ey)*(l.sy-l.ey)))*(l.ex-l.sx))-c.x)+(l.sy+(((((c.x-l.sx)*(l.ex-l.sx))+((c.y-l.sy)*(l.ey-l.sy)))/((l.sx-l.ex)*(l.sx-l.ex)+(l.sy-l.ey)*(l.sy-l.ey)))*(l.ey-l.sy))-c.y)*(l.sy+(((((c.x-l.sx)*(l.ex-l.sx))+((c.y-l.sy)*(l.ey-l.sy)))/((l.sx-l.ex)*(l.sx-l.ex)+(l.sy-l.ey)*(l.sy-l.ey)))*(l.ey-l.sy))-c.y))<=c.r);
	}



	boolean lineLine(Line l1,Line l2){
		if (((l2.ex-l2.sx)*(l1.sy-l2.sy)-(l2.ey-l2.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))>=0&&((l2.ex-l2.sx)*(l1.sy-l2.sy)-(l2.ey-l2.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))<=1&&((l1.ex-l1.sx)*(l1.sy-l2.sy)-(l1.ey-l1.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))>=0&&((l1.ex-l1.sx)*(l1.sy-l2.sy)-(l1.ey-l1.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))<=1){
			return true;
		}
		return false;
	}



	boolean lineRect(Line l,Rect r){
		return (new Collision().lineLine(l,new Line(r.x,r.y,r.x,r.y+r.h))||new Collision().lineLine(l,new Line(r.x+r.w,r.y,r.x+r.w,r.y+r.h))||new Collision().lineLine(l,new Line(r.x,r.y,r.x+r.w,r.y))||new Collision().lineLine(l,new Line(r.x,r.y+r.h,r.x+r.w,r.y+r.h)));
	}



	boolean linePoly(Line l,Polygone p){
		for (int i=0;i<p.vl.length;i++){
			if (new Collision().lineLine(l,new Line(p.vl[i].x,p.vl[i].y,p.vl[(i+1)%p.vl.length].x,p.vl[(i+1)%p.vl.length].y))){
				return true;
			}
		}
		return false;
	}



	boolean polyCircle(Polygone p,Circle c){
		for (int i=0;i<p.vl.length;i++){
			if (new Collision().lineCircle(new Line(p.vl[i].x,p.vl[i].y,p.vl[(i+1)%p.vl.length].x,p.vl[(i+1)%p.vl.length].y),c)){
				return true;
			}
		}
		return false;
	}



	boolean polyRect(Polygone p,Rect r){
		for (int i=0;i<p.vl.length;i++){
			if (new Collision().lineRect(new Line(p.vl[i].x,p.vl[i].y,p.vl[(i+1)%p.vl.length].x,p.vl[(i+1)%p.vl.length].y),r)||new Collision().pointPoly(new Point(r.x,r.y),p)){
				return true;
			}
		}
		return false;
	}



	boolean polyPoly(Polygone p1,Polygone p2){
		for (int i=0;i<p1.vl.length;i++){
			if (new Collision().linePoly(new Line(p1.vl[i].x,p1.vl[i].y,p1.vl[(i+1)%p1.vl.length].x,p1.vl[(i+1)%p1.vl.length].y),p2)||new Collision().pointPoly(new Point(p2.vl[0].x,p2.vl[0].y),p1)){
				return true;
			}
		}
		return false;
	}



	PVector intersectionLineLine(Line l1,Line l2){
		if (new Collision().lineLine(l1,l2)==true){
			return new PVector(l1.sx+(((l2.ex-l2.sx)*(l1.sy-l2.sy)-(l2.ey-l2.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))*(l1.ex-l1.sx)),l1.sy+(((l2.ex-l2.sx)*(l1.sy-l2.sy)-(l2.ey-l2.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))*(l1.ey-l1.sy)));
		}
		return null;
	}
}



class Point{
	float x;
	float y;



	Point(float x,float y){
		this.x=x;
		this.y=y;
	}
}



class Line{
	float sx;
	float sy;
	float ex;
	float ey;



	Line(float sx,float sy,float ex,float ey){
		this.sx=sx;
		this.sy=sy;
		this.ex=ex;
		this.ey=ey;
	}
}



class Circle{
	float x;
	float y;
	float r;



	Circle(float x,float y,float r){
		this.x=x;
		this.y=y;
		this.r=r;
	}
}



class Rect{
	float x;
	float y;
	float w;
	float h;



	Rect(float x,float y,float w,float h){
		this.x=x;
		this.y=y;
		this.w=w;
		this.h=h;
	}
}



class Triangle{
	float sx;
	float sy;
	float mx;
	float my;
	float ex;
	float ey;



	Triangle(float sx,float sy,float mx,float my,float ex,float ey){
		this.sx=sx;
		this.sy=sy;
		this.mx=mx;
		this.my=my;
		this.ex=ex;
		this.ey=ey;
	}
}



class Polygone{
	PVector[] vl;



	Polygone(PVector[] vl){
		this.vl=vl;
	}
}
