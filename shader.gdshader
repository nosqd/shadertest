shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

float character(int n, vec2 p)
{
	p = floor(p*vec2(-4.0, 4.0) + 2.5);
    if (clamp(p.x, 0.0, 4.0) == p.x)
	{
        if (clamp(p.y, 0.0, 4.0) == p.y)	
		{
        	int a = int(round(p.x) + 5.0 * round(p.y));
			if (((n >> a) & 1) == 1) return 1.0;
		}	
    }
	return 0.0;
}

void fragment()
{
	vec2 pix = FRAGCOORD.xy;
	vec3 col = texture(SCREEN_TEXTURE, floor(pix/8.0)*8.0/(1.0/SCREEN_PIXEL_SIZE).xy).rgb;	
	
	float gray = 0.3 * col.r + 0.59 * col.g + 0.11 * col.b;
	    
	int n =  4096;
    
    // limited character set
    if (gray > 0.2) n = 65600;    // :
	if (gray > 0.3) n = 163153;   // *
	if (gray > 0.4) n = 15255086; // o 
	if (gray > 0.5) n = 13121101; // &
	if (gray > 0.6) n = 15252014; // 8
	if (gray > 0.7) n = 13195790; // @
	if (gray > 0.8) n = 11512810; // #
   
    
	vec2 p = mod(pix/4.0, 2.0) - vec2(1.0);
    
	col = col*character(n, p);
	
	COLOR = vec4(col, 1.0);
}