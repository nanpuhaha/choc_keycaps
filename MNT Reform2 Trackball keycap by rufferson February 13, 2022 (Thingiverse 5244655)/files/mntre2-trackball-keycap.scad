base_w=13.8;
base_l=13.8;
base_h=5.7;
base_rh=0.5;
base_rt=0.8;

shaft_w=10.4;
shaft_l=4.5;
shaft_h=3;
shaft_kw=3.1;
shaft_kl=1.2;
shaft_kr=0.5;
shaft_hw=1.2;
shaft_hl=3;
shaft_hi=4.5; // 5.7 - 1.2
shaft_ho=6.9; // 5.7 + 1.2

stem_h=2.8;
stem_l2=2.95; // hole is 3
stem_l1=1;
stem_w1=0.75;
stem_w2=1.11; // hole is 1.2
stem_si=4.6;
stem_so=6.82;
stem_rs=5.4;
button_l=29;
button_w=23.35;
button_h=5;
button_t=1.2;
circle_r = 15;
kpad_w=70;

show_switch=0;
show_keycap=1;
add_rim=0;

module kc_lp_shaft() {
  union() {
   cube([shaft_w, shaft_l, shaft_h]);
   translate([(shaft_w-shaft_kw)/2, -shaft_kl,0])
    cube([shaft_kw,shaft_kl,shaft_h]);
  }
}
module kc_lp_b_sw() {
  color("white",0.8)
 cube([base_w, base_l, base_h]);
 translate([(base_w-shaft_w)/2-base_rt, (base_l-shaft_l)/2-base_rt, base_h]) {
   color("white",0.7)
  cube([shaft_w+base_rt*2,shaft_l+base_rt*2,base_rh]);
  translate([base_rt,base_rt,0]) {
    difference() {
      color("Brown")
      kc_lp_shaft();
      translate([(shaft_w-shaft_ho)/2,(shaft_l-shaft_hl)/2,0]) {
      cube([shaft_hw,shaft_hl,shaft_h+1]);
        translate([shaft_ho-shaft_hw,0,0])
        cube([shaft_hw,shaft_hl,shaft_h+1]);
      }
    }
  }
 }
}
off=2.6;
sup=0.8;
$fn=96;
if(show_keycap)
translate([(base_w-button_w)/2-off,(base_l-button_l)/2,base_h+shaft_h+button_t-button_h]) {
 union() {
  difference() {
   cube([button_w,button_l,button_h]);
   translate([(button_w-base_w)/2-0.2+off,(button_l-base_l)/2-0.2,-button_t])
    cube([base_w+0.4,base_l+0.4,button_h]);
    translate([button_w-kpad_w/2+off+1,button_l/2,button_h+1])
     sphere(circle_r);
  }
  // Stems
  translate([(button_w-stem_so)/2+off,(button_l-stem_l2)/2,button_h-button_t-stem_h]) {
     cube([stem_w2,stem_l2,stem_h]);
     translate([shaft_ho-shaft_hw,0,0])
      cube([stem_w2,stem_l2,stem_h]);
  }
  if(add_rim)
  // rim
  difference() {
   translate([(button_w-shaft_w)/2-base_rt+off,(button_l-shaft_l)/2-base_rt,button_h-button_t-sup]) {
    cube([shaft_w+base_rt*2,shaft_l+base_rt*2,sup]);
    translate([(shaft_w-shaft_kw)/2,base_rt-shaft_kl*2,-base_rh]) {
     cube([shaft_kw+base_rt*2,shaft_kl*2,sup+base_rh]);
     translate([0,shaft_l+shaft_kl*2,0])
      cube([shaft_kw+base_rt*2,shaft_kl*2,sup+base_rh]);
    }
   }
   // shaft hole
   translate([(button_w-shaft_w)/2+off,(button_l-shaft_l)/2,button_h-button_t-shaft_h]) {
      kc_lp_shaft();
    rotate([0,0,180])
     translate([-shaft_w,-shaft_l,0])
          kc_lp_shaft();
   }
  }
 }
}

if(show_switch)
 kc_lp_b_sw();

