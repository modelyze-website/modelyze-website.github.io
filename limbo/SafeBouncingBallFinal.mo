model SafeBouncingBallFinal
  Real h,v;
  discrete Real a(start = -9.81);
  parameter Real c = 0.7;
  parameter Real epsilon = 1e-8;
  Boolean limbo;
initial equation
  h = 3.0;
  v = 0;
  limbo = false;
equation
  der(h) = v;
  der(v) = a;
  when h <= 0 then
    reinit(v, -c*pre(v));
  end when;
  
  //Limbo state action
  when limbo then
    reinit(v,0);
    a = 0;
  end when;  
  // Detecting limbo level
  when h <= -epsilon then
    limbo = true;
  end when;
  // Detecting unsafe level
  when h <= -2*epsilon then
    terminate("Unsafe Zero Crossing");
  end when; 
end SafeBouncingBallFinal;
