
//xg, yg is goal positions
//x, y, theta is measured values
//left, right is output to wheels

left = 0;
right = 0;

//We only have goal position
//Here we calculate the angle from the positions
dy = yg-y;
dx = xg-x;

//All this mess is due to atan
if(dx < 0){ 
  goaltheta = atan(dy/dx)*180/M_PI;
  if(dy < 0){
    goaltheta +=180;
  }
  else{
    goaltheta -=180;
  } 
 }else{
  goaltheta = atan(dy/dx)*180/M_PI;
 }

//Our signal is limited to -180 to 180
if(goaltheta < 180) goaltheta += 360; 
if(goaltheta > 180) goaltheta -= 360;


//Controller for rotation
K_rot = 0.5f*L/R;
//K = 3.0f;
u_rot = K_rot*(goaltheta -theta);

//Controller for translation
K_trans = 0.05f;
u_trans = K_trans*(cos(theta)*180/M_PI *(x0 -x) + sin(theta)*180/M_PI* (y0 -y));

left += round(u_trans);
right += round(u_trans);

left += round(-u_rot);
right +=round(u_rot);

//Debugprints to MainWindow. 
Serial.print(" goaltheta=(degree)");
Serial.print(goaltheta, DEC);
Serial.print(";\n");
Serial.print(" u_trans");
Serial.print(u_trans, DEC);
Serial.print(";\n");
Serial.print("u_rot");
Serial.print(u_rot, DEC);
Serial.print(";\n");
