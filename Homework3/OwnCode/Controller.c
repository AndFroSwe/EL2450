
left = 0;
right = 0;

//We only have goal position
//Here we calculate the angle from the positions
dy = yg-y0;
dx = xg-x0;
if(dx != 0){
  goaltheta = atan(dy/dx)*180/M_PI;
 }
if(dx < 0){
  goaltheta += 180;
 }
//K = 3.0f;
//goaltheta = (goaltheta-theta);
if(goaltheta > 180) goaltheta -= 360;
if(goaltheta < -180) goaltheta += 360;

dy = yg-y;
dx = xg-x;
if(dx != 0){
  desiredtheta = atan(dy/dx)*180/M_PI;
 }
if(dx < 0){
  desiredtheta += 180;
 }
desiredtheta = desiredtheta-theta;
if(desiredtheta > 180) desiredtheta -= 360;
if(desiredtheta < -180) desiredtheta += 360;

//Controller for rotation
K_rot = 1.0f*L/R;
K_trans = 5.0f;
K_p = 5.0f;
p = 1.0f;


//Controller for translation
d0 = (cos(theta*M_PI/180) *(x0 -x) + sin(theta*M_PI/180)*(y0 -y));
dg = (cos(goaltheta*M_PI/180) *(xg -x) + sin(goaltheta*M_PI/180)*(yg -y));
dp = sin(goaltheta*M_PI/180)*(x+p*cos(theta*M_PI/180) -x0) -
  cos(goaltheta*M_PI/180)*(y+p*sin(theta*M_PI/180) -y0);

//u_rot = dp*K_p;
u_trans = dg*K_trans;
u_rot = K_rot*desiredtheta;

if(abs(u_rot) > 30){
  u_trans = 0;
 }else{
  u_rot = 0;
 }

dy = yg-y;
dx = xg-x;
if(abs(dy) < 0.1f && abs(dx) < 0.1f){
  u_trans = 0;
  u_rot = 0;
 }

//u_trans = K_trans*d0;
left += round(u_trans);
right += round(u_trans);

left += round(-u_rot/2);
right+= round(u_rot/2);

//Debugprints to MainWindow.
Serial.print(d0, DEC);
Serial.print("\n;");

Serial.print("goaltheta=(degree);\n");
Serial.print(goaltheta, DEC);
Serial.print(";\n");
Serial.print("urot;\n");
Serial.print(u_rot, DEC);
Serial.print(";\n");
Serial.print("u_trans");
Serial.print(u_trans, DEC);
Serial.print(";\n");
Serial.print("sin");
Serial.print(sin(theta*M_PI/180), DEC);
Serial.print(";\n");
Serial.print("atan(dy/dx)");
Serial.print(atan(dy/dx)*180/M_PI, DEC);
Serial.print(";\n");
