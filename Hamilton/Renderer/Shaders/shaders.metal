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

struct VertexOut {
    float pointSize [[point_size]];
    float4 position [[position]];
};

struct Uniforms {
    float4x4 projectionMatrix;
    float4x4 viewMatrix;
    float4x4 modelMatrix;
    uint16_t renderMode;
};

vertex VertexOut vertex_main(const VertexIn vertexIn [[stage_in]],
                          constant Uniforms &uniforms [[buffer(1)]]
                          ) {
    float4 pos = float4(vertexIn.position, 1);
    
    VertexOut out {
        .position = uniforms.projectionMatrix * uniforms.viewMatrix * uniforms.modelMatrix * pos,
        .pointSize = 10
    };
    
    return out;
}

fragment float4 fragment_main(
                              const VertexOut vertexOut [[stage_in]],
                              constant Uniforms &uniforms [[buffer(1)]]
                              ) {
    float4 pos = normalize(vertexOut.position);
    
    if (uniforms.renderMode == 0 || uniforms.renderMode == 1) {
        return float4(0,0,0,1);
    } else {
        return float4(1,1,0,1) * pos;
    }
    
}
