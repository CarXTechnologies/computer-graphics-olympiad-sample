#ifndef SAMPLE_PASS_INCLUDED
#define SAMPLE_PASS_INCLUDED

#include "SampleData.hlsl"
#include "SampleInput.hlsl"

#define FALLBACK_COLOR half4(255.0 / 255.0, 0.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0)

TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);

CBUFFER_START(UnityPerMaterial)
	float4 _BaseColor;
CBUFFER_END

VertexOutput Vertex(VertexInput vertexInput)
{
	VertexOutput vertexOutput;
	vertexOutput.positionWS = TransformObjectToWorld(vertexInput.positionOS.xyz);
	vertexOutput.positionCS = TransformWorldToHClip(vertexOutput.positionWS.xyz);
	vertexOutput.uv = vertexInput.uv;

	return vertexOutput;
}

half4 Fragment(VertexOutput fragmentInput) : SV_Target
{
	float4 baseMapColor = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, fragmentInput.uv);
	return baseMapColor * _BaseColor;
}

#endif