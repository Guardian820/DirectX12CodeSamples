// 存储用于构成几何图形的三个基本列优先矩阵的常量缓冲区。
cbuffer ModelViewProjectionConstantBuffer : register(b0)
{
	matrix model;
	matrix view;
	matrix projection;
};

// 用作顶点着色器输入的每个顶点的数据。
struct PlaneVertexShaderInput
{
	float3 pos : POSITION;
	float3 color : COLOR0;
	float2 uv : TEXCOORD0;
};

// 通过像素着色器传递的每个像素的颜色数据。
struct  PlaneVertexShaderOutput
{
	float4 pos : SV_POSITION;
	float3 color : COLOR0;
	float2 uv : TEXCOORD0;
};

// 用于在 GPU 上执行顶点处理的简单着色器。
PlaneVertexShaderOutput main(PlaneVertexShaderInput input)
{
	PlaneVertexShaderOutput output;
	float4 pos = float4(input.pos, 1.0f);

	// 将顶点位置转换为投影空间。
	pos = mul(pos, model);
	pos = mul(pos, view);
	pos = mul(pos, projection);
	output.pos = pos;

	// 不加修改地传递颜色。
	output.color = input.color;

	// Store the texture coordinates for the pixel shader.
	output.uv = input.uv;

	return output;
}
