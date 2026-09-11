x += hspd;
y += vspd;
vspd = lerp(vspd, 0, 0.05);

alpha -= 0.02;

if (alpha <= 0) {
    instance_destroy();
}