float length, margin;
Color[][] colors;
int actx, acty;
float pressX, pressY;
void setup() {
  colors = new Color[8][8];
  for (int x = 0; x < 8; x++) {
    for (int y = 0; y < 8; y++) {
      colors[x][y] = new Color(0, 0, 0);
    }
  }
  actx = 0; acty = 0;
}
void draw() {
  length = min(width, height)/9;
  margin = length/9;
  background(24);
  for (int x = 0; x < 8; x++) {
    for (int y = 0; y < 8; y++) {
      float dx = (margin+length)*x+margin,
        dy = (margin+length)*y+margin;
      if (x==actx&&y==acty) {
        stroke(255);
        strokeWeight(4);
      } else {
        stroke(64);
        strokeWeight(2);
      }
      colors[x][y].fill_color();
      rect(dx, dy, length, length);
    }
  }
  if (width<height) {
    float dy = (length+margin)*9+margin;
    textAlign(LEFT, CENTER);
    textSize(length);
    fill(255);
    stroke(255);
    text("r: "+(int)(colors[actx][acty].r*256), margin, dy);
    text("g: "+(int)(colors[actx][acty].g*256), margin, dy+(length+margin)*1);
    text("b: "+(int)(colors[actx][acty].b*256), margin, dy+(length+margin)*2);
    textAlign(CENTER, CENTER);
    for (int y = 0; y < 3; y++) {
      text("--", margin+length*3, dy+(length+margin)*y);
      text("-", margin+length*4, dy+(length+margin)*y);
      text("+", margin+length*5, dy+(length+margin)*y);
      text("++", margin+length*6, dy+(length+margin)*y);
    }
  } else {
    float dx = (length+margin)*8.2+margin;
    textAlign(LEFT, CENTER);
    textSize(length);
    fill(255);
    stroke(255);
    text("r: "+(int)(colors[actx][acty].r*256), margin+dx, margin+(length+margin)*.5);
    text("g: "+(int)(colors[actx][acty].g*256), margin+dx, margin+(length+margin)*1.5);
    text("b: "+(int)(colors[actx][acty].b*256), margin+dx, margin+(length+margin)*2.5);
    textAlign(CENTER, CENTER);
    for (int y = 0; y < 3; y++) {
      text("--", dx+margin+length*3, (length+margin)*(y+.5));
      text("-", dx+margin+length*4, (length+margin)*(y+.5));
      text("+", dx+margin+length*5, (length+margin)*(y+.5));
      text("++", dx+margin+length*6, (length+margin)*(y+.5));
    }
  }
}
void mousePressed() {
  pressX = mouseX;
  pressY = mouseY;
  if (max(mouseY, mouseX)<(length+margin)*8+margin) {
    actx = (int)((float)(mouseX-margin)/(length+margin));
    acty = (int)((float)(mouseY-margin)/(length+margin));
  }
  if (max(mouseY, mouseX)>(length+margin)*8+margin) {
    float dx, dy;
    if (width<height) {
      dx = mouseX-margin-length*3;
      dy = mouseY-margin-(margin+length)*9;
    } else {
      dx = mouseX-margin-(margin+length)*8.2;
      dy = mouseY-margin-(margin+length)*.5;
      
    }
    
    int x = (int)(dx/length+.35);
    float ax;
    if (x==0) {
      ax = -1f/32f;
    } else if (x==1) {
      ax = -1f/256f;
    } else if (x==2) {
      ax = 1f/256f;
    } else {
      ax = 1f/32f;
    }
    int y = (int)(dy/(length+margin)+.45);
    Color actc = colors[actx][acty];
    if (y==0) {
      actc.r = max(min(actc.r + ax, 1), 0);
    } else if (y==1) {
      actc.g = max(min(actc.g + ax, 1), 0);
    } else if (y==2) {
      actc.b = max(min(actc.b + ax, 1), 0);
    }
  }
}
void mouseReleased() {
  if (max(max(pressX, pressY), max(mouseX, mouseY))<(length+margin)*8+margin) {
    int actx2 = (int)((float)(mouseX-margin)/(length+margin));
    int acty2 = (int)((float)(mouseY-margin)/(length+margin));
    if (actx2!=actx&&acty2==acty||actx2==actx&&acty2!=acty) {
      
      if (acty2==acty&&abs(actx2-actx)>1) {
        Color end = colors[min(actx, actx2)][acty];
        Color start = colors[max(actx, actx2)][acty2];
        for (int x = min(actx2, actx)+1; x < max(actx2, actx); x++) {
          colors[x][acty] = gradient(start, end, (float)(x-min(actx2, actx))/abs(actx2-actx));
        }
      }
      
      if (actx2==actx&&abs(acty2-acty)>1) {
        Color end = colors[actx][min(acty, acty2)];
        Color start = colors[actx][max(acty, acty2)];
        for (int y = min(acty2, acty)+1; y < max(acty2, acty); y++) {
          colors[actx][y] = gradient(start, end, (float)(y-min(acty2, acty))/abs(acty2-acty));
        }
      }
    }
  }
}