//
//  shaders.metal
//  Hamilton
//
//  Created by Milton Montiel on 25/11/25.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[attribute(0)]];
};

struct Uniforms {
    float4x4 projectionMatrix;
    float4x4 viewMatrix;
};

vertex float4 vertex_main(const VertexIn vertexIn [[stage_in]],
                          constant Uniforms &uniforms [[buffer(1)]]) {
    float4 position = float4(vertexIn.position, 1);
    
    return uniforms.projectionMatrix * uniforms.viewMatrix * position;
}

fragment float4 fragment_main() {
    return float4(1,0,0,1);
}
