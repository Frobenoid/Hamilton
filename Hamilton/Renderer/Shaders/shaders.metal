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
    float4x4 modelMatrix;
};

vertex float4 vertex_main(const VertexIn vertexIn [[stage_in]],
                          constant Uniforms &uniforms [[buffer(1)]]
                          ) {
    float4 position = float4(vertexIn.position, 1);
    
    return uniforms.projectionMatrix * uniforms.viewMatrix * uniforms.modelMatrix * position;
}

fragment float4 fragment_main() {
    // rgb(230, 57, 70)
    //    return float4(0.89,0.222,0.273,1);
    return float4(0,0,0,1);
}
