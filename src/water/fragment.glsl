uniform vec3 uDepthColor;
uniform vec3 uSurfaceColor;
uniform float uColorOffset;
uniform float uColorMultiplier;
uniform float uFogIntensity;

varying float vElevation;
varying vec2 vUv;

void main() {
    // Calculate distance from edges (0.0 and 1.0)
    float edgeDistance = min(
        min(vUv.x, 1.0 - vUv.x),
        min(vUv.y, 1.0 - vUv.y)
    );
    
    // Create fog effect only near the edges
    float fogFactor = smoothstep(0.0, 0.2, edgeDistance);
    float fogStrength = (1.0 - fogFactor) * uFogIntensity;
    
    // Mix colors based on elevation
    vec3 color = mix(uDepthColor, uSurfaceColor, vElevation * uColorMultiplier + uColorOffset);
    
    // Apply fog effect
    color = mix(color, vec3(1.0), fogStrength);
    
    // Fade out alpha at the edges
    float alpha = 1.0 - fogStrength;
    
    gl_FragColor = vec4(color, alpha);
}