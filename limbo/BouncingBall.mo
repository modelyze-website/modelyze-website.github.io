model BouncingBall
  Real h,v;
  parameter Real c = 0.7;
initial equation
  h = 3.0;
equation
  der(h) = v;
  der(v) = -9.81;
  when h <= 0 then
    reinit(v, -c*pre(v));
  end when; 
end BouncingBall;
