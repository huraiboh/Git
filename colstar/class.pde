class Ball {
  float posX;
  float posY;
  float speedX;
  float speedY;
  int num;

  Ball(int n) {
    num=n;
    int col=1;
    while (col>0) {
      col=0;
      posX=random(width);
      posY=random(height);
      for (int i=0; i<num; i++) {
        if (dist(posX, posY, ball[i].posX, ball[i].posY)<30) {
          col++;
        }
      }
    }
    speedX=random(5);
    speedY=random(5);
  }
  void move() {
    posX += speedX;
    posY += speedY;
    if ( posX > width-15 ) {
      posX = width - 15;
      speedX = -speedX;
    }
    if ( posX < 15 ) {
      posX = 15;
      speedX = -speedX;
    }
    if ( posY > height-15) {
      posY = height - 15;
      speedY = -speedY;
    }
    if ( posY - 15 < 0 ) {
      posY = 15;
      speedY = -speedY;
    }

    col();
  }
  void col() {
    for (int i=num; i>=0; i--) {
      //f_2*f^2+f_1*f+f_0=0
      float dx=posX-ball[i].posX;
      float dsx=speedX-ball[i].speedX;
      float dy=posY-ball[i].posY;
      float dsy=speedY-ball[i].speedY;

      float f_2=sq(dsx)+sq(dsy);
      float f_1=2*(dx*dsx+dy*dsy);
      float f_0=sq(dx)+sq(dy)-900;

      float E=sq(f_1)-4*f_2*f_0;

      if (E>=0) {
        float f0=(-f_1-sqrt(E))/(2*f_2);
        float f1=(-f_1+sqrt(E))/(2*f_2);  

        boolean hit=false;
        if (0<=f0&&f0<1) {
          
          posX+=speedX*f0;
          posY+=speedY*f0;
          ball[i].posX+=ball[i].speedX*f0;
          ball[i].posY+=ball[i].speedY*f0;
          
          hit=true;
        }else if(f0*f1<0) {
          float len=dist(posX, posY, ball[i].posX, ball[i].posY);
          float normal=len!=0?1/len:0;
          float dist=30-len;

          dx*=normal;
          dy*=normal;

          dist/=2.0;
          posX+=dx*dist;
          posY+=dy*dist;
          ball[i].posX-=dx*dist;
          ball[i].posY-=dy*dist;

          hit=true;
        }

        if (hit) {
          float t;

          t = -(dx * speedX + dy * speedY) / (dx * dx + dy * dy);
          float arx = speedX + dx * t;
          float ary = speedY + dy * t;

          t = -(-dy * speedX + dx * speedY) / (dy * dy + dx * dx);
          float amx = speedX - dy * t;
          float amy = speedY + dx * t;

          t = -(dx * ball[i].speedX + dy * ball[i].speedY) / (dx * dx + dy * dy);
          float brx = ball[i].speedX + dx * t;
          float bry = ball[i].speedY + dy * t;

          t = -(-dy * ball[i].speedX + dx * ball[i].speedY) / (dy * dy + dx * dx);
          float bmx = ball[i].speedX - dy * t;
          float bmy = ball[i].speedY + dx * t;        

          speedX = bmx + arx;
          speedY = bmy + ary;
          ball[i].speedX = amx + brx;
          ball[i].speedY = amy + bry;
        }
      }
    }
  }

  void disp() {
    fill(#FF0000);
    noStroke();
    ellipse( posX, posY, 30, 30 );
  }
}

