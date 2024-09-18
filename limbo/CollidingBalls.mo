model CollidingBalls

model Ball
  Real x;   // State for the position
  Real v;   // State for the velocity
  parameter Real x0;   // Initial position
  parameter Real v0;   // Initial velocity
  parameter Real m;    // Mass of the ball
  parameter Real r;    // Radius
initial equation
  x = x0;
  v = v0;
equation
  der(x) = v;     // Relation between position and speed  
  der(v) = 0;     // Constant speed, no acceleration
end Ball;

model ThreeBalls
  Ball b1(x0=-5, v0= 1, r=0.5, m=1);
  Ball b2(x0= 0, v0= 0, r=0.5, m=2);
  Ball b3(x0= 5, v0=-1, r=0.5, m=1);
equation
  when b2.x - b1.x <= b1.r + b2.r then  
    reinit(b1.v, (2*b2.m*pre(b2.v) + b1.m*pre(b1.v) - b2.m*pre(b1.v))/(b1.m + b2.m));
    reinit(b2.v, (2*b1.m*pre(b1.v) + b2.m*pre(b2.v) - b1.m*pre(b2.v))/(b1.m + b2.m));
  end when;
  when b3.x - b2.x <= b2.r + b3.r then  
    reinit(b2.v, (2*b3.m*pre(b3.v) + b2.m*pre(b2.v) - b3.m*pre(b2.v))/(b2.m + b3.m));
    reinit(b3.v, (2*b2.m*pre(b2.v) + b3.m*pre(b3.v) - b2.m*pre(b3.v))/(b2.m + b3.m));
  end when;
end ThreeBalls;


ThreeBalls m;

end CollidingBalls;
