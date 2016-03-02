
left = 0;
right = 0;

//We only have goal position
//Here we calculate the angle from the positions
dy = yg-y0;
dx = xg-x0;
if(dx == 0){ // I don't want to divide by zero plz
   dx = 0.0001f;
}
goaltheta = atan(dy/dx)*180/M_PI;
if(dx < 0){
  goaltheta += 180;
 }
//K = 3.0f;
//goaltheta = (goaltheta-theta);
if(goaltheta > 180) goaltheta -= 360;
if(goaltheta < -180) goaltheta += 360;

dy = yg-y;
dx = xg-x;
if(dx == 0){
    dx = 0.0001f;
}	
desiredtheta = atan(dy/dx)*180/M_PI;
if(dx < 0){
  desiredtheta += 180;
 }
desiredtheta = desiredtheta-theta;
if(desiredtheta > 180) desiredtheta -= 360;
if(desiredtheta < -180) desiredtheta += 360;

//Controller for rotation
K_rot = 1.0f*L/R;
K_trans = 10.0f;
K_p = 10.0f;
p = 20.0f;


//Controller for translation
d0 = (cos(theta*M_PI/180) *(x0 -x) + sin(theta*M_PI/180)*(y0 -y));

dg = (cos(goaltheta*M_PI/180) *(xg -x) + sin(goaltheta*M_PI/180)*(yg -y));
/*
if(goaltheta == 90){
    theta +=1;
}
*/
dp = sin(goaltheta*M_PI/180)*(x+p*cos(theta*M_PI/180) -x0) -
  cos(goaltheta*M_PI/180)*(y+p*sin(theta*M_PI/180) -y0);

u_rot = dp*K_p;
u_trans = dg*K_trans;
//u_rot = 0;//K_rot*desiredtheta;
if(c_state == 0){
   u_rot = K_rot*desiredtheta;
   u_trans = d0*K_trans;
   if(abs(desiredtheta) < 5){
    dy = y0-y;
    dx = x0-x;
 Serial.print("dy;\n");
Serial.print(dy, DEC);
Serial.print(";\n");
 Serial.print("dx;\n");
Serial.print(dx, DEC);
Serial.print(";\n");
    if(abs(dy) < 4.0f && abs(dx) < 4.0f){
        c_state = 1;
    }
   }
}
if(c_state == 1){
    u_rot = dp*K_p;
    u_trans = dg*K_trans;
    dy = yg-y;
    dx = xg-x;
 Serial.print("dy;\n");
Serial.print(dy, DEC);
Serial.print(";\n");
 Serial.print("dx;\n");
Serial.print(dx, DEC);
Serial.print(";\n");
    if(abs(dy) < 2.0f && abs(dx) < 2.0f){
        c_state = 2;
    }
}
if(c_state == 2){
    u_rot = 0;
    u_trans = 0;
}

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
Serial.print("desiredtheta");
Serial.print(desiredtheta, DEC);
Serial.print(";\n");
Serial.print("state");
Serial.print(c_state, DEC);
Serial.print(";\n");
