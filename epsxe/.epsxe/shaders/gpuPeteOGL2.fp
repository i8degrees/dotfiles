!!ARBfp1.0

TEMP color0, color1, color2, color3, color4;
TEMP temp;

PARAM cutoff = {0.2, 0.2, 0.2, 0.0 };
PARAM divEight = { 0.125, 0.125, 0.125, 0.0 };

TEX color0, fragment.texcoord[ 0 ], texture[ 0 ], 2D;
TEX color1, fragment.texcoord[ 1 ], texture[ 0 ], 2D;
TEX color2, fragment.texcoord[ 2 ], texture[ 0 ], 2D;
TEX color3, fragment.texcoord[ 3 ], texture[ 0 ], 2D;
TEX color4, fragment.texcoord[ 4 ], texture[ 0 ], 2D;

# remove the values higher than color0 + cut-off

MUL temp, color0, cutoff;
ADD temp, color0, temp;
MIN color1, color1, temp;
MIN color2, color2, temp;
MIN color3, color3, temp;
MIN color4, color4, temp;

# blend colors

ADD color0, color0, color0;
ADD color0, color0, color0;
ADD color1, color1, color2;
ADD color3, color3, color4;
ADD color1, color1, color3;
ADD color0, color0, color1;

# calculate result

MUL result.color, color0, divEight;

END