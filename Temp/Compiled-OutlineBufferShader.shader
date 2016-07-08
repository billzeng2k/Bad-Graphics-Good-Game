// Compiled shader for PC, Mac & Linux Standalone, uncompressed size: 499.1KB

// Skipping shader variants that would not be included into build of current scene.

Shader "Hidden/OutlineBufferEffect" {
Properties {
[PerRendererData]  _MainTex ("Sprite Texture", 2D) = "white" { }
 _Color ("Tint", Color) = (1,1,1,1)
[MaterialToggle]  PixelSnap ("Pixel snap", Float) = 0
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="true" }


 // Stats for Vertex shader:
 //       metal : 50 avg math (32..69), 1 branch
 //      opengl : 10 avg math (10..11), 2 avg texture (2..3), 1 branch
 // Stats for Fragment shader:
 //       metal : 10 avg math (10..11), 2 avg texture (2..3), 1 branch
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "SHADOWSUPPORT"="true" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="true" }
  ZWrite Off
  Cull Off
  Blend One OneMinusSrcAlpha
  GpuProgramID 10937
Program "vp" {
SubProgram "opengl " {
// Stats: 10 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 120

#ifdef VERTEX
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec4 v_5;
  v_5.x = _World2Object[0].x;
  v_5.y = _World2Object[1].x;
  v_5.z = _World2Object[2].x;
  v_5.w = _World2Object[3].x;
  vec4 v_6;
  v_6.x = _World2Object[0].y;
  v_6.y = _World2Object[1].y;
  v_6.z = _World2Object[2].y;
  v_6.w = _World2Object[3].y;
  vec4 v_7;
  v_7.x = _World2Object[0].z;
  v_7.y = _World2Object[1].z;
  v_7.z = _World2Object[2].z;
  v_7.w = _World2Object[3].z;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(((
    (v_5.xyz * gl_Normal.x)
   + 
    (v_6.xyz * gl_Normal.y)
  ) + (v_7.xyz * gl_Normal.z)));
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_9;
  ambient_9 = tmpvar_3;
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_8;
  vec3 res_11;
  vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_10);
  x_12.y = dot (unity_SHAg, tmpvar_10);
  x_12.z = dot (unity_SHAb, tmpvar_10);
  vec3 x1_13;
  vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_8.xyzz * tmpvar_8.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((tmpvar_8.x * tmpvar_8.x) - (tmpvar_8.y * tmpvar_8.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_11 = max (((1.055 * 
      pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_9 = max (vec3(0.0, 0.0, 0.0), res_11);
  tmpvar_3 = ambient_9;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = gl_Color;
  xlv_TEXCOORD4 = ambient_9;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color * tmpvar_2).xyz;
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = ((tmpvar_3 * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2;
  c_4.w = c_5.w;
  c_4.xyz = (c_5.xyz + (tmpvar_3 * xlv_TEXCOORD4));
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "metal " {
// Stats: 32 math, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 288
Matrix 64 [glstate_matrix_mvp]
Matrix 128 [_Object2World]
Matrix 192 [_World2Object]
VectorHalf 0 [unity_SHAr] 4
VectorHalf 8 [unity_SHAg] 4
VectorHalf 16 [unity_SHAb] 4
VectorHalf 24 [unity_SHBr] 4
VectorHalf 32 [unity_SHBg] 4
VectorHalf 40 [unity_SHBb] 4
VectorHalf 48 [unity_SHC] 4
VectorHalf 256 [unity_ColorSpaceLuminance] 4
Vector 272 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD4;
};
struct xlatMtlShaderUniform {
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  float4 tmpvar_3;
  float2 tmpvar_4;
  half3 tmpvar_5;
  half4 tmpvar_6;
  half3 tmpvar_7;
  tmpvar_6 = tmpvar_1;
  tmpvar_3 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  tmpvar_4 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_8;
  tmpvar_8 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float4 v_9;
  v_9.x = _mtl_u._World2Object[0].x;
  v_9.y = _mtl_u._World2Object[1].x;
  v_9.z = _mtl_u._World2Object[2].x;
  v_9.w = _mtl_u._World2Object[3].x;
  float4 v_10;
  v_10.x = _mtl_u._World2Object[0].y;
  v_10.y = _mtl_u._World2Object[1].y;
  v_10.z = _mtl_u._World2Object[2].y;
  v_10.w = _mtl_u._World2Object[3].y;
  float4 v_11;
  v_11.x = _mtl_u._World2Object[0].z;
  v_11.y = _mtl_u._World2Object[1].z;
  v_11.z = _mtl_u._World2Object[2].z;
  v_11.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_12;
  tmpvar_12 = normalize(((
    (v_9.xyz * _mtl_i._glesNormal.x)
   + 
    (v_10.xyz * _mtl_i._glesNormal.y)
  ) + (v_11.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_12);
  tmpvar_5 = worldNormal_2;
  tmpvar_7 = half3(float3(0.0, 0.0, 0.0));
  half3 normal_13;
  normal_13 = worldNormal_2;
  half3 ambient_14;
  ambient_14 = tmpvar_7;
  half4 tmpvar_15;
  tmpvar_15.w = half(1.0);
  tmpvar_15.xyz = normal_13;
  half3 res_16;
  half3 x_17;
  x_17.x = dot (_mtl_u.unity_SHAr, tmpvar_15);
  x_17.y = dot (_mtl_u.unity_SHAg, tmpvar_15);
  x_17.z = dot (_mtl_u.unity_SHAb, tmpvar_15);
  half3 x1_18;
  half4 tmpvar_19;
  tmpvar_19 = (normal_13.xyzz * normal_13.yzzx);
  x1_18.x = dot (_mtl_u.unity_SHBr, tmpvar_19);
  x1_18.y = dot (_mtl_u.unity_SHBg, tmpvar_19);
  x1_18.z = dot (_mtl_u.unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (_mtl_u.unity_SHC.xyz * 
    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
  )));
  bool tmpvar_20;
  tmpvar_20 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_20) {
    res_16 = max ((((half)1.055 * 
      pow (max (res_16, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  ambient_14 = max ((half3)float3(0.0, 0.0, 0.0), res_16);
  tmpvar_7 = ambient_14;
  _mtl_o.gl_Position = tmpvar_3;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_8;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = ambient_14;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
vec4 t0;
vec3 t1;
vec4 t2;
vec3 t3;
float t12;
bool tb12;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    vs_TEXCOORD1.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    t1.x = t0.y * t0.y;
    t1.x = t0.x * t0.x + (-t1.x);
    t2 = t0.yzzx * t0.xyzz;
    t3.x = dot(unity_SHBr, t2);
    t3.y = dot(unity_SHBg, t2);
    t3.z = dot(unity_SHBb, t2);
    t1.xyz = unity_SHC.xyz * t1.xxx + t3.xyz;
    t0.w = 1.0;
    t2.x = dot(unity_SHAr, t0);
    t2.y = dot(unity_SHAg, t0);
    t2.z = dot(unity_SHAb, t0);
    t0.xyz = t1.xyz + t2.xyz;
    t1.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    t1.xyz = log2(t1.xyz);
    t1.xyz = t1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t1.xyz = exp2(t1.xyz);
    t1.xyz = t1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t1.xyz = max(t1.xyz, vec3(0.0, 0.0, 0.0));
    tb12 = unity_ColorSpaceLuminance.w==0.0;
    t0.xyz = (bool(tb12)) ? t1.xyz : t0.xyz;
    vs_TEXCOORD4.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
float t1;
vec3 t2;
bool tb2;
vec3 t3;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t1 = max(t1, 0.0);
    t3.xyz = t2.xyz * _LightColor0.xyz;
    t2.xyz = t2.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.xyz = t3.xyz * vec3(t1) + t2.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 11 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 120

#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec4 v_5;
  v_5.x = _World2Object[0].x;
  v_5.y = _World2Object[1].x;
  v_5.z = _World2Object[2].x;
  v_5.w = _World2Object[3].x;
  vec4 v_6;
  v_6.x = _World2Object[0].y;
  v_6.y = _World2Object[1].y;
  v_6.z = _World2Object[2].y;
  v_6.w = _World2Object[3].y;
  vec4 v_7;
  v_7.x = _World2Object[0].z;
  v_7.y = _World2Object[1].z;
  v_7.z = _World2Object[2].z;
  v_7.w = _World2Object[3].z;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(((
    (v_5.xyz * gl_Normal.x)
   + 
    (v_6.xyz * gl_Normal.y)
  ) + (v_7.xyz * gl_Normal.z)));
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_9;
  ambient_9 = tmpvar_3;
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_8;
  vec3 res_11;
  vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_10);
  x_12.y = dot (unity_SHAg, tmpvar_10);
  x_12.z = dot (unity_SHAb, tmpvar_10);
  vec3 x1_13;
  vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_8.xyzz * tmpvar_8.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((tmpvar_8.x * tmpvar_8.x) - (tmpvar_8.y * tmpvar_8.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_11 = max (((1.055 * 
      pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_9 = max (vec3(0.0, 0.0, 0.0), res_11);
  tmpvar_3 = ambient_9;
  vec4 o_15;
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_1 * 0.5);
  vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = gl_Color;
  xlv_TEXCOORD4 = ambient_9;
  xlv_TEXCOORD5 = o_15;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color * tmpvar_2).xyz;
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = ((tmpvar_3 * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2;
  c_4.w = c_5.w;
  c_4.xyz = (c_5.xyz + (tmpvar_3 * xlv_TEXCOORD4));
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "metal " {
// Stats: 35 math, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 304
Matrix 80 [glstate_matrix_mvp]
Matrix 144 [_Object2World]
Matrix 208 [_World2Object]
Vector 0 [_ProjectionParams]
VectorHalf 16 [unity_SHAr] 4
VectorHalf 24 [unity_SHAg] 4
VectorHalf 32 [unity_SHAb] 4
VectorHalf 40 [unity_SHBr] 4
VectorHalf 48 [unity_SHBg] 4
VectorHalf 56 [unity_SHBb] 4
VectorHalf 64 [unity_SHC] 4
VectorHalf 272 [unity_ColorSpaceLuminance] 4
Vector 288 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD4;
  half4 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float4 _ProjectionParams;
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  float4 tmpvar_3;
  float2 tmpvar_4;
  half3 tmpvar_5;
  half4 tmpvar_6;
  half3 tmpvar_7;
  half4 tmpvar_8;
  tmpvar_6 = tmpvar_1;
  tmpvar_3 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  tmpvar_4 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_9;
  tmpvar_9 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float4 v_10;
  v_10.x = _mtl_u._World2Object[0].x;
  v_10.y = _mtl_u._World2Object[1].x;
  v_10.z = _mtl_u._World2Object[2].x;
  v_10.w = _mtl_u._World2Object[3].x;
  float4 v_11;
  v_11.x = _mtl_u._World2Object[0].y;
  v_11.y = _mtl_u._World2Object[1].y;
  v_11.z = _mtl_u._World2Object[2].y;
  v_11.w = _mtl_u._World2Object[3].y;
  float4 v_12;
  v_12.x = _mtl_u._World2Object[0].z;
  v_12.y = _mtl_u._World2Object[1].z;
  v_12.z = _mtl_u._World2Object[2].z;
  v_12.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * _mtl_i._glesNormal.x)
   + 
    (v_11.xyz * _mtl_i._glesNormal.y)
  ) + (v_12.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_13);
  tmpvar_5 = worldNormal_2;
  tmpvar_7 = half3(float3(0.0, 0.0, 0.0));
  half3 normal_14;
  normal_14 = worldNormal_2;
  half3 ambient_15;
  ambient_15 = tmpvar_7;
  half4 tmpvar_16;
  tmpvar_16.w = half(1.0);
  tmpvar_16.xyz = normal_14;
  half3 res_17;
  half3 x_18;
  x_18.x = dot (_mtl_u.unity_SHAr, tmpvar_16);
  x_18.y = dot (_mtl_u.unity_SHAg, tmpvar_16);
  x_18.z = dot (_mtl_u.unity_SHAb, tmpvar_16);
  half3 x1_19;
  half4 tmpvar_20;
  tmpvar_20 = (normal_14.xyzz * normal_14.yzzx);
  x1_19.x = dot (_mtl_u.unity_SHBr, tmpvar_20);
  x1_19.y = dot (_mtl_u.unity_SHBg, tmpvar_20);
  x1_19.z = dot (_mtl_u.unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (_mtl_u.unity_SHC.xyz * 
    ((normal_14.x * normal_14.x) - (normal_14.y * normal_14.y))
  )));
  bool tmpvar_21;
  tmpvar_21 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_21) {
    res_17 = max ((((half)1.055 * 
      pow (max (res_17, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  ambient_15 = max ((half3)float3(0.0, 0.0, 0.0), res_17);
  tmpvar_7 = ambient_15;
  float4 o_22;
  float4 tmpvar_23;
  tmpvar_23 = (tmpvar_3 * 0.5);
  float2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _mtl_u._ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_3.zw;
  tmpvar_8 = half4(o_22);
  _mtl_o.gl_Position = tmpvar_3;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_9;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = ambient_15;
  _mtl_o.xlv_TEXCOORD5 = tmpvar_8;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out vec4 vs_TEXCOORD5;
vec4 t0;
vec4 t1;
vec3 t2;
vec4 t3;
vec3 t4;
float t16;
bool tb16;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t1.x = in_NORMAL0.x * _World2Object[0].x;
    t1.y = in_NORMAL0.x * _World2Object[1].x;
    t1.z = in_NORMAL0.x * _World2Object[2].x;
    t2.x = in_NORMAL0.y * _World2Object[0].y;
    t2.y = in_NORMAL0.y * _World2Object[1].y;
    t2.z = in_NORMAL0.y * _World2Object[2].y;
    t1.xyz = t1.xyz + t2.xyz;
    t2.x = in_NORMAL0.z * _World2Object[0].z;
    t2.y = in_NORMAL0.z * _World2Object[1].z;
    t2.z = in_NORMAL0.z * _World2Object[2].z;
    t1.xyz = t1.xyz + t2.xyz;
    t16 = dot(t1.xyz, t1.xyz);
    t16 = inversesqrt(t16);
    t1.xyz = vec3(t16) * t1.xyz;
    vs_TEXCOORD1.xyz = t1.xyz;
    t2.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t2.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t2.xyz;
    t2.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t2.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t2.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    t2.x = t1.y * t1.y;
    t2.x = t1.x * t1.x + (-t2.x);
    t3 = t1.yzzx * t1.xyzz;
    t4.x = dot(unity_SHBr, t3);
    t4.y = dot(unity_SHBg, t3);
    t4.z = dot(unity_SHBb, t3);
    t2.xyz = unity_SHC.xyz * t2.xxx + t4.xyz;
    t1.w = 1.0;
    t3.x = dot(unity_SHAr, t1);
    t3.y = dot(unity_SHAg, t1);
    t3.z = dot(unity_SHAb, t1);
    t1.xyz = t2.xyz + t3.xyz;
    t2.xyz = max(t1.xyz, vec3(0.0, 0.0, 0.0));
    t2.xyz = log2(t2.xyz);
    t2.xyz = t2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t2.xyz = exp2(t2.xyz);
    t2.xyz = t2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t2.xyz = max(t2.xyz, vec3(0.0, 0.0, 0.0));
    tb16 = unity_ColorSpaceLuminance.w==0.0;
    t1.xyz = (bool(tb16)) ? t2.xyz : t1.xyz;
    vs_TEXCOORD4.xyz = max(t1.xyz, vec3(0.0, 0.0, 0.0));
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = t0.zw;
    vs_TEXCOORD5.xy = t1.zz + t1.xw;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
uniform  sampler2D _ShadowMapTexture;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
in  vec4 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
lowp vec4 t10_1;
vec3 t2;
bool tb2;
float t7;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    t10_1 = texture(_ShadowMapTexture, t1.xy);
    t1.xyz = t10_1.xxx * _LightColor0.xyz;
    t7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t7 = max(t7, 0.0);
    t1.xyz = t2.xyz * t1.xyz;
    t2.xyz = t2.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.xyz = t1.xyz * vec3(t7) + t2.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 10 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_5.xyz * gl_Normal.y)
  ) + (v_6.xyz * gl_Normal.z)));
  vec3 col_8;
  vec4 ndotl_9;
  vec4 lengthSq_10;
  vec4 tmpvar_11;
  tmpvar_11 = (unity_4LightPosX0 - tmpvar_3.x);
  vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosY0 - tmpvar_3.y);
  vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosZ0 - tmpvar_3.z);
  lengthSq_10 = (tmpvar_11 * tmpvar_11);
  lengthSq_10 = (lengthSq_10 + (tmpvar_12 * tmpvar_12));
  lengthSq_10 = (lengthSq_10 + (tmpvar_13 * tmpvar_13));
  ndotl_9 = (tmpvar_11 * tmpvar_7.x);
  ndotl_9 = (ndotl_9 + (tmpvar_12 * tmpvar_7.y));
  ndotl_9 = (ndotl_9 + (tmpvar_13 * tmpvar_7.z));
  vec4 tmpvar_14;
  tmpvar_14 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_9 * inversesqrt(lengthSq_10)));
  ndotl_9 = tmpvar_14;
  vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (1.0/((1.0 + 
    (lengthSq_10 * unity_4LightAtten0)
  ))));
  col_8 = (unity_LightColor[0].xyz * tmpvar_15.x);
  col_8 = (col_8 + (unity_LightColor[1].xyz * tmpvar_15.y));
  col_8 = (col_8 + (unity_LightColor[2].xyz * tmpvar_15.z));
  col_8 = (col_8 + (unity_LightColor[3].xyz * tmpvar_15.w));
  vec3 ambient_16;
  ambient_16 = col_8;
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_7;
  vec3 res_18;
  vec3 x_19;
  x_19.x = dot (unity_SHAr, tmpvar_17);
  x_19.y = dot (unity_SHAg, tmpvar_17);
  x_19.z = dot (unity_SHAb, tmpvar_17);
  vec3 x1_20;
  vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_18 = max (((1.055 * 
      pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_16 = (col_8 + max (vec3(0.0, 0.0, 0.0), res_18));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = gl_Color;
  xlv_TEXCOORD4 = ambient_16;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color * tmpvar_2).xyz;
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = ((tmpvar_3 * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2;
  c_4.w = c_5.w;
  c_4.xyz = (c_5.xyz + (tmpvar_3 * xlv_TEXCOORD4));
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "metal " {
// Stats: 59 math, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 400
Matrix 176 [glstate_matrix_mvp]
Matrix 240 [_Object2World]
Matrix 304 [_World2Object]
Vector 0 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 32 [unity_4LightPosZ0]
VectorHalf 48 [unity_4LightAtten0] 4
VectorHalf 56 [unity_LightColor0] 4
VectorHalf 64 [unity_LightColor1] 4
VectorHalf 72 [unity_LightColor2] 4
VectorHalf 80 [unity_LightColor3] 4
VectorHalf 88 [unity_LightColor4] 4
VectorHalf 96 [unity_LightColor5] 4
VectorHalf 104 [unity_LightColor6] 4
VectorHalf 112 [unity_LightColor7] 4
VectorHalf 120 [unity_SHAr] 4
VectorHalf 128 [unity_SHAg] 4
VectorHalf 136 [unity_SHAb] 4
VectorHalf 144 [unity_SHBr] 4
VectorHalf 152 [unity_SHBg] 4
VectorHalf 160 [unity_SHBb] 4
VectorHalf 168 [unity_SHC] 4
VectorHalf 368 [unity_ColorSpaceLuminance] 4
Vector 384 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD4;
};
struct xlatMtlShaderUniform {
  float4 unity_4LightPosX0;
  float4 unity_4LightPosY0;
  float4 unity_4LightPosZ0;
  half4 unity_4LightAtten0;
  half4 unity_LightColor[8];
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  float4 tmpvar_3;
  float2 tmpvar_4;
  half3 tmpvar_5;
  half4 tmpvar_6;
  half3 tmpvar_7;
  tmpvar_6 = tmpvar_1;
  tmpvar_3 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  tmpvar_4 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_8;
  tmpvar_8 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float4 v_9;
  v_9.x = _mtl_u._World2Object[0].x;
  v_9.y = _mtl_u._World2Object[1].x;
  v_9.z = _mtl_u._World2Object[2].x;
  v_9.w = _mtl_u._World2Object[3].x;
  float4 v_10;
  v_10.x = _mtl_u._World2Object[0].y;
  v_10.y = _mtl_u._World2Object[1].y;
  v_10.z = _mtl_u._World2Object[2].y;
  v_10.w = _mtl_u._World2Object[3].y;
  float4 v_11;
  v_11.x = _mtl_u._World2Object[0].z;
  v_11.y = _mtl_u._World2Object[1].z;
  v_11.z = _mtl_u._World2Object[2].z;
  v_11.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_12;
  tmpvar_12 = normalize(((
    (v_9.xyz * _mtl_i._glesNormal.x)
   + 
    (v_10.xyz * _mtl_i._glesNormal.y)
  ) + (v_11.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_12);
  tmpvar_5 = worldNormal_2;
  float3 lightColor0_13;
  lightColor0_13 = float3(_mtl_u.unity_LightColor[0].xyz);
  float3 lightColor1_14;
  lightColor1_14 = float3(_mtl_u.unity_LightColor[1].xyz);
  float3 lightColor2_15;
  lightColor2_15 = float3(_mtl_u.unity_LightColor[2].xyz);
  float3 lightColor3_16;
  lightColor3_16 = float3(_mtl_u.unity_LightColor[3].xyz);
  float4 lightAttenSq_17;
  lightAttenSq_17 = float4(_mtl_u.unity_4LightAtten0);
  float3 normal_18;
  normal_18 = float3(worldNormal_2);
  float3 col_19;
  float4 ndotl_20;
  float4 lengthSq_21;
  float4 tmpvar_22;
  tmpvar_22 = (_mtl_u.unity_4LightPosX0 - tmpvar_8.x);
  float4 tmpvar_23;
  tmpvar_23 = (_mtl_u.unity_4LightPosY0 - tmpvar_8.y);
  float4 tmpvar_24;
  tmpvar_24 = (_mtl_u.unity_4LightPosZ0 - tmpvar_8.z);
  lengthSq_21 = (tmpvar_22 * tmpvar_22);
  lengthSq_21 = (lengthSq_21 + (tmpvar_23 * tmpvar_23));
  lengthSq_21 = (lengthSq_21 + (tmpvar_24 * tmpvar_24));
  ndotl_20 = (tmpvar_22 * normal_18.x);
  ndotl_20 = (ndotl_20 + (tmpvar_23 * normal_18.y));
  ndotl_20 = (ndotl_20 + (tmpvar_24 * normal_18.z));
  float4 tmpvar_25;
  tmpvar_25 = max (float4(0.0, 0.0, 0.0, 0.0), (ndotl_20 * rsqrt(lengthSq_21)));
  ndotl_20 = tmpvar_25;
  float4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (1.0/((1.0 + 
    (lengthSq_21 * lightAttenSq_17)
  ))));
  col_19 = (lightColor0_13 * tmpvar_26.x);
  col_19 = (col_19 + (lightColor1_14 * tmpvar_26.y));
  col_19 = (col_19 + (lightColor2_15 * tmpvar_26.z));
  col_19 = (col_19 + (lightColor3_16 * tmpvar_26.w));
  tmpvar_7 = half3(col_19);
  half3 normal_27;
  normal_27 = worldNormal_2;
  half3 ambient_28;
  ambient_28 = tmpvar_7;
  half4 tmpvar_29;
  tmpvar_29.w = half(1.0);
  tmpvar_29.xyz = normal_27;
  half3 res_30;
  half3 x_31;
  x_31.x = dot (_mtl_u.unity_SHAr, tmpvar_29);
  x_31.y = dot (_mtl_u.unity_SHAg, tmpvar_29);
  x_31.z = dot (_mtl_u.unity_SHAb, tmpvar_29);
  half3 x1_32;
  half4 tmpvar_33;
  tmpvar_33 = (normal_27.xyzz * normal_27.yzzx);
  x1_32.x = dot (_mtl_u.unity_SHBr, tmpvar_33);
  x1_32.y = dot (_mtl_u.unity_SHBg, tmpvar_33);
  x1_32.z = dot (_mtl_u.unity_SHBb, tmpvar_33);
  res_30 = (x_31 + (x1_32 + (_mtl_u.unity_SHC.xyz * 
    ((normal_27.x * normal_27.x) - (normal_27.y * normal_27.y))
  )));
  bool tmpvar_34;
  tmpvar_34 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_34) {
    res_30 = max ((((half)1.055 * 
      pow (max (res_30, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  ambient_28 = (tmpvar_7 + max ((half3)float3(0.0, 0.0, 0.0), res_30));
  tmpvar_7 = ambient_28;
  _mtl_o.gl_Position = tmpvar_3;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_8;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = ambient_28;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
vec4 t0;
vec4 t1;
vec4 t2;
vec4 t3;
vec4 t4;
vec4 t5;
float t18;
bool tb18;
float t19;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t18 = dot(t0.xyz, t0.xyz);
    t18 = inversesqrt(t18);
    t0.xyz = vec3(t18) * t0.xyz;
    vs_TEXCOORD1.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    t1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD2.xyz = t1.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    t19 = t0.y * t0.y;
    t19 = t0.x * t0.x + (-t19);
    t2 = t0.yzzx * t0.xyzz;
    t3.x = dot(unity_SHBr, t2);
    t3.y = dot(unity_SHBg, t2);
    t3.z = dot(unity_SHBb, t2);
    t2.xyz = unity_SHC.xyz * vec3(t19) + t3.xyz;
    t0.w = 1.0;
    t3.x = dot(unity_SHAr, t0);
    t3.y = dot(unity_SHAg, t0);
    t3.z = dot(unity_SHAb, t0);
    t2.xyz = t2.xyz + t3.xyz;
    t3.xyz = max(t2.xyz, vec3(0.0, 0.0, 0.0));
    t3.xyz = log2(t3.xyz);
    t3.xyz = t3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t3.xyz = exp2(t3.xyz);
    t3.xyz = t3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t3.xyz = max(t3.xyz, vec3(0.0, 0.0, 0.0));
    tb18 = unity_ColorSpaceLuminance.w==0.0;
    t2.xyz = (bool(tb18)) ? t3.xyz : t2.xyz;
    t2.xyz = max(t2.xyz, vec3(0.0, 0.0, 0.0));
    t3 = (-t1.yyyy) + unity_4LightPosY0;
    t4 = t0.yyyy * t3;
    t3 = t3 * t3;
    t5 = (-t1.xxxx) + unity_4LightPosX0;
    t1 = (-t1.zzzz) + unity_4LightPosZ0;
    t4 = t5 * t0.xxxx + t4;
    t0 = t1 * t0.zzzz + t4;
    t3 = t5 * t5 + t3;
    t1 = t1 * t1 + t3;
    t3 = inversesqrt(t1);
    t1 = t1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    t1 = vec4(1.0, 1.0, 1.0, 1.0) / t1;
    t0 = t0 * t3;
    t0 = max(t0, vec4(0.0, 0.0, 0.0, 0.0));
    t0 = t1 * t0;
    t1.xyz = t0.yyy * unity_LightColor[1].xyz;
    t1.xyz = unity_LightColor[0].xyz * t0.xxx + t1.xyz;
    t0.xyz = unity_LightColor[2].xyz * t0.zzz + t1.xyz;
    t0.xyz = unity_LightColor[3].xyz * t0.www + t0.xyz;
    vs_TEXCOORD4.xyz = t2.xyz + t0.xyz;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
float t1;
vec3 t2;
bool tb2;
vec3 t3;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t1 = max(t1, 0.0);
    t3.xyz = t2.xyz * _LightColor0.xyz;
    t2.xyz = t2.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.xyz = t3.xyz * vec3(t1) + t2.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 11 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_5.xyz * gl_Normal.y)
  ) + (v_6.xyz * gl_Normal.z)));
  vec3 col_8;
  vec4 ndotl_9;
  vec4 lengthSq_10;
  vec4 tmpvar_11;
  tmpvar_11 = (unity_4LightPosX0 - tmpvar_3.x);
  vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosY0 - tmpvar_3.y);
  vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosZ0 - tmpvar_3.z);
  lengthSq_10 = (tmpvar_11 * tmpvar_11);
  lengthSq_10 = (lengthSq_10 + (tmpvar_12 * tmpvar_12));
  lengthSq_10 = (lengthSq_10 + (tmpvar_13 * tmpvar_13));
  ndotl_9 = (tmpvar_11 * tmpvar_7.x);
  ndotl_9 = (ndotl_9 + (tmpvar_12 * tmpvar_7.y));
  ndotl_9 = (ndotl_9 + (tmpvar_13 * tmpvar_7.z));
  vec4 tmpvar_14;
  tmpvar_14 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_9 * inversesqrt(lengthSq_10)));
  ndotl_9 = tmpvar_14;
  vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (1.0/((1.0 + 
    (lengthSq_10 * unity_4LightAtten0)
  ))));
  col_8 = (unity_LightColor[0].xyz * tmpvar_15.x);
  col_8 = (col_8 + (unity_LightColor[1].xyz * tmpvar_15.y));
  col_8 = (col_8 + (unity_LightColor[2].xyz * tmpvar_15.z));
  col_8 = (col_8 + (unity_LightColor[3].xyz * tmpvar_15.w));
  vec3 ambient_16;
  ambient_16 = col_8;
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_7;
  vec3 res_18;
  vec3 x_19;
  x_19.x = dot (unity_SHAr, tmpvar_17);
  x_19.y = dot (unity_SHAg, tmpvar_17);
  x_19.z = dot (unity_SHAb, tmpvar_17);
  vec3 x1_20;
  vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_18 = max (((1.055 * 
      pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_16 = (col_8 + max (vec3(0.0, 0.0, 0.0), res_18));
  vec4 o_22;
  vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_1 * 0.5);
  vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = gl_Color;
  xlv_TEXCOORD4 = ambient_16;
  xlv_TEXCOORD5 = o_22;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color * tmpvar_2).xyz;
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = ((tmpvar_3 * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2;
  c_4.w = c_5.w;
  c_4.xyz = (c_5.xyz + (tmpvar_3 * xlv_TEXCOORD4));
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "metal " {
// Stats: 62 math, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 416
Matrix 192 [glstate_matrix_mvp]
Matrix 256 [_Object2World]
Matrix 320 [_World2Object]
Vector 0 [_ProjectionParams]
Vector 16 [unity_4LightPosX0]
Vector 32 [unity_4LightPosY0]
Vector 48 [unity_4LightPosZ0]
VectorHalf 64 [unity_4LightAtten0] 4
VectorHalf 72 [unity_LightColor0] 4
VectorHalf 80 [unity_LightColor1] 4
VectorHalf 88 [unity_LightColor2] 4
VectorHalf 96 [unity_LightColor3] 4
VectorHalf 104 [unity_LightColor4] 4
VectorHalf 112 [unity_LightColor5] 4
VectorHalf 120 [unity_LightColor6] 4
VectorHalf 128 [unity_LightColor7] 4
VectorHalf 136 [unity_SHAr] 4
VectorHalf 144 [unity_SHAg] 4
VectorHalf 152 [unity_SHAb] 4
VectorHalf 160 [unity_SHBr] 4
VectorHalf 168 [unity_SHBg] 4
VectorHalf 176 [unity_SHBb] 4
VectorHalf 184 [unity_SHC] 4
VectorHalf 384 [unity_ColorSpaceLuminance] 4
Vector 400 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD4;
  half4 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float4 _ProjectionParams;
  float4 unity_4LightPosX0;
  float4 unity_4LightPosY0;
  float4 unity_4LightPosZ0;
  half4 unity_4LightAtten0;
  half4 unity_LightColor[8];
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  float4 tmpvar_3;
  float2 tmpvar_4;
  half3 tmpvar_5;
  half4 tmpvar_6;
  half3 tmpvar_7;
  half4 tmpvar_8;
  tmpvar_6 = tmpvar_1;
  tmpvar_3 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  tmpvar_4 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_9;
  tmpvar_9 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float4 v_10;
  v_10.x = _mtl_u._World2Object[0].x;
  v_10.y = _mtl_u._World2Object[1].x;
  v_10.z = _mtl_u._World2Object[2].x;
  v_10.w = _mtl_u._World2Object[3].x;
  float4 v_11;
  v_11.x = _mtl_u._World2Object[0].y;
  v_11.y = _mtl_u._World2Object[1].y;
  v_11.z = _mtl_u._World2Object[2].y;
  v_11.w = _mtl_u._World2Object[3].y;
  float4 v_12;
  v_12.x = _mtl_u._World2Object[0].z;
  v_12.y = _mtl_u._World2Object[1].z;
  v_12.z = _mtl_u._World2Object[2].z;
  v_12.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * _mtl_i._glesNormal.x)
   + 
    (v_11.xyz * _mtl_i._glesNormal.y)
  ) + (v_12.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_13);
  tmpvar_5 = worldNormal_2;
  float3 lightColor0_14;
  lightColor0_14 = float3(_mtl_u.unity_LightColor[0].xyz);
  float3 lightColor1_15;
  lightColor1_15 = float3(_mtl_u.unity_LightColor[1].xyz);
  float3 lightColor2_16;
  lightColor2_16 = float3(_mtl_u.unity_LightColor[2].xyz);
  float3 lightColor3_17;
  lightColor3_17 = float3(_mtl_u.unity_LightColor[3].xyz);
  float4 lightAttenSq_18;
  lightAttenSq_18 = float4(_mtl_u.unity_4LightAtten0);
  float3 normal_19;
  normal_19 = float3(worldNormal_2);
  float3 col_20;
  float4 ndotl_21;
  float4 lengthSq_22;
  float4 tmpvar_23;
  tmpvar_23 = (_mtl_u.unity_4LightPosX0 - tmpvar_9.x);
  float4 tmpvar_24;
  tmpvar_24 = (_mtl_u.unity_4LightPosY0 - tmpvar_9.y);
  float4 tmpvar_25;
  tmpvar_25 = (_mtl_u.unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  float4 tmpvar_26;
  tmpvar_26 = max (float4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * rsqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  float4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_27.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_27.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_27.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_7 = half3(col_20);
  half3 normal_28;
  normal_28 = worldNormal_2;
  half3 ambient_29;
  ambient_29 = tmpvar_7;
  half4 tmpvar_30;
  tmpvar_30.w = half(1.0);
  tmpvar_30.xyz = normal_28;
  half3 res_31;
  half3 x_32;
  x_32.x = dot (_mtl_u.unity_SHAr, tmpvar_30);
  x_32.y = dot (_mtl_u.unity_SHAg, tmpvar_30);
  x_32.z = dot (_mtl_u.unity_SHAb, tmpvar_30);
  half3 x1_33;
  half4 tmpvar_34;
  tmpvar_34 = (normal_28.xyzz * normal_28.yzzx);
  x1_33.x = dot (_mtl_u.unity_SHBr, tmpvar_34);
  x1_33.y = dot (_mtl_u.unity_SHBg, tmpvar_34);
  x1_33.z = dot (_mtl_u.unity_SHBb, tmpvar_34);
  res_31 = (x_32 + (x1_33 + (_mtl_u.unity_SHC.xyz * 
    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
  )));
  bool tmpvar_35;
  tmpvar_35 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_35) {
    res_31 = max ((((half)1.055 * 
      pow (max (res_31, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  ambient_29 = (tmpvar_7 + max ((half3)float3(0.0, 0.0, 0.0), res_31));
  tmpvar_7 = ambient_29;
  float4 o_36;
  float4 tmpvar_37;
  tmpvar_37 = (tmpvar_3 * 0.5);
  float2 tmpvar_38;
  tmpvar_38.x = tmpvar_37.x;
  tmpvar_38.y = (tmpvar_37.y * _mtl_u._ProjectionParams.x);
  o_36.xy = (tmpvar_38 + tmpvar_37.w);
  o_36.zw = tmpvar_3.zw;
  tmpvar_8 = half4(o_36);
  _mtl_o.gl_Position = tmpvar_3;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_9;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = ambient_29;
  _mtl_o.xlv_TEXCOORD5 = tmpvar_8;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out vec4 vs_TEXCOORD5;
vec4 t0;
vec4 t1;
vec4 t2;
vec4 t3;
vec4 t4;
vec4 t5;
vec4 t6;
float t22;
bool tb22;
float t23;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t1.x = in_NORMAL0.x * _World2Object[0].x;
    t1.y = in_NORMAL0.x * _World2Object[1].x;
    t1.z = in_NORMAL0.x * _World2Object[2].x;
    t2.x = in_NORMAL0.y * _World2Object[0].y;
    t2.y = in_NORMAL0.y * _World2Object[1].y;
    t2.z = in_NORMAL0.y * _World2Object[2].y;
    t1.xyz = t1.xyz + t2.xyz;
    t2.x = in_NORMAL0.z * _World2Object[0].z;
    t2.y = in_NORMAL0.z * _World2Object[1].z;
    t2.z = in_NORMAL0.z * _World2Object[2].z;
    t1.xyz = t1.xyz + t2.xyz;
    t22 = dot(t1.xyz, t1.xyz);
    t22 = inversesqrt(t22);
    t1.xyz = vec3(t22) * t1.xyz;
    vs_TEXCOORD1.xyz = t1.xyz;
    t2.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t2.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t2.xyz;
    t2.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t2.xyz;
    t2.xyz = _Object2World[3].xyz * in_POSITION0.www + t2.xyz;
    vs_TEXCOORD2.xyz = t2.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    t23 = t1.y * t1.y;
    t23 = t1.x * t1.x + (-t23);
    t3 = t1.yzzx * t1.xyzz;
    t4.x = dot(unity_SHBr, t3);
    t4.y = dot(unity_SHBg, t3);
    t4.z = dot(unity_SHBb, t3);
    t3.xyz = unity_SHC.xyz * vec3(t23) + t4.xyz;
    t1.w = 1.0;
    t4.x = dot(unity_SHAr, t1);
    t4.y = dot(unity_SHAg, t1);
    t4.z = dot(unity_SHAb, t1);
    t3.xyz = t3.xyz + t4.xyz;
    t4.xyz = max(t3.xyz, vec3(0.0, 0.0, 0.0));
    t4.xyz = log2(t4.xyz);
    t4.xyz = t4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t4.xyz = exp2(t4.xyz);
    t4.xyz = t4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t4.xyz = max(t4.xyz, vec3(0.0, 0.0, 0.0));
    tb22 = unity_ColorSpaceLuminance.w==0.0;
    t3.xyz = (bool(tb22)) ? t4.xyz : t3.xyz;
    t3.xyz = max(t3.xyz, vec3(0.0, 0.0, 0.0));
    t4 = (-t2.yyyy) + unity_4LightPosY0;
    t5 = t1.yyyy * t4;
    t4 = t4 * t4;
    t6 = (-t2.xxxx) + unity_4LightPosX0;
    t2 = (-t2.zzzz) + unity_4LightPosZ0;
    t5 = t6 * t1.xxxx + t5;
    t1 = t2 * t1.zzzz + t5;
    t4 = t6 * t6 + t4;
    t2 = t2 * t2 + t4;
    t4 = inversesqrt(t2);
    t2 = t2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    t2 = vec4(1.0, 1.0, 1.0, 1.0) / t2;
    t1 = t1 * t4;
    t1 = max(t1, vec4(0.0, 0.0, 0.0, 0.0));
    t1 = t2 * t1;
    t2.xyz = t1.yyy * unity_LightColor[1].xyz;
    t2.xyz = unity_LightColor[0].xyz * t1.xxx + t2.xyz;
    t1.xyz = unity_LightColor[2].xyz * t1.zzz + t2.xyz;
    t1.xyz = unity_LightColor[3].xyz * t1.www + t1.xyz;
    vs_TEXCOORD4.xyz = t3.xyz + t1.xyz;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = t0.zw;
    vs_TEXCOORD5.xy = t1.zz + t1.xw;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
uniform  sampler2D _ShadowMapTexture;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
in  vec4 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
lowp vec4 t10_1;
vec3 t2;
bool tb2;
float t7;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    t10_1 = texture(_ShadowMapTexture, t1.xy);
    t1.xyz = t10_1.xxx * _LightColor0.xyz;
    t7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t7 = max(t7, 0.0);
    t1.xyz = t2.xyz * t1.xyz;
    t2.xyz = t2.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.xyz = t1.xyz * vec3(t7) + t2.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 10 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ScreenParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  vec3 tmpvar_3;
  vec4 pos_4;
  pos_4.zw = gl_Vertex.zw;
  vec2 tmpvar_5;
  tmpvar_5 = (_ScreenParams.xy * 0.5);
  pos_4.xy = ((floor(
    (((gl_Vertex.xy / gl_Vertex.w) * tmpvar_5) + vec2(0.5, 0.5))
  ) / tmpvar_5) * gl_Vertex.w);
  tmpvar_1 = (gl_ModelViewProjectionMatrix * pos_4);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * pos_4).xyz;
  vec4 v_7;
  v_7.x = _World2Object[0].x;
  v_7.y = _World2Object[1].x;
  v_7.z = _World2Object[2].x;
  v_7.w = _World2Object[3].x;
  vec4 v_8;
  v_8.x = _World2Object[0].y;
  v_8.y = _World2Object[1].y;
  v_8.z = _World2Object[2].y;
  v_8.w = _World2Object[3].y;
  vec4 v_9;
  v_9.x = _World2Object[0].z;
  v_9.y = _World2Object[1].z;
  v_9.z = _World2Object[2].z;
  v_9.w = _World2Object[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * gl_Normal.x)
   + 
    (v_8.xyz * gl_Normal.y)
  ) + (v_9.xyz * gl_Normal.z)));
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_11;
  ambient_11 = tmpvar_3;
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_10;
  vec3 res_13;
  vec3 x_14;
  x_14.x = dot (unity_SHAr, tmpvar_12);
  x_14.y = dot (unity_SHAg, tmpvar_12);
  x_14.z = dot (unity_SHAb, tmpvar_12);
  vec3 x1_15;
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_10.xyzz * tmpvar_10.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((tmpvar_10.x * tmpvar_10.x) - (tmpvar_10.y * tmpvar_10.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_13 = max (((1.055 * 
      pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_11 = max (vec3(0.0, 0.0, 0.0), res_13);
  tmpvar_3 = ambient_11;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = gl_Color;
  xlv_TEXCOORD4 = ambient_11;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color * tmpvar_2).xyz;
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = ((tmpvar_3 * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2;
  c_4.w = c_5.w;
  c_4.xyz = (c_5.xyz + (tmpvar_3 * xlv_TEXCOORD4));
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "metal " {
// Stats: 39 math, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 304
Matrix 80 [glstate_matrix_mvp]
Matrix 144 [_Object2World]
Matrix 208 [_World2Object]
Vector 0 [_ScreenParams]
VectorHalf 16 [unity_SHAr] 4
VectorHalf 24 [unity_SHAg] 4
VectorHalf 32 [unity_SHAb] 4
VectorHalf 40 [unity_SHBr] 4
VectorHalf 48 [unity_SHBg] 4
VectorHalf 56 [unity_SHBb] 4
VectorHalf 64 [unity_SHC] 4
VectorHalf 272 [unity_ColorSpaceLuminance] 4
Vector 288 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD4;
};
struct xlatMtlShaderUniform {
  float4 _ScreenParams;
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  float4 tmpvar_3;
  float2 tmpvar_4;
  half3 tmpvar_5;
  half4 tmpvar_6;
  half3 tmpvar_7;
  float4 pos_8;
  pos_8.zw = _mtl_i._glesVertex.zw;
  float2 tmpvar_9;
  tmpvar_9 = (_mtl_u._ScreenParams.xy * 0.5);
  pos_8.xy = ((floor(
    (((_mtl_i._glesVertex.xy / _mtl_i._glesVertex.w) * tmpvar_9) + float2(0.5, 0.5))
  ) / tmpvar_9) * _mtl_i._glesVertex.w);
  tmpvar_6 = tmpvar_1;
  tmpvar_3 = (_mtl_u.glstate_matrix_mvp * pos_8);
  tmpvar_4 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_10;
  tmpvar_10 = (_mtl_u._Object2World * pos_8).xyz;
  float4 v_11;
  v_11.x = _mtl_u._World2Object[0].x;
  v_11.y = _mtl_u._World2Object[1].x;
  v_11.z = _mtl_u._World2Object[2].x;
  v_11.w = _mtl_u._World2Object[3].x;
  float4 v_12;
  v_12.x = _mtl_u._World2Object[0].y;
  v_12.y = _mtl_u._World2Object[1].y;
  v_12.z = _mtl_u._World2Object[2].y;
  v_12.w = _mtl_u._World2Object[3].y;
  float4 v_13;
  v_13.x = _mtl_u._World2Object[0].z;
  v_13.y = _mtl_u._World2Object[1].z;
  v_13.z = _mtl_u._World2Object[2].z;
  v_13.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * _mtl_i._glesNormal.x)
   + 
    (v_12.xyz * _mtl_i._glesNormal.y)
  ) + (v_13.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_14);
  tmpvar_5 = worldNormal_2;
  tmpvar_7 = half3(float3(0.0, 0.0, 0.0));
  half3 normal_15;
  normal_15 = worldNormal_2;
  half3 ambient_16;
  ambient_16 = tmpvar_7;
  half4 tmpvar_17;
  tmpvar_17.w = half(1.0);
  tmpvar_17.xyz = normal_15;
  half3 res_18;
  half3 x_19;
  x_19.x = dot (_mtl_u.unity_SHAr, tmpvar_17);
  x_19.y = dot (_mtl_u.unity_SHAg, tmpvar_17);
  x_19.z = dot (_mtl_u.unity_SHAb, tmpvar_17);
  half3 x1_20;
  half4 tmpvar_21;
  tmpvar_21 = (normal_15.xyzz * normal_15.yzzx);
  x1_20.x = dot (_mtl_u.unity_SHBr, tmpvar_21);
  x1_20.y = dot (_mtl_u.unity_SHBg, tmpvar_21);
  x1_20.z = dot (_mtl_u.unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (_mtl_u.unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  bool tmpvar_22;
  tmpvar_22 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_22) {
    res_18 = max ((((half)1.055 * 
      pow (max (res_18, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  ambient_16 = max ((half3)float3(0.0, 0.0, 0.0), res_18);
  tmpvar_7 = ambient_16;
  _mtl_o.gl_Position = tmpvar_3;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_10;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = ambient_16;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
vec3 t0;
vec4 t1;
vec4 t2;
vec3 t3;
vec3 t4;
vec2 t8;
bool tb12;
void main()
{
    t0.xy = in_POSITION0.xy / in_POSITION0.ww;
    t8.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    t0.xy = t8.xy * t0.xy;
    t0.xy = roundEven(t0.xy);
    t0.xy = t0.xy / t8.xy;
    t0.xy = t0.xy * in_POSITION0.ww;
    t1 = t0.yyyy * glstate_matrix_mvp[1];
    t1 = glstate_matrix_mvp[0] * t0.xxxx + t1;
    t1 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t1;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t1.x = in_NORMAL0.x * _World2Object[0].x;
    t1.y = in_NORMAL0.x * _World2Object[1].x;
    t1.z = in_NORMAL0.x * _World2Object[2].x;
    t2.x = in_NORMAL0.y * _World2Object[0].y;
    t2.y = in_NORMAL0.y * _World2Object[1].y;
    t2.z = in_NORMAL0.y * _World2Object[2].y;
    t1.xyz = t1.xyz + t2.xyz;
    t2.x = in_NORMAL0.z * _World2Object[0].z;
    t2.y = in_NORMAL0.z * _World2Object[1].z;
    t2.z = in_NORMAL0.z * _World2Object[2].z;
    t1.xyz = t1.xyz + t2.xyz;
    t8.x = dot(t1.xyz, t1.xyz);
    t8.x = inversesqrt(t8.x);
    t1.xyz = t8.xxx * t1.xyz;
    vs_TEXCOORD1.xyz = t1.xyz;
    t4.xyz = t0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * t0.xxx + t4.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    t0.x = t1.y * t1.y;
    t0.x = t1.x * t1.x + (-t0.x);
    t2 = t1.yzzx * t1.xyzz;
    t3.x = dot(unity_SHBr, t2);
    t3.y = dot(unity_SHBg, t2);
    t3.z = dot(unity_SHBb, t2);
    t0.xyz = unity_SHC.xyz * t0.xxx + t3.xyz;
    t1.w = 1.0;
    t2.x = dot(unity_SHAr, t1);
    t2.y = dot(unity_SHAg, t1);
    t2.z = dot(unity_SHAb, t1);
    t0.xyz = t0.xyz + t2.xyz;
    t1.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    t1.xyz = log2(t1.xyz);
    t1.xyz = t1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t1.xyz = exp2(t1.xyz);
    t1.xyz = t1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t1.xyz = max(t1.xyz, vec3(0.0, 0.0, 0.0));
    tb12 = unity_ColorSpaceLuminance.w==0.0;
    t0.xyz = (bool(tb12)) ? t1.xyz : t0.xyz;
    vs_TEXCOORD4.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
float t1;
vec3 t2;
bool tb2;
vec3 t3;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t1 = max(t1, 0.0);
    t3.xyz = t2.xyz * _LightColor0.xyz;
    t2.xyz = t2.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.xyz = t3.xyz * vec3(t1) + t2.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 11 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 _ScreenParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  vec3 tmpvar_3;
  vec4 pos_4;
  pos_4.zw = gl_Vertex.zw;
  vec2 tmpvar_5;
  tmpvar_5 = (_ScreenParams.xy * 0.5);
  pos_4.xy = ((floor(
    (((gl_Vertex.xy / gl_Vertex.w) * tmpvar_5) + vec2(0.5, 0.5))
  ) / tmpvar_5) * gl_Vertex.w);
  tmpvar_1 = (gl_ModelViewProjectionMatrix * pos_4);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * pos_4).xyz;
  vec4 v_7;
  v_7.x = _World2Object[0].x;
  v_7.y = _World2Object[1].x;
  v_7.z = _World2Object[2].x;
  v_7.w = _World2Object[3].x;
  vec4 v_8;
  v_8.x = _World2Object[0].y;
  v_8.y = _World2Object[1].y;
  v_8.z = _World2Object[2].y;
  v_8.w = _World2Object[3].y;
  vec4 v_9;
  v_9.x = _World2Object[0].z;
  v_9.y = _World2Object[1].z;
  v_9.z = _World2Object[2].z;
  v_9.w = _World2Object[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * gl_Normal.x)
   + 
    (v_8.xyz * gl_Normal.y)
  ) + (v_9.xyz * gl_Normal.z)));
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_11;
  ambient_11 = tmpvar_3;
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_10;
  vec3 res_13;
  vec3 x_14;
  x_14.x = dot (unity_SHAr, tmpvar_12);
  x_14.y = dot (unity_SHAg, tmpvar_12);
  x_14.z = dot (unity_SHAb, tmpvar_12);
  vec3 x1_15;
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_10.xyzz * tmpvar_10.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((tmpvar_10.x * tmpvar_10.x) - (tmpvar_10.y * tmpvar_10.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_13 = max (((1.055 * 
      pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_11 = max (vec3(0.0, 0.0, 0.0), res_13);
  tmpvar_3 = ambient_11;
  vec4 o_17;
  vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_1 * 0.5);
  vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = gl_Color;
  xlv_TEXCOORD4 = ambient_11;
  xlv_TEXCOORD5 = o_17;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color * tmpvar_2).xyz;
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = ((tmpvar_3 * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2;
  c_4.w = c_5.w;
  c_4.xyz = (c_5.xyz + (tmpvar_3 * xlv_TEXCOORD4));
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "metal " {
// Stats: 42 math, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 320
Matrix 96 [glstate_matrix_mvp]
Matrix 160 [_Object2World]
Matrix 224 [_World2Object]
Vector 0 [_ProjectionParams]
Vector 16 [_ScreenParams]
VectorHalf 32 [unity_SHAr] 4
VectorHalf 40 [unity_SHAg] 4
VectorHalf 48 [unity_SHAb] 4
VectorHalf 56 [unity_SHBr] 4
VectorHalf 64 [unity_SHBg] 4
VectorHalf 72 [unity_SHBb] 4
VectorHalf 80 [unity_SHC] 4
VectorHalf 288 [unity_ColorSpaceLuminance] 4
Vector 304 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD4;
  half4 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float4 _ProjectionParams;
  float4 _ScreenParams;
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  float4 tmpvar_3;
  float2 tmpvar_4;
  half3 tmpvar_5;
  half4 tmpvar_6;
  half3 tmpvar_7;
  half4 tmpvar_8;
  float4 pos_9;
  pos_9.zw = _mtl_i._glesVertex.zw;
  float2 tmpvar_10;
  tmpvar_10 = (_mtl_u._ScreenParams.xy * 0.5);
  pos_9.xy = ((floor(
    (((_mtl_i._glesVertex.xy / _mtl_i._glesVertex.w) * tmpvar_10) + float2(0.5, 0.5))
  ) / tmpvar_10) * _mtl_i._glesVertex.w);
  tmpvar_6 = tmpvar_1;
  tmpvar_3 = (_mtl_u.glstate_matrix_mvp * pos_9);
  tmpvar_4 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_11;
  tmpvar_11 = (_mtl_u._Object2World * pos_9).xyz;
  float4 v_12;
  v_12.x = _mtl_u._World2Object[0].x;
  v_12.y = _mtl_u._World2Object[1].x;
  v_12.z = _mtl_u._World2Object[2].x;
  v_12.w = _mtl_u._World2Object[3].x;
  float4 v_13;
  v_13.x = _mtl_u._World2Object[0].y;
  v_13.y = _mtl_u._World2Object[1].y;
  v_13.z = _mtl_u._World2Object[2].y;
  v_13.w = _mtl_u._World2Object[3].y;
  float4 v_14;
  v_14.x = _mtl_u._World2Object[0].z;
  v_14.y = _mtl_u._World2Object[1].z;
  v_14.z = _mtl_u._World2Object[2].z;
  v_14.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * _mtl_i._glesNormal.x)
   + 
    (v_13.xyz * _mtl_i._glesNormal.y)
  ) + (v_14.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_15);
  tmpvar_5 = worldNormal_2;
  tmpvar_7 = half3(float3(0.0, 0.0, 0.0));
  half3 normal_16;
  normal_16 = worldNormal_2;
  half3 ambient_17;
  ambient_17 = tmpvar_7;
  half4 tmpvar_18;
  tmpvar_18.w = half(1.0);
  tmpvar_18.xyz = normal_16;
  half3 res_19;
  half3 x_20;
  x_20.x = dot (_mtl_u.unity_SHAr, tmpvar_18);
  x_20.y = dot (_mtl_u.unity_SHAg, tmpvar_18);
  x_20.z = dot (_mtl_u.unity_SHAb, tmpvar_18);
  half3 x1_21;
  half4 tmpvar_22;
  tmpvar_22 = (normal_16.xyzz * normal_16.yzzx);
  x1_21.x = dot (_mtl_u.unity_SHBr, tmpvar_22);
  x1_21.y = dot (_mtl_u.unity_SHBg, tmpvar_22);
  x1_21.z = dot (_mtl_u.unity_SHBb, tmpvar_22);
  res_19 = (x_20 + (x1_21 + (_mtl_u.unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  bool tmpvar_23;
  tmpvar_23 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_23) {
    res_19 = max ((((half)1.055 * 
      pow (max (res_19, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  ambient_17 = max ((half3)float3(0.0, 0.0, 0.0), res_19);
  tmpvar_7 = ambient_17;
  float4 o_24;
  float4 tmpvar_25;
  tmpvar_25 = (tmpvar_3 * 0.5);
  float2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _mtl_u._ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_3.zw;
  tmpvar_8 = half4(o_24);
  _mtl_o.gl_Position = tmpvar_3;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_11;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = ambient_17;
  _mtl_o.xlv_TEXCOORD5 = tmpvar_8;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out vec4 vs_TEXCOORD5;
vec4 t0;
vec4 t1;
vec4 t2;
vec4 t3;
vec3 t4;
vec3 t5;
vec2 t10;
bool tb15;
void main()
{
    t0.xy = in_POSITION0.xy / in_POSITION0.ww;
    t10.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    t0.xy = t10.xy * t0.xy;
    t0.xy = roundEven(t0.xy);
    t0.xy = t0.xy / t10.xy;
    t0.xy = t0.xy * in_POSITION0.ww;
    t1 = t0.yyyy * glstate_matrix_mvp[1];
    t1 = glstate_matrix_mvp[0] * t0.xxxx + t1;
    t1 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t1;
    t1 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t1;
    gl_Position = t1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t2.x = in_NORMAL0.x * _World2Object[0].x;
    t2.y = in_NORMAL0.x * _World2Object[1].x;
    t2.z = in_NORMAL0.x * _World2Object[2].x;
    t3.x = in_NORMAL0.y * _World2Object[0].y;
    t3.y = in_NORMAL0.y * _World2Object[1].y;
    t3.z = in_NORMAL0.y * _World2Object[2].y;
    t2.xyz = t2.xyz + t3.xyz;
    t3.x = in_NORMAL0.z * _World2Object[0].z;
    t3.y = in_NORMAL0.z * _World2Object[1].z;
    t3.z = in_NORMAL0.z * _World2Object[2].z;
    t2.xyz = t2.xyz + t3.xyz;
    t10.x = dot(t2.xyz, t2.xyz);
    t10.x = inversesqrt(t10.x);
    t2.xyz = t10.xxx * t2.xyz;
    vs_TEXCOORD1.xyz = t2.xyz;
    t5.xyz = t0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * t0.xxx + t5.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    t0.x = t2.y * t2.y;
    t0.x = t2.x * t2.x + (-t0.x);
    t3 = t2.yzzx * t2.xyzz;
    t4.x = dot(unity_SHBr, t3);
    t4.y = dot(unity_SHBg, t3);
    t4.z = dot(unity_SHBb, t3);
    t0.xyz = unity_SHC.xyz * t0.xxx + t4.xyz;
    t2.w = 1.0;
    t3.x = dot(unity_SHAr, t2);
    t3.y = dot(unity_SHAg, t2);
    t3.z = dot(unity_SHAb, t2);
    t0.xyz = t0.xyz + t3.xyz;
    t2.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    t2.xyz = log2(t2.xyz);
    t2.xyz = t2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t2.xyz = exp2(t2.xyz);
    t2.xyz = t2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t2.xyz = max(t2.xyz, vec3(0.0, 0.0, 0.0));
    tb15 = unity_ColorSpaceLuminance.w==0.0;
    t0.xyz = (bool(tb15)) ? t2.xyz : t0.xyz;
    vs_TEXCOORD4.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    t0.x = t1.y * _ProjectionParams.x;
    t0.w = t0.x * 0.5;
    t0.xz = t1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = t1.zw;
    vs_TEXCOORD5.xy = t0.zz + t0.xw;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
uniform  sampler2D _ShadowMapTexture;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
in  vec4 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
lowp vec4 t10_1;
vec3 t2;
bool tb2;
float t7;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    t10_1 = texture(_ShadowMapTexture, t1.xy);
    t1.xyz = t10_1.xxx * _LightColor0.xyz;
    t7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t7 = max(t7, 0.0);
    t1.xyz = t2.xyz * t1.xyz;
    t2.xyz = t2.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.xyz = t1.xyz * vec3(t7) + t2.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 10 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "PIXELSNAP_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ScreenParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  vec4 pos_3;
  pos_3.zw = gl_Vertex.zw;
  vec2 tmpvar_4;
  tmpvar_4 = (_ScreenParams.xy * 0.5);
  pos_3.xy = ((floor(
    (((gl_Vertex.xy / gl_Vertex.w) * tmpvar_4) + vec2(0.5, 0.5))
  ) / tmpvar_4) * gl_Vertex.w);
  tmpvar_1 = (gl_ModelViewProjectionMatrix * pos_3);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * pos_3).xyz;
  vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * gl_Normal.x)
   + 
    (v_7.xyz * gl_Normal.y)
  ) + (v_8.xyz * gl_Normal.z)));
  vec3 col_10;
  vec4 ndotl_11;
  vec4 lengthSq_12;
  vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - tmpvar_5.x);
  vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - tmpvar_5.y);
  vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_12 = (tmpvar_13 * tmpvar_13);
  lengthSq_12 = (lengthSq_12 + (tmpvar_14 * tmpvar_14));
  lengthSq_12 = (lengthSq_12 + (tmpvar_15 * tmpvar_15));
  ndotl_11 = (tmpvar_13 * tmpvar_9.x);
  ndotl_11 = (ndotl_11 + (tmpvar_14 * tmpvar_9.y));
  ndotl_11 = (ndotl_11 + (tmpvar_15 * tmpvar_9.z));
  vec4 tmpvar_16;
  tmpvar_16 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_11 * inversesqrt(lengthSq_12)));
  ndotl_11 = tmpvar_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * (1.0/((1.0 + 
    (lengthSq_12 * unity_4LightAtten0)
  ))));
  col_10 = (unity_LightColor[0].xyz * tmpvar_17.x);
  col_10 = (col_10 + (unity_LightColor[1].xyz * tmpvar_17.y));
  col_10 = (col_10 + (unity_LightColor[2].xyz * tmpvar_17.z));
  col_10 = (col_10 + (unity_LightColor[3].xyz * tmpvar_17.w));
  vec3 ambient_18;
  ambient_18 = col_10;
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_9;
  vec3 res_20;
  vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  vec3 x1_22;
  vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_9.xyzz * tmpvar_9.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((tmpvar_9.x * tmpvar_9.x) - (tmpvar_9.y * tmpvar_9.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_20 = max (((1.055 * 
      pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_18 = (col_10 + max (vec3(0.0, 0.0, 0.0), res_20));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = gl_Color;
  xlv_TEXCOORD4 = ambient_18;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color * tmpvar_2).xyz;
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = ((tmpvar_3 * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2;
  c_4.w = c_5.w;
  c_4.xyz = (c_5.xyz + (tmpvar_3 * xlv_TEXCOORD4));
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "metal " {
// Stats: 66 math, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "PIXELSNAP_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 416
Matrix 192 [glstate_matrix_mvp]
Matrix 256 [_Object2World]
Matrix 320 [_World2Object]
Vector 0 [_ScreenParams]
Vector 16 [unity_4LightPosX0]
Vector 32 [unity_4LightPosY0]
Vector 48 [unity_4LightPosZ0]
VectorHalf 64 [unity_4LightAtten0] 4
VectorHalf 72 [unity_LightColor0] 4
VectorHalf 80 [unity_LightColor1] 4
VectorHalf 88 [unity_LightColor2] 4
VectorHalf 96 [unity_LightColor3] 4
VectorHalf 104 [unity_LightColor4] 4
VectorHalf 112 [unity_LightColor5] 4
VectorHalf 120 [unity_LightColor6] 4
VectorHalf 128 [unity_LightColor7] 4
VectorHalf 136 [unity_SHAr] 4
VectorHalf 144 [unity_SHAg] 4
VectorHalf 152 [unity_SHAb] 4
VectorHalf 160 [unity_SHBr] 4
VectorHalf 168 [unity_SHBg] 4
VectorHalf 176 [unity_SHBb] 4
VectorHalf 184 [unity_SHC] 4
VectorHalf 384 [unity_ColorSpaceLuminance] 4
Vector 400 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD4;
};
struct xlatMtlShaderUniform {
  float4 _ScreenParams;
  float4 unity_4LightPosX0;
  float4 unity_4LightPosY0;
  float4 unity_4LightPosZ0;
  half4 unity_4LightAtten0;
  half4 unity_LightColor[8];
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  float4 tmpvar_3;
  float2 tmpvar_4;
  half3 tmpvar_5;
  half4 tmpvar_6;
  half3 tmpvar_7;
  float4 pos_8;
  pos_8.zw = _mtl_i._glesVertex.zw;
  float2 tmpvar_9;
  tmpvar_9 = (_mtl_u._ScreenParams.xy * 0.5);
  pos_8.xy = ((floor(
    (((_mtl_i._glesVertex.xy / _mtl_i._glesVertex.w) * tmpvar_9) + float2(0.5, 0.5))
  ) / tmpvar_9) * _mtl_i._glesVertex.w);
  tmpvar_6 = tmpvar_1;
  tmpvar_3 = (_mtl_u.glstate_matrix_mvp * pos_8);
  tmpvar_4 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_10;
  tmpvar_10 = (_mtl_u._Object2World * pos_8).xyz;
  float4 v_11;
  v_11.x = _mtl_u._World2Object[0].x;
  v_11.y = _mtl_u._World2Object[1].x;
  v_11.z = _mtl_u._World2Object[2].x;
  v_11.w = _mtl_u._World2Object[3].x;
  float4 v_12;
  v_12.x = _mtl_u._World2Object[0].y;
  v_12.y = _mtl_u._World2Object[1].y;
  v_12.z = _mtl_u._World2Object[2].y;
  v_12.w = _mtl_u._World2Object[3].y;
  float4 v_13;
  v_13.x = _mtl_u._World2Object[0].z;
  v_13.y = _mtl_u._World2Object[1].z;
  v_13.z = _mtl_u._World2Object[2].z;
  v_13.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * _mtl_i._glesNormal.x)
   + 
    (v_12.xyz * _mtl_i._glesNormal.y)
  ) + (v_13.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_14);
  tmpvar_5 = worldNormal_2;
  float3 lightColor0_15;
  lightColor0_15 = float3(_mtl_u.unity_LightColor[0].xyz);
  float3 lightColor1_16;
  lightColor1_16 = float3(_mtl_u.unity_LightColor[1].xyz);
  float3 lightColor2_17;
  lightColor2_17 = float3(_mtl_u.unity_LightColor[2].xyz);
  float3 lightColor3_18;
  lightColor3_18 = float3(_mtl_u.unity_LightColor[3].xyz);
  float4 lightAttenSq_19;
  lightAttenSq_19 = float4(_mtl_u.unity_4LightAtten0);
  float3 normal_20;
  normal_20 = float3(worldNormal_2);
  float3 col_21;
  float4 ndotl_22;
  float4 lengthSq_23;
  float4 tmpvar_24;
  tmpvar_24 = (_mtl_u.unity_4LightPosX0 - tmpvar_10.x);
  float4 tmpvar_25;
  tmpvar_25 = (_mtl_u.unity_4LightPosY0 - tmpvar_10.y);
  float4 tmpvar_26;
  tmpvar_26 = (_mtl_u.unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  ndotl_22 = (tmpvar_24 * normal_20.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * normal_20.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * normal_20.z));
  float4 tmpvar_27;
  tmpvar_27 = max (float4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * rsqrt(lengthSq_23)));
  ndotl_22 = tmpvar_27;
  float4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (lengthSq_23 * lightAttenSq_19)
  ))));
  col_21 = (lightColor0_15 * tmpvar_28.x);
  col_21 = (col_21 + (lightColor1_16 * tmpvar_28.y));
  col_21 = (col_21 + (lightColor2_17 * tmpvar_28.z));
  col_21 = (col_21 + (lightColor3_18 * tmpvar_28.w));
  tmpvar_7 = half3(col_21);
  half3 normal_29;
  normal_29 = worldNormal_2;
  half3 ambient_30;
  ambient_30 = tmpvar_7;
  half4 tmpvar_31;
  tmpvar_31.w = half(1.0);
  tmpvar_31.xyz = normal_29;
  half3 res_32;
  half3 x_33;
  x_33.x = dot (_mtl_u.unity_SHAr, tmpvar_31);
  x_33.y = dot (_mtl_u.unity_SHAg, tmpvar_31);
  x_33.z = dot (_mtl_u.unity_SHAb, tmpvar_31);
  half3 x1_34;
  half4 tmpvar_35;
  tmpvar_35 = (normal_29.xyzz * normal_29.yzzx);
  x1_34.x = dot (_mtl_u.unity_SHBr, tmpvar_35);
  x1_34.y = dot (_mtl_u.unity_SHBg, tmpvar_35);
  x1_34.z = dot (_mtl_u.unity_SHBb, tmpvar_35);
  res_32 = (x_33 + (x1_34 + (_mtl_u.unity_SHC.xyz * 
    ((normal_29.x * normal_29.x) - (normal_29.y * normal_29.y))
  )));
  bool tmpvar_36;
  tmpvar_36 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_36) {
    res_32 = max ((((half)1.055 * 
      pow (max (res_32, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  ambient_30 = (tmpvar_7 + max ((half3)float3(0.0, 0.0, 0.0), res_32));
  tmpvar_7 = ambient_30;
  _mtl_o.gl_Position = tmpvar_3;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_10;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = ambient_30;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
vec4 t0;
vec4 t1;
vec4 t2;
vec4 t3;
vec4 t4;
vec4 t5;
vec3 t6;
vec2 t12;
float t18;
bool tb18;
void main()
{
    t0.xy = in_POSITION0.xy / in_POSITION0.ww;
    t12.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    t0.xy = t12.xy * t0.xy;
    t0.xy = roundEven(t0.xy);
    t0.xy = t0.xy / t12.xy;
    t0.xy = t0.xy * in_POSITION0.ww;
    t1 = t0.yyyy * glstate_matrix_mvp[1];
    t1 = glstate_matrix_mvp[0] * t0.xxxx + t1;
    t1 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t1;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t1.x = in_NORMAL0.x * _World2Object[0].x;
    t1.y = in_NORMAL0.x * _World2Object[1].x;
    t1.z = in_NORMAL0.x * _World2Object[2].x;
    t2.x = in_NORMAL0.y * _World2Object[0].y;
    t2.y = in_NORMAL0.y * _World2Object[1].y;
    t2.z = in_NORMAL0.y * _World2Object[2].y;
    t1.xyz = t1.xyz + t2.xyz;
    t2.x = in_NORMAL0.z * _World2Object[0].z;
    t2.y = in_NORMAL0.z * _World2Object[1].z;
    t2.z = in_NORMAL0.z * _World2Object[2].z;
    t1.xyz = t1.xyz + t2.xyz;
    t12.x = dot(t1.xyz, t1.xyz);
    t12.x = inversesqrt(t12.x);
    t1.xyz = t12.xxx * t1.xyz;
    vs_TEXCOORD1.xyz = t1.xyz;
    t6.xyz = t0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * t0.xxx + t6.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD2.xyz = t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    t18 = t1.y * t1.y;
    t18 = t1.x * t1.x + (-t18);
    t2 = t1.yzzx * t1.xyzz;
    t3.x = dot(unity_SHBr, t2);
    t3.y = dot(unity_SHBg, t2);
    t3.z = dot(unity_SHBb, t2);
    t2.xyz = unity_SHC.xyz * vec3(t18) + t3.xyz;
    t1.w = 1.0;
    t3.x = dot(unity_SHAr, t1);
    t3.y = dot(unity_SHAg, t1);
    t3.z = dot(unity_SHAb, t1);
    t2.xyz = t2.xyz + t3.xyz;
    t3.xyz = max(t2.xyz, vec3(0.0, 0.0, 0.0));
    t3.xyz = log2(t3.xyz);
    t3.xyz = t3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t3.xyz = exp2(t3.xyz);
    t3.xyz = t3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t3.xyz = max(t3.xyz, vec3(0.0, 0.0, 0.0));
    tb18 = unity_ColorSpaceLuminance.w==0.0;
    t2.xyz = (bool(tb18)) ? t3.xyz : t2.xyz;
    t2.xyz = max(t2.xyz, vec3(0.0, 0.0, 0.0));
    t3 = (-t0.yyyy) + unity_4LightPosY0;
    t4 = t1.yyyy * t3;
    t3 = t3 * t3;
    t5 = (-t0.xxxx) + unity_4LightPosX0;
    t0 = (-t0.zzzz) + unity_4LightPosZ0;
    t4 = t5 * t1.xxxx + t4;
    t1 = t0 * t1.zzzz + t4;
    t3 = t5 * t5 + t3;
    t0 = t0 * t0 + t3;
    t3 = inversesqrt(t0);
    t0 = t0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    t0 = vec4(1.0, 1.0, 1.0, 1.0) / t0;
    t1 = t1 * t3;
    t1 = max(t1, vec4(0.0, 0.0, 0.0, 0.0));
    t0 = t0 * t1;
    t1.xyz = t0.yyy * unity_LightColor[1].xyz;
    t1.xyz = unity_LightColor[0].xyz * t0.xxx + t1.xyz;
    t0.xyz = unity_LightColor[2].xyz * t0.zzz + t1.xyz;
    t0.xyz = unity_LightColor[3].xyz * t0.www + t0.xyz;
    vs_TEXCOORD4.xyz = t2.xyz + t0.xyz;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
float t1;
vec3 t2;
bool tb2;
vec3 t3;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t1 = max(t1, 0.0);
    t3.xyz = t2.xyz * _LightColor0.xyz;
    t2.xyz = t2.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.xyz = t3.xyz * vec3(t1) + t2.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 11 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "PIXELSNAP_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 _ScreenParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  vec4 pos_3;
  pos_3.zw = gl_Vertex.zw;
  vec2 tmpvar_4;
  tmpvar_4 = (_ScreenParams.xy * 0.5);
  pos_3.xy = ((floor(
    (((gl_Vertex.xy / gl_Vertex.w) * tmpvar_4) + vec2(0.5, 0.5))
  ) / tmpvar_4) * gl_Vertex.w);
  tmpvar_1 = (gl_ModelViewProjectionMatrix * pos_3);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * pos_3).xyz;
  vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * gl_Normal.x)
   + 
    (v_7.xyz * gl_Normal.y)
  ) + (v_8.xyz * gl_Normal.z)));
  vec3 col_10;
  vec4 ndotl_11;
  vec4 lengthSq_12;
  vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - tmpvar_5.x);
  vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - tmpvar_5.y);
  vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_12 = (tmpvar_13 * tmpvar_13);
  lengthSq_12 = (lengthSq_12 + (tmpvar_14 * tmpvar_14));
  lengthSq_12 = (lengthSq_12 + (tmpvar_15 * tmpvar_15));
  ndotl_11 = (tmpvar_13 * tmpvar_9.x);
  ndotl_11 = (ndotl_11 + (tmpvar_14 * tmpvar_9.y));
  ndotl_11 = (ndotl_11 + (tmpvar_15 * tmpvar_9.z));
  vec4 tmpvar_16;
  tmpvar_16 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_11 * inversesqrt(lengthSq_12)));
  ndotl_11 = tmpvar_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * (1.0/((1.0 + 
    (lengthSq_12 * unity_4LightAtten0)
  ))));
  col_10 = (unity_LightColor[0].xyz * tmpvar_17.x);
  col_10 = (col_10 + (unity_LightColor[1].xyz * tmpvar_17.y));
  col_10 = (col_10 + (unity_LightColor[2].xyz * tmpvar_17.z));
  col_10 = (col_10 + (unity_LightColor[3].xyz * tmpvar_17.w));
  vec3 ambient_18;
  ambient_18 = col_10;
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_9;
  vec3 res_20;
  vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  vec3 x1_22;
  vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_9.xyzz * tmpvar_9.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((tmpvar_9.x * tmpvar_9.x) - (tmpvar_9.y * tmpvar_9.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_20 = max (((1.055 * 
      pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_18 = (col_10 + max (vec3(0.0, 0.0, 0.0), res_20));
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = gl_Color;
  xlv_TEXCOORD4 = ambient_18;
  xlv_TEXCOORD5 = o_24;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec3 tmpvar_3;
  tmpvar_3 = (_Color * tmpvar_2).xyz;
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = ((tmpvar_3 * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2;
  c_4.w = c_5.w;
  c_4.xyz = (c_5.xyz + (tmpvar_3 * xlv_TEXCOORD4));
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "metal " {
// Stats: 69 math, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "PIXELSNAP_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 432
Matrix 208 [glstate_matrix_mvp]
Matrix 272 [_Object2World]
Matrix 336 [_World2Object]
Vector 0 [_ProjectionParams]
Vector 16 [_ScreenParams]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
VectorHalf 80 [unity_4LightAtten0] 4
VectorHalf 88 [unity_LightColor0] 4
VectorHalf 96 [unity_LightColor1] 4
VectorHalf 104 [unity_LightColor2] 4
VectorHalf 112 [unity_LightColor3] 4
VectorHalf 120 [unity_LightColor4] 4
VectorHalf 128 [unity_LightColor5] 4
VectorHalf 136 [unity_LightColor6] 4
VectorHalf 144 [unity_LightColor7] 4
VectorHalf 152 [unity_SHAr] 4
VectorHalf 160 [unity_SHAg] 4
VectorHalf 168 [unity_SHAb] 4
VectorHalf 176 [unity_SHBr] 4
VectorHalf 184 [unity_SHBg] 4
VectorHalf 192 [unity_SHBb] 4
VectorHalf 200 [unity_SHC] 4
VectorHalf 400 [unity_ColorSpaceLuminance] 4
Vector 416 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD4;
  half4 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float4 _ProjectionParams;
  float4 _ScreenParams;
  float4 unity_4LightPosX0;
  float4 unity_4LightPosY0;
  float4 unity_4LightPosZ0;
  half4 unity_4LightAtten0;
  half4 unity_LightColor[8];
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  float4 tmpvar_3;
  float2 tmpvar_4;
  half3 tmpvar_5;
  half4 tmpvar_6;
  half3 tmpvar_7;
  half4 tmpvar_8;
  float4 pos_9;
  pos_9.zw = _mtl_i._glesVertex.zw;
  float2 tmpvar_10;
  tmpvar_10 = (_mtl_u._ScreenParams.xy * 0.5);
  pos_9.xy = ((floor(
    (((_mtl_i._glesVertex.xy / _mtl_i._glesVertex.w) * tmpvar_10) + float2(0.5, 0.5))
  ) / tmpvar_10) * _mtl_i._glesVertex.w);
  tmpvar_6 = tmpvar_1;
  tmpvar_3 = (_mtl_u.glstate_matrix_mvp * pos_9);
  tmpvar_4 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_11;
  tmpvar_11 = (_mtl_u._Object2World * pos_9).xyz;
  float4 v_12;
  v_12.x = _mtl_u._World2Object[0].x;
  v_12.y = _mtl_u._World2Object[1].x;
  v_12.z = _mtl_u._World2Object[2].x;
  v_12.w = _mtl_u._World2Object[3].x;
  float4 v_13;
  v_13.x = _mtl_u._World2Object[0].y;
  v_13.y = _mtl_u._World2Object[1].y;
  v_13.z = _mtl_u._World2Object[2].y;
  v_13.w = _mtl_u._World2Object[3].y;
  float4 v_14;
  v_14.x = _mtl_u._World2Object[0].z;
  v_14.y = _mtl_u._World2Object[1].z;
  v_14.z = _mtl_u._World2Object[2].z;
  v_14.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * _mtl_i._glesNormal.x)
   + 
    (v_13.xyz * _mtl_i._glesNormal.y)
  ) + (v_14.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_15);
  tmpvar_5 = worldNormal_2;
  float3 lightColor0_16;
  lightColor0_16 = float3(_mtl_u.unity_LightColor[0].xyz);
  float3 lightColor1_17;
  lightColor1_17 = float3(_mtl_u.unity_LightColor[1].xyz);
  float3 lightColor2_18;
  lightColor2_18 = float3(_mtl_u.unity_LightColor[2].xyz);
  float3 lightColor3_19;
  lightColor3_19 = float3(_mtl_u.unity_LightColor[3].xyz);
  float4 lightAttenSq_20;
  lightAttenSq_20 = float4(_mtl_u.unity_4LightAtten0);
  float3 normal_21;
  normal_21 = float3(worldNormal_2);
  float3 col_22;
  float4 ndotl_23;
  float4 lengthSq_24;
  float4 tmpvar_25;
  tmpvar_25 = (_mtl_u.unity_4LightPosX0 - tmpvar_11.x);
  float4 tmpvar_26;
  tmpvar_26 = (_mtl_u.unity_4LightPosY0 - tmpvar_11.y);
  float4 tmpvar_27;
  tmpvar_27 = (_mtl_u.unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_24 = (tmpvar_25 * tmpvar_25);
  lengthSq_24 = (lengthSq_24 + (tmpvar_26 * tmpvar_26));
  lengthSq_24 = (lengthSq_24 + (tmpvar_27 * tmpvar_27));
  ndotl_23 = (tmpvar_25 * normal_21.x);
  ndotl_23 = (ndotl_23 + (tmpvar_26 * normal_21.y));
  ndotl_23 = (ndotl_23 + (tmpvar_27 * normal_21.z));
  float4 tmpvar_28;
  tmpvar_28 = max (float4(0.0, 0.0, 0.0, 0.0), (ndotl_23 * rsqrt(lengthSq_24)));
  ndotl_23 = tmpvar_28;
  float4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (lengthSq_24 * lightAttenSq_20)
  ))));
  col_22 = (lightColor0_16 * tmpvar_29.x);
  col_22 = (col_22 + (lightColor1_17 * tmpvar_29.y));
  col_22 = (col_22 + (lightColor2_18 * tmpvar_29.z));
  col_22 = (col_22 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_7 = half3(col_22);
  half3 normal_30;
  normal_30 = worldNormal_2;
  half3 ambient_31;
  ambient_31 = tmpvar_7;
  half4 tmpvar_32;
  tmpvar_32.w = half(1.0);
  tmpvar_32.xyz = normal_30;
  half3 res_33;
  half3 x_34;
  x_34.x = dot (_mtl_u.unity_SHAr, tmpvar_32);
  x_34.y = dot (_mtl_u.unity_SHAg, tmpvar_32);
  x_34.z = dot (_mtl_u.unity_SHAb, tmpvar_32);
  half3 x1_35;
  half4 tmpvar_36;
  tmpvar_36 = (normal_30.xyzz * normal_30.yzzx);
  x1_35.x = dot (_mtl_u.unity_SHBr, tmpvar_36);
  x1_35.y = dot (_mtl_u.unity_SHBg, tmpvar_36);
  x1_35.z = dot (_mtl_u.unity_SHBb, tmpvar_36);
  res_33 = (x_34 + (x1_35 + (_mtl_u.unity_SHC.xyz * 
    ((normal_30.x * normal_30.x) - (normal_30.y * normal_30.y))
  )));
  bool tmpvar_37;
  tmpvar_37 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_37) {
    res_33 = max ((((half)1.055 * 
      pow (max (res_33, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  ambient_31 = (tmpvar_7 + max ((half3)float3(0.0, 0.0, 0.0), res_33));
  tmpvar_7 = ambient_31;
  float4 o_38;
  float4 tmpvar_39;
  tmpvar_39 = (tmpvar_3 * 0.5);
  float2 tmpvar_40;
  tmpvar_40.x = tmpvar_39.x;
  tmpvar_40.y = (tmpvar_39.y * _mtl_u._ProjectionParams.x);
  o_38.xy = (tmpvar_40 + tmpvar_39.w);
  o_38.zw = tmpvar_3.zw;
  tmpvar_8 = half4(o_38);
  _mtl_o.gl_Position = tmpvar_3;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_11;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = ambient_31;
  _mtl_o.xlv_TEXCOORD5 = tmpvar_8;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out vec4 vs_TEXCOORD5;
vec4 t0;
vec4 t1;
vec4 t2;
vec4 t3;
vec4 t4;
vec4 t5;
vec4 t6;
vec3 t7;
vec2 t14;
float t21;
bool tb21;
void main()
{
    t0.xy = in_POSITION0.xy / in_POSITION0.ww;
    t14.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    t0.xy = t14.xy * t0.xy;
    t0.xy = roundEven(t0.xy);
    t0.xy = t0.xy / t14.xy;
    t0.xy = t0.xy * in_POSITION0.ww;
    t1 = t0.yyyy * glstate_matrix_mvp[1];
    t1 = glstate_matrix_mvp[0] * t0.xxxx + t1;
    t1 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t1;
    t1 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t1;
    gl_Position = t1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t2.x = in_NORMAL0.x * _World2Object[0].x;
    t2.y = in_NORMAL0.x * _World2Object[1].x;
    t2.z = in_NORMAL0.x * _World2Object[2].x;
    t3.x = in_NORMAL0.y * _World2Object[0].y;
    t3.y = in_NORMAL0.y * _World2Object[1].y;
    t3.z = in_NORMAL0.y * _World2Object[2].y;
    t2.xyz = t2.xyz + t3.xyz;
    t3.x = in_NORMAL0.z * _World2Object[0].z;
    t3.y = in_NORMAL0.z * _World2Object[1].z;
    t3.z = in_NORMAL0.z * _World2Object[2].z;
    t2.xyz = t2.xyz + t3.xyz;
    t14.x = dot(t2.xyz, t2.xyz);
    t14.x = inversesqrt(t14.x);
    t2.xyz = t14.xxx * t2.xyz;
    vs_TEXCOORD1.xyz = t2.xyz;
    t7.xyz = t0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * t0.xxx + t7.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD2.xyz = t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    t21 = t2.y * t2.y;
    t21 = t2.x * t2.x + (-t21);
    t3 = t2.yzzx * t2.xyzz;
    t4.x = dot(unity_SHBr, t3);
    t4.y = dot(unity_SHBg, t3);
    t4.z = dot(unity_SHBb, t3);
    t3.xyz = unity_SHC.xyz * vec3(t21) + t4.xyz;
    t2.w = 1.0;
    t4.x = dot(unity_SHAr, t2);
    t4.y = dot(unity_SHAg, t2);
    t4.z = dot(unity_SHAb, t2);
    t3.xyz = t3.xyz + t4.xyz;
    t4.xyz = max(t3.xyz, vec3(0.0, 0.0, 0.0));
    t4.xyz = log2(t4.xyz);
    t4.xyz = t4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t4.xyz = exp2(t4.xyz);
    t4.xyz = t4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t4.xyz = max(t4.xyz, vec3(0.0, 0.0, 0.0));
    tb21 = unity_ColorSpaceLuminance.w==0.0;
    t3.xyz = (bool(tb21)) ? t4.xyz : t3.xyz;
    t3.xyz = max(t3.xyz, vec3(0.0, 0.0, 0.0));
    t4 = (-t0.yyyy) + unity_4LightPosY0;
    t5 = t2.yyyy * t4;
    t4 = t4 * t4;
    t6 = (-t0.xxxx) + unity_4LightPosX0;
    t0 = (-t0.zzzz) + unity_4LightPosZ0;
    t5 = t6 * t2.xxxx + t5;
    t2 = t0 * t2.zzzz + t5;
    t4 = t6 * t6 + t4;
    t0 = t0 * t0 + t4;
    t4 = inversesqrt(t0);
    t0 = t0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    t0 = vec4(1.0, 1.0, 1.0, 1.0) / t0;
    t2 = t2 * t4;
    t2 = max(t2, vec4(0.0, 0.0, 0.0, 0.0));
    t0 = t0 * t2;
    t2.xyz = t0.yyy * unity_LightColor[1].xyz;
    t2.xyz = unity_LightColor[0].xyz * t0.xxx + t2.xyz;
    t0.xyz = unity_LightColor[2].xyz * t0.zzz + t2.xyz;
    t0.xyz = unity_LightColor[3].xyz * t0.www + t0.xyz;
    vs_TEXCOORD4.xyz = t3.xyz + t0.xyz;
    t0.x = t1.y * _ProjectionParams.x;
    t0.w = t0.x * 0.5;
    t0.xz = t1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = t1.zw;
    vs_TEXCOORD5.xy = t0.zz + t0.xw;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
uniform  sampler2D _ShadowMapTexture;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
in  vec4 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
lowp vec4 t10_1;
vec3 t2;
bool tb2;
float t7;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    t10_1 = texture(_ShadowMapTexture, t1.xy);
    t1.xyz = t10_1.xxx * _LightColor0.xyz;
    t7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t7 = max(t7, 0.0);
    t1.xyz = t2.xyz * t1.xyz;
    t2.xyz = t2.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.xyz = t1.xyz * vec3(t7) + t2.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 10 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 28
VectorHalf 0 [_WorldSpaceLightPos0] 4
VectorHalf 8 [_LightColor0] 4
VectorHalf 16 [_Color] 4
Float 24 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half3 tmpvar_1;
  half3 tmpvar_2;
  half3 tmpvar_3;
  half3 lightDir_4;
  half4 tmpvar_5;
  tmpvar_5 = _mtl_i.xlv_TEXCOORD3;
  half3 tmpvar_6;
  tmpvar_6 = _mtl_u._WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_3 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_7;
  half tmpvar_8;
  float alpha_9;
  half4 tmpvar_10;
  tmpvar_10 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_5);
  if (((float)tmpvar_10.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_11;
  tmpvar_11 = (tmpvar_10.w * (half)1e+08);
  alpha_9 = float(tmpvar_11);
  float3 tmpvar_12;
  tmpvar_12 = ((float4)_mtl_u._Color * alpha_9).xyz;
  tmpvar_7 = half3(tmpvar_12);
  tmpvar_8 = half(alpha_9);
  tmpvar_1 = _mtl_u._LightColor0.xyz;
  tmpvar_2 = lightDir_4;
  half4 c_13;
  half4 c_14;
  half diff_15;
  half tmpvar_16;
  tmpvar_16 = max ((half)0.0, dot (tmpvar_3, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = tmpvar_8;
  c_13.w = c_14.w;
  c_13.xyz = (c_14.xyz + (tmpvar_7 * _mtl_i.xlv_TEXCOORD4));
  _mtl_o._glesFragData_0 = c_13;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 11 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
ConstBuffer "$Globals" 28
VectorHalf 0 [_WorldSpaceLightPos0] 4
VectorHalf 8 [_LightColor0] 4
VectorHalf 16 [_Color] 4
Float 24 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD4;
  half4 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _MainTex [[texture(1)]], sampler _mtlsmp__MainTex [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half tmpvar_1;
  half3 tmpvar_2;
  half3 tmpvar_3;
  half3 tmpvar_4;
  half3 lightDir_5;
  half4 tmpvar_6;
  tmpvar_6 = _mtl_i.xlv_TEXCOORD3;
  half3 tmpvar_7;
  tmpvar_7 = _mtl_u._WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_4 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_8;
  half tmpvar_9;
  float alpha_10;
  half4 tmpvar_11;
  tmpvar_11 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_6);
  if (((float)tmpvar_11.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_12;
  tmpvar_12 = (tmpvar_11.w * (half)1e+08);
  alpha_10 = float(tmpvar_12);
  float3 tmpvar_13;
  tmpvar_13 = ((float4)_mtl_u._Color * alpha_10).xyz;
  tmpvar_8 = half3(tmpvar_13);
  tmpvar_9 = half(alpha_10);
  half tmpvar_14;
  tmpvar_14 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, ((float2)(_mtl_i.xlv_TEXCOORD5).xy / (float)(_mtl_i.xlv_TEXCOORD5).w)).x;
  tmpvar_2 = _mtl_u._LightColor0.xyz;
  tmpvar_3 = lightDir_5;
  tmpvar_1 = tmpvar_14;
  half3 tmpvar_15;
  tmpvar_15 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_15;
  half4 c_16;
  half4 c_17;
  half diff_18;
  half tmpvar_19;
  tmpvar_19 = max ((half)0.0, dot (tmpvar_4, tmpvar_3));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_8 * tmpvar_15) * diff_18);
  c_17.w = tmpvar_9;
  c_16.w = c_17.w;
  c_16.xyz = (c_17.xyz + (tmpvar_8 * _mtl_i.xlv_TEXCOORD4));
  _mtl_o._glesFragData_0 = c_16;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 10 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 28
VectorHalf 0 [_WorldSpaceLightPos0] 4
VectorHalf 8 [_LightColor0] 4
VectorHalf 16 [_Color] 4
Float 24 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD4;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half3 tmpvar_1;
  half3 tmpvar_2;
  half3 tmpvar_3;
  half3 lightDir_4;
  half4 tmpvar_5;
  tmpvar_5 = _mtl_i.xlv_TEXCOORD3;
  half3 tmpvar_6;
  tmpvar_6 = _mtl_u._WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_3 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_7;
  half tmpvar_8;
  float alpha_9;
  half4 tmpvar_10;
  tmpvar_10 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_5);
  if (((float)tmpvar_10.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_11;
  tmpvar_11 = (tmpvar_10.w * (half)1e+08);
  alpha_9 = float(tmpvar_11);
  float3 tmpvar_12;
  tmpvar_12 = ((float4)_mtl_u._Color * alpha_9).xyz;
  tmpvar_7 = half3(tmpvar_12);
  tmpvar_8 = half(alpha_9);
  tmpvar_1 = _mtl_u._LightColor0.xyz;
  tmpvar_2 = lightDir_4;
  half4 c_13;
  half4 c_14;
  half diff_15;
  half tmpvar_16;
  tmpvar_16 = max ((half)0.0, dot (tmpvar_3, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = tmpvar_8;
  c_13.w = c_14.w;
  c_13.xyz = (c_14.xyz + (tmpvar_7 * _mtl_i.xlv_TEXCOORD4));
  _mtl_o._glesFragData_0 = c_13;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 11 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" }
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
ConstBuffer "$Globals" 28
VectorHalf 0 [_WorldSpaceLightPos0] 4
VectorHalf 8 [_LightColor0] 4
VectorHalf 16 [_Color] 4
Float 24 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD4;
  half4 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _ShadowMapTexture [[texture(0)]], sampler _mtlsmp__ShadowMapTexture [[sampler(0)]]
  ,   texture2d<half> _MainTex [[texture(1)]], sampler _mtlsmp__MainTex [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half tmpvar_1;
  half3 tmpvar_2;
  half3 tmpvar_3;
  half3 tmpvar_4;
  half3 lightDir_5;
  half4 tmpvar_6;
  tmpvar_6 = _mtl_i.xlv_TEXCOORD3;
  half3 tmpvar_7;
  tmpvar_7 = _mtl_u._WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_4 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_8;
  half tmpvar_9;
  float alpha_10;
  half4 tmpvar_11;
  tmpvar_11 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_6);
  if (((float)tmpvar_11.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_12;
  tmpvar_12 = (tmpvar_11.w * (half)1e+08);
  alpha_10 = float(tmpvar_12);
  float3 tmpvar_13;
  tmpvar_13 = ((float4)_mtl_u._Color * alpha_10).xyz;
  tmpvar_8 = half3(tmpvar_13);
  tmpvar_9 = half(alpha_10);
  half tmpvar_14;
  tmpvar_14 = _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, ((float2)(_mtl_i.xlv_TEXCOORD5).xy / (float)(_mtl_i.xlv_TEXCOORD5).w)).x;
  tmpvar_2 = _mtl_u._LightColor0.xyz;
  tmpvar_3 = lightDir_5;
  tmpvar_1 = tmpvar_14;
  half3 tmpvar_15;
  tmpvar_15 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_15;
  half4 c_16;
  half4 c_17;
  half diff_18;
  half tmpvar_19;
  tmpvar_19 = max ((half)0.0, dot (tmpvar_4, tmpvar_3));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_8 * tmpvar_15) * diff_18);
  c_17.w = tmpvar_9;
  c_16.w = c_17.w;
  c_16.xyz = (c_17.xyz + (tmpvar_8 * _mtl_i.xlv_TEXCOORD4));
  _mtl_o._glesFragData_0 = c_16;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" }
"// shader disassembly not supported on glcore"
}
}
 }


 // Stats for Vertex shader:
 //       metal : 13 avg math (10..17)
 //      opengl : 13 avg math (8..20), 3 avg texture (2..4), 1 branch
 // Stats for Fragment shader:
 //       metal : 13 avg math (8..20), 3 avg texture (2..4), 1 branch
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="true" }
  ZWrite Off
  Cull Off
  Blend One One
  GpuProgramID 98968
Program "vp" {
SubProgram "opengl " {
// Stats: 14 math, 3 textures, 1 branches
Keywords { "POINT" }
"#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD3 = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_4;
  tmpvar_4 = (_LightMatrix0 * tmpvar_3).xyz;
  vec4 c_5;
  vec4 c_6;
  c_6.xyz = (((_Color * tmpvar_2).xyz * (_LightColor0.xyz * texture2D (_LightTexture0, vec2(
    dot (tmpvar_4, tmpvar_4)
  )).w)) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_6.w = tmpvar_2;
  c_5.w = c_6.w;
  c_5.xyz = c_6.xyz;
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "metal " {
// Stats: 10 math
Keywords { "POINT" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 208
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
Matrix 128 [_World2Object]
Vector 192 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  half3 tmpvar_3;
  half4 tmpvar_4;
  tmpvar_4 = tmpvar_1;
  float4 v_5;
  v_5.x = _mtl_u._World2Object[0].x;
  v_5.y = _mtl_u._World2Object[1].x;
  v_5.z = _mtl_u._World2Object[2].x;
  v_5.w = _mtl_u._World2Object[3].x;
  float4 v_6;
  v_6.x = _mtl_u._World2Object[0].y;
  v_6.y = _mtl_u._World2Object[1].y;
  v_6.z = _mtl_u._World2Object[2].y;
  v_6.w = _mtl_u._World2Object[3].y;
  float4 v_7;
  v_7.x = _mtl_u._World2Object[0].z;
  v_7.y = _mtl_u._World2Object[1].z;
  v_7.z = _mtl_u._World2Object[2].z;
  v_7.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_8;
  tmpvar_8 = normalize(((
    (v_5.xyz * _mtl_i._glesNormal.x)
   + 
    (v_6.xyz * _mtl_i._glesNormal.y)
  ) + (v_7.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_8);
  tmpvar_3 = worldNormal_2;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  _mtl_o.xlv_TEXCOORD1 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_4;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
vec4 t0;
vec3 t1;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD1.xyz = vec3(t6) * t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
uniform  sampler2D _LightTexture0;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
vec3 t2;
lowp vec4 t10_2;
vec3 t3;
bool tb3;
float t10;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb3 = t0<_AlphaCutoff;
    if((int(tb3) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t3.xyz = vec3(t0) * _Color.xyz;
    t1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    t10 = dot(t1.xyz, t1.xyz);
    t10 = inversesqrt(t10);
    t1.xyz = vec3(t10) * t1.xyz;
    t2.xyz = vs_TEXCOORD2.yyy * _LightMatrix0[1].xyz;
    t2.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD2.xxx + t2.xyz;
    t2.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD2.zzz + t2.xyz;
    t2.xyz = t2.xyz + _LightMatrix0[3].xyz;
    t10 = dot(t2.xyz, t2.xyz);
    t10_2 = texture(_LightTexture0, vec2(t10));
    t2.xyz = t10_2.www * _LightColor0.xyz;
    t1.x = dot(vs_TEXCOORD1.xyz, t1.xyz);
    t1.x = max(t1.x, 0.0);
    t3.xyz = t3.xyz * t2.xyz;
    SV_Target0.xyz = t1.xxx * t3.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 8 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" }
"#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD3 = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = (((_Color * tmpvar_2).xyz * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = tmpvar_2;
  c_3.w = c_4.w;
  c_3.xyz = c_4.xyz;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "metal " {
// Stats: 10 math
Keywords { "DIRECTIONAL" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 208
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
Matrix 128 [_World2Object]
Vector 192 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  half3 tmpvar_3;
  half4 tmpvar_4;
  tmpvar_4 = tmpvar_1;
  float4 v_5;
  v_5.x = _mtl_u._World2Object[0].x;
  v_5.y = _mtl_u._World2Object[1].x;
  v_5.z = _mtl_u._World2Object[2].x;
  v_5.w = _mtl_u._World2Object[3].x;
  float4 v_6;
  v_6.x = _mtl_u._World2Object[0].y;
  v_6.y = _mtl_u._World2Object[1].y;
  v_6.z = _mtl_u._World2Object[2].y;
  v_6.w = _mtl_u._World2Object[3].y;
  float4 v_7;
  v_7.x = _mtl_u._World2Object[0].z;
  v_7.y = _mtl_u._World2Object[1].z;
  v_7.z = _mtl_u._World2Object[2].z;
  v_7.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_8;
  tmpvar_8 = normalize(((
    (v_5.xyz * _mtl_i._glesNormal.x)
   + 
    (v_6.xyz * _mtl_i._glesNormal.y)
  ) + (v_7.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_8);
  tmpvar_3 = worldNormal_2;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  _mtl_o.xlv_TEXCOORD1 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_4;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
vec4 t0;
vec3 t1;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD1.xyz = vec3(t6) * t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
float t1;
vec3 t2;
bool tb2;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t1 = max(t1, 0.0);
    t2.xyz = t2.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(t1) * t2.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 20 math, 4 textures, 1 branches
Keywords { "SPOT" }
"#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD3 = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = xlv_TEXCOORD2;
  vec4 tmpvar_4;
  tmpvar_4 = (_LightMatrix0 * tmpvar_3);
  vec4 c_5;
  vec4 c_6;
  c_6.xyz = (((_Color * tmpvar_2).xyz * (_LightColor0.xyz * 
    ((float((tmpvar_4.z > 0.0)) * texture2D (_LightTexture0, ((tmpvar_4.xy / tmpvar_4.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (tmpvar_4.xyz, tmpvar_4.xyz))).w)
  )) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_6.w = tmpvar_2;
  c_5.w = c_6.w;
  c_5.xyz = c_6.xyz;
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "metal " {
// Stats: 10 math
Keywords { "SPOT" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 208
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
Matrix 128 [_World2Object]
Vector 192 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  half3 tmpvar_3;
  half4 tmpvar_4;
  tmpvar_4 = tmpvar_1;
  float4 v_5;
  v_5.x = _mtl_u._World2Object[0].x;
  v_5.y = _mtl_u._World2Object[1].x;
  v_5.z = _mtl_u._World2Object[2].x;
  v_5.w = _mtl_u._World2Object[3].x;
  float4 v_6;
  v_6.x = _mtl_u._World2Object[0].y;
  v_6.y = _mtl_u._World2Object[1].y;
  v_6.z = _mtl_u._World2Object[2].y;
  v_6.w = _mtl_u._World2Object[3].y;
  float4 v_7;
  v_7.x = _mtl_u._World2Object[0].z;
  v_7.y = _mtl_u._World2Object[1].z;
  v_7.z = _mtl_u._World2Object[2].z;
  v_7.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_8;
  tmpvar_8 = normalize(((
    (v_5.xyz * _mtl_i._glesNormal.x)
   + 
    (v_6.xyz * _mtl_i._glesNormal.y)
  ) + (v_7.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_8);
  tmpvar_3 = worldNormal_2;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  _mtl_o.xlv_TEXCOORD1 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_4;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
vec4 t0;
vec3 t1;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD1.xyz = vec3(t6) * t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
uniform  sampler2D _LightTexture0;
uniform  sampler2D _LightTextureB0;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
vec4 t2;
lowp vec4 t10_2;
vec2 t3;
lowp vec4 t10_3;
vec3 t4;
bool tb4;
float t13;
bool tb13;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb4 = t0<_AlphaCutoff;
    if((int(tb4) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t4.xyz = vec3(t0) * _Color.xyz;
    t1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    t13 = dot(t1.xyz, t1.xyz);
    t13 = inversesqrt(t13);
    t1.xyz = vec3(t13) * t1.xyz;
    t2 = vs_TEXCOORD2.yyyy * _LightMatrix0[1];
    t2 = _LightMatrix0[0] * vs_TEXCOORD2.xxxx + t2;
    t2 = _LightMatrix0[2] * vs_TEXCOORD2.zzzz + t2;
    t2 = t2 + _LightMatrix0[3];
    tb13 = 0.0<t2.z;
    t13 = tb13 ? 1.0 : float(0.0);
    t3.xy = t2.xy / t2.ww;
    t3.xy = t3.xy + vec2(0.5, 0.5);
    t10_3 = texture(_LightTexture0, t3.xy);
    t13 = t13 * t10_3.w;
    t2.x = dot(t2.xyz, t2.xyz);
    t10_2 = texture(_LightTextureB0, t2.xx);
    t13 = t13 * t10_2.w;
    t2.xyz = vec3(t13) * _LightColor0.xyz;
    t1.x = dot(vs_TEXCOORD1.xyz, t1.xyz);
    t1.x = max(t1.x, 0.0);
    t4.xyz = t4.xyz * t2.xyz;
    SV_Target0.xyz = t1.xxx * t4.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 15 math, 4 textures, 1 branches
Keywords { "POINT_COOKIE" }
"#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD3 = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform samplerCube _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_4;
  tmpvar_4 = (_LightMatrix0 * tmpvar_3).xyz;
  vec4 c_5;
  vec4 c_6;
  c_6.xyz = (((_Color * tmpvar_2).xyz * (_LightColor0.xyz * 
    (texture2D (_LightTextureB0, vec2(dot (tmpvar_4, tmpvar_4))).w * textureCube (_LightTexture0, tmpvar_4).w)
  )) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_6.w = tmpvar_2;
  c_5.w = c_6.w;
  c_5.xyz = c_6.xyz;
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "metal " {
// Stats: 10 math
Keywords { "POINT_COOKIE" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 208
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
Matrix 128 [_World2Object]
Vector 192 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  half3 tmpvar_3;
  half4 tmpvar_4;
  tmpvar_4 = tmpvar_1;
  float4 v_5;
  v_5.x = _mtl_u._World2Object[0].x;
  v_5.y = _mtl_u._World2Object[1].x;
  v_5.z = _mtl_u._World2Object[2].x;
  v_5.w = _mtl_u._World2Object[3].x;
  float4 v_6;
  v_6.x = _mtl_u._World2Object[0].y;
  v_6.y = _mtl_u._World2Object[1].y;
  v_6.z = _mtl_u._World2Object[2].y;
  v_6.w = _mtl_u._World2Object[3].y;
  float4 v_7;
  v_7.x = _mtl_u._World2Object[0].z;
  v_7.y = _mtl_u._World2Object[1].z;
  v_7.z = _mtl_u._World2Object[2].z;
  v_7.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_8;
  tmpvar_8 = normalize(((
    (v_5.xyz * _mtl_i._glesNormal.x)
   + 
    (v_6.xyz * _mtl_i._glesNormal.y)
  ) + (v_7.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_8);
  tmpvar_3 = worldNormal_2;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  _mtl_o.xlv_TEXCOORD1 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_4;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
vec4 t0;
vec3 t1;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD1.xyz = vec3(t6) * t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
uniform  sampler2D _LightTextureB0;
uniform  samplerCube _LightTexture0;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
vec3 t2;
lowp vec4 t10_2;
lowp vec4 t10_3;
vec3 t4;
bool tb4;
float t13;
mediump float t16_13;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb4 = t0<_AlphaCutoff;
    if((int(tb4) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t4.xyz = vec3(t0) * _Color.xyz;
    t1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    t13 = dot(t1.xyz, t1.xyz);
    t13 = inversesqrt(t13);
    t1.xyz = vec3(t13) * t1.xyz;
    t2.xyz = vs_TEXCOORD2.yyy * _LightMatrix0[1].xyz;
    t2.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD2.xxx + t2.xyz;
    t2.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD2.zzz + t2.xyz;
    t2.xyz = t2.xyz + _LightMatrix0[3].xyz;
    t13 = dot(t2.xyz, t2.xyz);
    t10_3 = texture(_LightTextureB0, vec2(t13));
    t10_2 = texture(_LightTexture0, t2.xyz);
    t16_13 = t10_2.w * t10_3.w;
    t2.xyz = vec3(t16_13) * _LightColor0.xyz;
    t1.x = dot(vs_TEXCOORD1.xyz, t1.xyz);
    t1.x = max(t1.x, 0.0);
    t4.xyz = t4.xyz * t2.xyz;
    SV_Target0.xyz = t1.xxx * t4.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 11 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL_COOKIE" }
"#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD3 = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = xlv_TEXCOORD2;
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = (((_Color * tmpvar_2).xyz * (_LightColor0.xyz * texture2D (_LightTexture0, 
    (_LightMatrix0 * tmpvar_3)
  .xy).w)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2;
  c_4.w = c_5.w;
  c_4.xyz = c_5.xyz;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "metal " {
// Stats: 10 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 208
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
Matrix 128 [_World2Object]
Vector 192 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  half3 tmpvar_3;
  half4 tmpvar_4;
  tmpvar_4 = tmpvar_1;
  float4 v_5;
  v_5.x = _mtl_u._World2Object[0].x;
  v_5.y = _mtl_u._World2Object[1].x;
  v_5.z = _mtl_u._World2Object[2].x;
  v_5.w = _mtl_u._World2Object[3].x;
  float4 v_6;
  v_6.x = _mtl_u._World2Object[0].y;
  v_6.y = _mtl_u._World2Object[1].y;
  v_6.z = _mtl_u._World2Object[2].y;
  v_6.w = _mtl_u._World2Object[3].y;
  float4 v_7;
  v_7.x = _mtl_u._World2Object[0].z;
  v_7.y = _mtl_u._World2Object[1].z;
  v_7.z = _mtl_u._World2Object[2].z;
  v_7.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_8;
  tmpvar_8 = normalize(((
    (v_5.xyz * _mtl_i._glesNormal.x)
   + 
    (v_6.xyz * _mtl_i._glesNormal.y)
  ) + (v_7.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_8);
  tmpvar_3 = worldNormal_2;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  _mtl_o.xlv_TEXCOORD1 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_4;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
vec4 t0;
vec3 t1;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD1.xyz = vec3(t6) * t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
uniform  sampler2D _LightTexture0;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
lowp vec4 t10_1;
vec3 t2;
bool tb2;
float t7;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1.xy = vs_TEXCOORD2.yy * _LightMatrix0[1].xy;
    t1.xy = _LightMatrix0[0].xy * vs_TEXCOORD2.xx + t1.xy;
    t1.xy = _LightMatrix0[2].xy * vs_TEXCOORD2.zz + t1.xy;
    t1.xy = t1.xy + _LightMatrix0[3].xy;
    t10_1 = texture(_LightTexture0, t1.xy);
    t1.xyz = t10_1.www * _LightColor0.xyz;
    t7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t7 = max(t7, 0.0);
    t2.xyz = t2.xyz * t1.xyz;
    SV_Target0.xyz = vec3(t7) * t2.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 14 math, 3 textures, 1 branches
Keywords { "POINT" "PIXELSNAP_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ScreenParams;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 pos_1;
  pos_1.zw = gl_Vertex.zw;
  vec2 tmpvar_2;
  tmpvar_2 = (_ScreenParams.xy * 0.5);
  pos_1.xy = ((floor(
    (((gl_Vertex.xy / gl_Vertex.w) * tmpvar_2) + vec2(0.5, 0.5))
  ) / tmpvar_2) * gl_Vertex.w);
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * pos_1);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * pos_1).xyz;
  xlv_TEXCOORD3 = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_4;
  tmpvar_4 = (_LightMatrix0 * tmpvar_3).xyz;
  vec4 c_5;
  vec4 c_6;
  c_6.xyz = (((_Color * tmpvar_2).xyz * (_LightColor0.xyz * texture2D (_LightTexture0, vec2(
    dot (tmpvar_4, tmpvar_4)
  )).w)) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_6.w = tmpvar_2;
  c_5.w = c_6.w;
  c_5.xyz = c_6.xyz;
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "metal " {
// Stats: 17 math
Keywords { "POINT" "PIXELSNAP_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 224
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Matrix 144 [_World2Object]
Vector 0 [_ScreenParams]
Vector 208 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderUniform {
  float4 _ScreenParams;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  half3 tmpvar_3;
  half4 tmpvar_4;
  float4 pos_5;
  pos_5.zw = _mtl_i._glesVertex.zw;
  float2 tmpvar_6;
  tmpvar_6 = (_mtl_u._ScreenParams.xy * 0.5);
  pos_5.xy = ((floor(
    (((_mtl_i._glesVertex.xy / _mtl_i._glesVertex.w) * tmpvar_6) + float2(0.5, 0.5))
  ) / tmpvar_6) * _mtl_i._glesVertex.w);
  tmpvar_4 = tmpvar_1;
  float4 v_7;
  v_7.x = _mtl_u._World2Object[0].x;
  v_7.y = _mtl_u._World2Object[1].x;
  v_7.z = _mtl_u._World2Object[2].x;
  v_7.w = _mtl_u._World2Object[3].x;
  float4 v_8;
  v_8.x = _mtl_u._World2Object[0].y;
  v_8.y = _mtl_u._World2Object[1].y;
  v_8.z = _mtl_u._World2Object[2].y;
  v_8.w = _mtl_u._World2Object[3].y;
  float4 v_9;
  v_9.x = _mtl_u._World2Object[0].z;
  v_9.y = _mtl_u._World2Object[1].z;
  v_9.z = _mtl_u._World2Object[2].z;
  v_9.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _mtl_i._glesNormal.x)
   + 
    (v_8.xyz * _mtl_i._glesNormal.y)
  ) + (v_9.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_10);
  tmpvar_3 = worldNormal_2;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * pos_5);
  _mtl_o.xlv_TEXCOORD0 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  _mtl_o.xlv_TEXCOORD1 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._Object2World * pos_5).xyz;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_4;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT" "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
vec3 t0;
vec4 t1;
vec3 t2;
vec3 t3;
vec2 t6;
void main()
{
    t0.xy = in_POSITION0.xy / in_POSITION0.ww;
    t6.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    t0.xy = t6.xy * t0.xy;
    t0.xy = roundEven(t0.xy);
    t0.xy = t0.xy / t6.xy;
    t0.xy = t0.xy * in_POSITION0.ww;
    t1 = t0.yyyy * glstate_matrix_mvp[1];
    t1 = glstate_matrix_mvp[0] * t0.xxxx + t1;
    t1 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t1;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t1.x = in_NORMAL0.x * _World2Object[0].x;
    t1.y = in_NORMAL0.x * _World2Object[1].x;
    t1.z = in_NORMAL0.x * _World2Object[2].x;
    t2.x = in_NORMAL0.y * _World2Object[0].y;
    t2.y = in_NORMAL0.y * _World2Object[1].y;
    t2.z = in_NORMAL0.y * _World2Object[2].y;
    t1.xyz = t1.xyz + t2.xyz;
    t2.x = in_NORMAL0.z * _World2Object[0].z;
    t2.y = in_NORMAL0.z * _World2Object[1].z;
    t2.z = in_NORMAL0.z * _World2Object[2].z;
    t1.xyz = t1.xyz + t2.xyz;
    t6.x = dot(t1.xyz, t1.xyz);
    t6.x = inversesqrt(t6.x);
    vs_TEXCOORD1.xyz = t6.xxx * t1.xyz;
    t3.xyz = t0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * t0.xxx + t3.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
uniform  sampler2D _LightTexture0;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
vec3 t2;
lowp vec4 t10_2;
vec3 t3;
bool tb3;
float t10;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb3 = t0<_AlphaCutoff;
    if((int(tb3) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t3.xyz = vec3(t0) * _Color.xyz;
    t1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    t10 = dot(t1.xyz, t1.xyz);
    t10 = inversesqrt(t10);
    t1.xyz = vec3(t10) * t1.xyz;
    t2.xyz = vs_TEXCOORD2.yyy * _LightMatrix0[1].xyz;
    t2.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD2.xxx + t2.xyz;
    t2.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD2.zzz + t2.xyz;
    t2.xyz = t2.xyz + _LightMatrix0[3].xyz;
    t10 = dot(t2.xyz, t2.xyz);
    t10_2 = texture(_LightTexture0, vec2(t10));
    t2.xyz = t10_2.www * _LightColor0.xyz;
    t1.x = dot(vs_TEXCOORD1.xyz, t1.xyz);
    t1.x = max(t1.x, 0.0);
    t3.xyz = t3.xyz * t2.xyz;
    SV_Target0.xyz = t1.xxx * t3.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 8 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" "PIXELSNAP_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ScreenParams;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 pos_1;
  pos_1.zw = gl_Vertex.zw;
  vec2 tmpvar_2;
  tmpvar_2 = (_ScreenParams.xy * 0.5);
  pos_1.xy = ((floor(
    (((gl_Vertex.xy / gl_Vertex.w) * tmpvar_2) + vec2(0.5, 0.5))
  ) / tmpvar_2) * gl_Vertex.w);
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * pos_1);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * pos_1).xyz;
  xlv_TEXCOORD3 = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = (((_Color * tmpvar_2).xyz * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = tmpvar_2;
  c_3.w = c_4.w;
  c_3.xyz = c_4.xyz;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "metal " {
// Stats: 17 math
Keywords { "DIRECTIONAL" "PIXELSNAP_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 224
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Matrix 144 [_World2Object]
Vector 0 [_ScreenParams]
Vector 208 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderUniform {
  float4 _ScreenParams;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  half3 tmpvar_3;
  half4 tmpvar_4;
  float4 pos_5;
  pos_5.zw = _mtl_i._glesVertex.zw;
  float2 tmpvar_6;
  tmpvar_6 = (_mtl_u._ScreenParams.xy * 0.5);
  pos_5.xy = ((floor(
    (((_mtl_i._glesVertex.xy / _mtl_i._glesVertex.w) * tmpvar_6) + float2(0.5, 0.5))
  ) / tmpvar_6) * _mtl_i._glesVertex.w);
  tmpvar_4 = tmpvar_1;
  float4 v_7;
  v_7.x = _mtl_u._World2Object[0].x;
  v_7.y = _mtl_u._World2Object[1].x;
  v_7.z = _mtl_u._World2Object[2].x;
  v_7.w = _mtl_u._World2Object[3].x;
  float4 v_8;
  v_8.x = _mtl_u._World2Object[0].y;
  v_8.y = _mtl_u._World2Object[1].y;
  v_8.z = _mtl_u._World2Object[2].y;
  v_8.w = _mtl_u._World2Object[3].y;
  float4 v_9;
  v_9.x = _mtl_u._World2Object[0].z;
  v_9.y = _mtl_u._World2Object[1].z;
  v_9.z = _mtl_u._World2Object[2].z;
  v_9.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _mtl_i._glesNormal.x)
   + 
    (v_8.xyz * _mtl_i._glesNormal.y)
  ) + (v_9.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_10);
  tmpvar_3 = worldNormal_2;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * pos_5);
  _mtl_o.xlv_TEXCOORD0 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  _mtl_o.xlv_TEXCOORD1 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._Object2World * pos_5).xyz;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_4;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
vec3 t0;
vec4 t1;
vec3 t2;
vec3 t3;
vec2 t6;
void main()
{
    t0.xy = in_POSITION0.xy / in_POSITION0.ww;
    t6.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    t0.xy = t6.xy * t0.xy;
    t0.xy = roundEven(t0.xy);
    t0.xy = t0.xy / t6.xy;
    t0.xy = t0.xy * in_POSITION0.ww;
    t1 = t0.yyyy * glstate_matrix_mvp[1];
    t1 = glstate_matrix_mvp[0] * t0.xxxx + t1;
    t1 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t1;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t1.x = in_NORMAL0.x * _World2Object[0].x;
    t1.y = in_NORMAL0.x * _World2Object[1].x;
    t1.z = in_NORMAL0.x * _World2Object[2].x;
    t2.x = in_NORMAL0.y * _World2Object[0].y;
    t2.y = in_NORMAL0.y * _World2Object[1].y;
    t2.z = in_NORMAL0.y * _World2Object[2].y;
    t1.xyz = t1.xyz + t2.xyz;
    t2.x = in_NORMAL0.z * _World2Object[0].z;
    t2.y = in_NORMAL0.z * _World2Object[1].z;
    t2.z = in_NORMAL0.z * _World2Object[2].z;
    t1.xyz = t1.xyz + t2.xyz;
    t6.x = dot(t1.xyz, t1.xyz);
    t6.x = inversesqrt(t6.x);
    vs_TEXCOORD1.xyz = t6.xxx * t1.xyz;
    t3.xyz = t0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * t0.xxx + t3.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
float t1;
vec3 t2;
bool tb2;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t1 = max(t1, 0.0);
    t2.xyz = t2.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(t1) * t2.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 20 math, 4 textures, 1 branches
Keywords { "SPOT" "PIXELSNAP_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ScreenParams;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 pos_1;
  pos_1.zw = gl_Vertex.zw;
  vec2 tmpvar_2;
  tmpvar_2 = (_ScreenParams.xy * 0.5);
  pos_1.xy = ((floor(
    (((gl_Vertex.xy / gl_Vertex.w) * tmpvar_2) + vec2(0.5, 0.5))
  ) / tmpvar_2) * gl_Vertex.w);
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * pos_1);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * pos_1).xyz;
  xlv_TEXCOORD3 = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = xlv_TEXCOORD2;
  vec4 tmpvar_4;
  tmpvar_4 = (_LightMatrix0 * tmpvar_3);
  vec4 c_5;
  vec4 c_6;
  c_6.xyz = (((_Color * tmpvar_2).xyz * (_LightColor0.xyz * 
    ((float((tmpvar_4.z > 0.0)) * texture2D (_LightTexture0, ((tmpvar_4.xy / tmpvar_4.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (tmpvar_4.xyz, tmpvar_4.xyz))).w)
  )) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_6.w = tmpvar_2;
  c_5.w = c_6.w;
  c_5.xyz = c_6.xyz;
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "metal " {
// Stats: 17 math
Keywords { "SPOT" "PIXELSNAP_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 224
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Matrix 144 [_World2Object]
Vector 0 [_ScreenParams]
Vector 208 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderUniform {
  float4 _ScreenParams;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  half3 tmpvar_3;
  half4 tmpvar_4;
  float4 pos_5;
  pos_5.zw = _mtl_i._glesVertex.zw;
  float2 tmpvar_6;
  tmpvar_6 = (_mtl_u._ScreenParams.xy * 0.5);
  pos_5.xy = ((floor(
    (((_mtl_i._glesVertex.xy / _mtl_i._glesVertex.w) * tmpvar_6) + float2(0.5, 0.5))
  ) / tmpvar_6) * _mtl_i._glesVertex.w);
  tmpvar_4 = tmpvar_1;
  float4 v_7;
  v_7.x = _mtl_u._World2Object[0].x;
  v_7.y = _mtl_u._World2Object[1].x;
  v_7.z = _mtl_u._World2Object[2].x;
  v_7.w = _mtl_u._World2Object[3].x;
  float4 v_8;
  v_8.x = _mtl_u._World2Object[0].y;
  v_8.y = _mtl_u._World2Object[1].y;
  v_8.z = _mtl_u._World2Object[2].y;
  v_8.w = _mtl_u._World2Object[3].y;
  float4 v_9;
  v_9.x = _mtl_u._World2Object[0].z;
  v_9.y = _mtl_u._World2Object[1].z;
  v_9.z = _mtl_u._World2Object[2].z;
  v_9.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _mtl_i._glesNormal.x)
   + 
    (v_8.xyz * _mtl_i._glesNormal.y)
  ) + (v_9.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_10);
  tmpvar_3 = worldNormal_2;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * pos_5);
  _mtl_o.xlv_TEXCOORD0 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  _mtl_o.xlv_TEXCOORD1 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._Object2World * pos_5).xyz;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_4;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "SPOT" "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
vec3 t0;
vec4 t1;
vec3 t2;
vec3 t3;
vec2 t6;
void main()
{
    t0.xy = in_POSITION0.xy / in_POSITION0.ww;
    t6.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    t0.xy = t6.xy * t0.xy;
    t0.xy = roundEven(t0.xy);
    t0.xy = t0.xy / t6.xy;
    t0.xy = t0.xy * in_POSITION0.ww;
    t1 = t0.yyyy * glstate_matrix_mvp[1];
    t1 = glstate_matrix_mvp[0] * t0.xxxx + t1;
    t1 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t1;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t1.x = in_NORMAL0.x * _World2Object[0].x;
    t1.y = in_NORMAL0.x * _World2Object[1].x;
    t1.z = in_NORMAL0.x * _World2Object[2].x;
    t2.x = in_NORMAL0.y * _World2Object[0].y;
    t2.y = in_NORMAL0.y * _World2Object[1].y;
    t2.z = in_NORMAL0.y * _World2Object[2].y;
    t1.xyz = t1.xyz + t2.xyz;
    t2.x = in_NORMAL0.z * _World2Object[0].z;
    t2.y = in_NORMAL0.z * _World2Object[1].z;
    t2.z = in_NORMAL0.z * _World2Object[2].z;
    t1.xyz = t1.xyz + t2.xyz;
    t6.x = dot(t1.xyz, t1.xyz);
    t6.x = inversesqrt(t6.x);
    vs_TEXCOORD1.xyz = t6.xxx * t1.xyz;
    t3.xyz = t0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * t0.xxx + t3.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
uniform  sampler2D _LightTexture0;
uniform  sampler2D _LightTextureB0;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
vec4 t2;
lowp vec4 t10_2;
vec2 t3;
lowp vec4 t10_3;
vec3 t4;
bool tb4;
float t13;
bool tb13;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb4 = t0<_AlphaCutoff;
    if((int(tb4) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t4.xyz = vec3(t0) * _Color.xyz;
    t1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    t13 = dot(t1.xyz, t1.xyz);
    t13 = inversesqrt(t13);
    t1.xyz = vec3(t13) * t1.xyz;
    t2 = vs_TEXCOORD2.yyyy * _LightMatrix0[1];
    t2 = _LightMatrix0[0] * vs_TEXCOORD2.xxxx + t2;
    t2 = _LightMatrix0[2] * vs_TEXCOORD2.zzzz + t2;
    t2 = t2 + _LightMatrix0[3];
    tb13 = 0.0<t2.z;
    t13 = tb13 ? 1.0 : float(0.0);
    t3.xy = t2.xy / t2.ww;
    t3.xy = t3.xy + vec2(0.5, 0.5);
    t10_3 = texture(_LightTexture0, t3.xy);
    t13 = t13 * t10_3.w;
    t2.x = dot(t2.xyz, t2.xyz);
    t10_2 = texture(_LightTextureB0, t2.xx);
    t13 = t13 * t10_2.w;
    t2.xyz = vec3(t13) * _LightColor0.xyz;
    t1.x = dot(vs_TEXCOORD1.xyz, t1.xyz);
    t1.x = max(t1.x, 0.0);
    t4.xyz = t4.xyz * t2.xyz;
    SV_Target0.xyz = t1.xxx * t4.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 15 math, 4 textures, 1 branches
Keywords { "POINT_COOKIE" "PIXELSNAP_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ScreenParams;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 pos_1;
  pos_1.zw = gl_Vertex.zw;
  vec2 tmpvar_2;
  tmpvar_2 = (_ScreenParams.xy * 0.5);
  pos_1.xy = ((floor(
    (((gl_Vertex.xy / gl_Vertex.w) * tmpvar_2) + vec2(0.5, 0.5))
  ) / tmpvar_2) * gl_Vertex.w);
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * pos_1);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * pos_1).xyz;
  xlv_TEXCOORD3 = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform samplerCube _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_4;
  tmpvar_4 = (_LightMatrix0 * tmpvar_3).xyz;
  vec4 c_5;
  vec4 c_6;
  c_6.xyz = (((_Color * tmpvar_2).xyz * (_LightColor0.xyz * 
    (texture2D (_LightTextureB0, vec2(dot (tmpvar_4, tmpvar_4))).w * textureCube (_LightTexture0, tmpvar_4).w)
  )) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_6.w = tmpvar_2;
  c_5.w = c_6.w;
  c_5.xyz = c_6.xyz;
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "metal " {
// Stats: 17 math
Keywords { "POINT_COOKIE" "PIXELSNAP_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 224
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Matrix 144 [_World2Object]
Vector 0 [_ScreenParams]
Vector 208 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderUniform {
  float4 _ScreenParams;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  half3 tmpvar_3;
  half4 tmpvar_4;
  float4 pos_5;
  pos_5.zw = _mtl_i._glesVertex.zw;
  float2 tmpvar_6;
  tmpvar_6 = (_mtl_u._ScreenParams.xy * 0.5);
  pos_5.xy = ((floor(
    (((_mtl_i._glesVertex.xy / _mtl_i._glesVertex.w) * tmpvar_6) + float2(0.5, 0.5))
  ) / tmpvar_6) * _mtl_i._glesVertex.w);
  tmpvar_4 = tmpvar_1;
  float4 v_7;
  v_7.x = _mtl_u._World2Object[0].x;
  v_7.y = _mtl_u._World2Object[1].x;
  v_7.z = _mtl_u._World2Object[2].x;
  v_7.w = _mtl_u._World2Object[3].x;
  float4 v_8;
  v_8.x = _mtl_u._World2Object[0].y;
  v_8.y = _mtl_u._World2Object[1].y;
  v_8.z = _mtl_u._World2Object[2].y;
  v_8.w = _mtl_u._World2Object[3].y;
  float4 v_9;
  v_9.x = _mtl_u._World2Object[0].z;
  v_9.y = _mtl_u._World2Object[1].z;
  v_9.z = _mtl_u._World2Object[2].z;
  v_9.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _mtl_i._glesNormal.x)
   + 
    (v_8.xyz * _mtl_i._glesNormal.y)
  ) + (v_9.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_10);
  tmpvar_3 = worldNormal_2;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * pos_5);
  _mtl_o.xlv_TEXCOORD0 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  _mtl_o.xlv_TEXCOORD1 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._Object2World * pos_5).xyz;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_4;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT_COOKIE" "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
vec3 t0;
vec4 t1;
vec3 t2;
vec3 t3;
vec2 t6;
void main()
{
    t0.xy = in_POSITION0.xy / in_POSITION0.ww;
    t6.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    t0.xy = t6.xy * t0.xy;
    t0.xy = roundEven(t0.xy);
    t0.xy = t0.xy / t6.xy;
    t0.xy = t0.xy * in_POSITION0.ww;
    t1 = t0.yyyy * glstate_matrix_mvp[1];
    t1 = glstate_matrix_mvp[0] * t0.xxxx + t1;
    t1 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t1;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t1.x = in_NORMAL0.x * _World2Object[0].x;
    t1.y = in_NORMAL0.x * _World2Object[1].x;
    t1.z = in_NORMAL0.x * _World2Object[2].x;
    t2.x = in_NORMAL0.y * _World2Object[0].y;
    t2.y = in_NORMAL0.y * _World2Object[1].y;
    t2.z = in_NORMAL0.y * _World2Object[2].y;
    t1.xyz = t1.xyz + t2.xyz;
    t2.x = in_NORMAL0.z * _World2Object[0].z;
    t2.y = in_NORMAL0.z * _World2Object[1].z;
    t2.z = in_NORMAL0.z * _World2Object[2].z;
    t1.xyz = t1.xyz + t2.xyz;
    t6.x = dot(t1.xyz, t1.xyz);
    t6.x = inversesqrt(t6.x);
    vs_TEXCOORD1.xyz = t6.xxx * t1.xyz;
    t3.xyz = t0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * t0.xxx + t3.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
uniform  sampler2D _LightTextureB0;
uniform  samplerCube _LightTexture0;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
vec3 t2;
lowp vec4 t10_2;
lowp vec4 t10_3;
vec3 t4;
bool tb4;
float t13;
mediump float t16_13;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb4 = t0<_AlphaCutoff;
    if((int(tb4) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t4.xyz = vec3(t0) * _Color.xyz;
    t1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    t13 = dot(t1.xyz, t1.xyz);
    t13 = inversesqrt(t13);
    t1.xyz = vec3(t13) * t1.xyz;
    t2.xyz = vs_TEXCOORD2.yyy * _LightMatrix0[1].xyz;
    t2.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD2.xxx + t2.xyz;
    t2.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD2.zzz + t2.xyz;
    t2.xyz = t2.xyz + _LightMatrix0[3].xyz;
    t13 = dot(t2.xyz, t2.xyz);
    t10_3 = texture(_LightTextureB0, vec2(t13));
    t10_2 = texture(_LightTexture0, t2.xyz);
    t16_13 = t10_2.w * t10_3.w;
    t2.xyz = vec3(t16_13) * _LightColor0.xyz;
    t1.x = dot(vs_TEXCOORD1.xyz, t1.xyz);
    t1.x = max(t1.x, 0.0);
    t4.xyz = t4.xyz * t2.xyz;
    SV_Target0.xyz = t1.xxx * t4.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 11 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL_COOKIE" "PIXELSNAP_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ScreenParams;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 pos_1;
  pos_1.zw = gl_Vertex.zw;
  vec2 tmpvar_2;
  tmpvar_2 = (_ScreenParams.xy * 0.5);
  pos_1.xy = ((floor(
    (((gl_Vertex.xy / gl_Vertex.w) * tmpvar_2) + vec2(0.5, 0.5))
  ) / tmpvar_2) * gl_Vertex.w);
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * pos_1);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * pos_1).xyz;
  xlv_TEXCOORD3 = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_2;
  tmpvar_2 = (tmpvar_1.w * 1e+08);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = xlv_TEXCOORD2;
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = (((_Color * tmpvar_2).xyz * (_LightColor0.xyz * texture2D (_LightTexture0, 
    (_LightMatrix0 * tmpvar_3)
  .xy).w)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_5.w = tmpvar_2;
  c_4.w = c_5.w;
  c_4.xyz = c_5.xyz;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "metal " {
// Stats: 17 math
Keywords { "DIRECTIONAL_COOKIE" "PIXELSNAP_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 224
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Matrix 144 [_World2Object]
Vector 0 [_ScreenParams]
Vector 208 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderUniform {
  float4 _ScreenParams;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  half3 tmpvar_3;
  half4 tmpvar_4;
  float4 pos_5;
  pos_5.zw = _mtl_i._glesVertex.zw;
  float2 tmpvar_6;
  tmpvar_6 = (_mtl_u._ScreenParams.xy * 0.5);
  pos_5.xy = ((floor(
    (((_mtl_i._glesVertex.xy / _mtl_i._glesVertex.w) * tmpvar_6) + float2(0.5, 0.5))
  ) / tmpvar_6) * _mtl_i._glesVertex.w);
  tmpvar_4 = tmpvar_1;
  float4 v_7;
  v_7.x = _mtl_u._World2Object[0].x;
  v_7.y = _mtl_u._World2Object[1].x;
  v_7.z = _mtl_u._World2Object[2].x;
  v_7.w = _mtl_u._World2Object[3].x;
  float4 v_8;
  v_8.x = _mtl_u._World2Object[0].y;
  v_8.y = _mtl_u._World2Object[1].y;
  v_8.z = _mtl_u._World2Object[2].y;
  v_8.w = _mtl_u._World2Object[3].y;
  float4 v_9;
  v_9.x = _mtl_u._World2Object[0].z;
  v_9.y = _mtl_u._World2Object[1].z;
  v_9.z = _mtl_u._World2Object[2].z;
  v_9.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _mtl_i._glesNormal.x)
   + 
    (v_8.xyz * _mtl_i._glesNormal.y)
  ) + (v_9.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_10);
  tmpvar_3 = worldNormal_2;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * pos_5);
  _mtl_o.xlv_TEXCOORD0 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  _mtl_o.xlv_TEXCOORD1 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._Object2World * pos_5).xyz;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_4;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL_COOKIE" "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
vec3 t0;
vec4 t1;
vec3 t2;
vec3 t3;
vec2 t6;
void main()
{
    t0.xy = in_POSITION0.xy / in_POSITION0.ww;
    t6.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    t0.xy = t6.xy * t0.xy;
    t0.xy = roundEven(t0.xy);
    t0.xy = t0.xy / t6.xy;
    t0.xy = t0.xy * in_POSITION0.ww;
    t1 = t0.yyyy * glstate_matrix_mvp[1];
    t1 = glstate_matrix_mvp[0] * t0.xxxx + t1;
    t1 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t1;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t1.x = in_NORMAL0.x * _World2Object[0].x;
    t1.y = in_NORMAL0.x * _World2Object[1].x;
    t1.z = in_NORMAL0.x * _World2Object[2].x;
    t2.x = in_NORMAL0.y * _World2Object[0].y;
    t2.y = in_NORMAL0.y * _World2Object[1].y;
    t2.z = in_NORMAL0.y * _World2Object[2].y;
    t1.xyz = t1.xyz + t2.xyz;
    t2.x = in_NORMAL0.z * _World2Object[0].z;
    t2.y = in_NORMAL0.z * _World2Object[1].z;
    t2.z = in_NORMAL0.z * _World2Object[2].z;
    t1.xyz = t1.xyz + t2.xyz;
    t6.x = dot(t1.xyz, t1.xyz);
    t6.x = inversesqrt(t6.x);
    vs_TEXCOORD1.xyz = t6.xxx * t1.xyz;
    t3.xyz = t0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * t0.xxx + t3.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	mat4x4 _LightMatrix0;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
uniform  sampler2D _LightTexture0;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
lowp vec4 t10_1;
vec3 t2;
bool tb2;
float t7;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1.xy = vs_TEXCOORD2.yy * _LightMatrix0[1].xy;
    t1.xy = _LightMatrix0[0].xy * vs_TEXCOORD2.xx + t1.xy;
    t1.xy = _LightMatrix0[2].xy * vs_TEXCOORD2.zz + t1.xy;
    t1.xy = t1.xy + _LightMatrix0[3].xy;
    t10_1 = texture(_LightTexture0, t1.xy);
    t1.xyz = t10_1.www * _LightColor0.xyz;
    t7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    t7 = max(t7, 0.0);
    t2.xyz = t2.xyz * t1.xyz;
    SV_Target0.xyz = vec3(t7) * t2.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 14 math, 3 textures, 1 branches
Keywords { "POINT" }
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
ConstBuffer "$Globals" 68
MatrixHalf 24 [_LightMatrix0]
Vector 0 [_WorldSpaceLightPos0]
VectorHalf 16 [_LightColor0] 4
VectorHalf 56 [_Color] 4
Float 64 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4x4 _LightMatrix0;
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(0)]], sampler _mtlsmp__LightTexture0 [[sampler(0)]]
  ,   texture2d<half> _MainTex [[texture(1)]], sampler _mtlsmp__MainTex [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half3 tmpvar_1;
  half3 tmpvar_2;
  half3 tmpvar_3;
  half3 lightDir_4;
  half4 tmpvar_5;
  tmpvar_5 = _mtl_i.xlv_TEXCOORD3;
  float3 tmpvar_6;
  tmpvar_6 = normalize((_mtl_u._WorldSpaceLightPos0.xyz - _mtl_i.xlv_TEXCOORD2));
  lightDir_4 = half3(tmpvar_6);
  tmpvar_3 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_7;
  half tmpvar_8;
  float alpha_9;
  half4 tmpvar_10;
  tmpvar_10 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_5);
  if (((float)tmpvar_10.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_11;
  tmpvar_11 = (tmpvar_10.w * (half)1e+08);
  alpha_9 = float(tmpvar_11);
  float3 tmpvar_12;
  tmpvar_12 = ((float4)_mtl_u._Color * alpha_9).xyz;
  tmpvar_7 = half3(tmpvar_12);
  tmpvar_8 = half(alpha_9);
  float4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _mtl_i.xlv_TEXCOORD2;
  float3 tmpvar_14;
  tmpvar_14 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_13)).xyz;
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_14);
  half tmpvar_16;
  tmpvar_16 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(float2(tmpvar_15))).w;
  tmpvar_1 = _mtl_u._LightColor0.xyz;
  tmpvar_2 = lightDir_4;
  tmpvar_1 = (tmpvar_1 * tmpvar_16);
  half4 c_17;
  half4 c_18;
  half diff_19;
  half tmpvar_20;
  tmpvar_20 = max ((half)0.0, dot (tmpvar_3, tmpvar_2));
  diff_19 = tmpvar_20;
  c_18.xyz = ((tmpvar_7 * tmpvar_1) * diff_19);
  c_18.w = tmpvar_8;
  c_17.w = c_18.w;
  c_17.xyz = c_18.xyz;
  _mtl_o._glesFragData_0 = c_17;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 8 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 28
VectorHalf 0 [_WorldSpaceLightPos0] 4
VectorHalf 8 [_LightColor0] 4
VectorHalf 16 [_Color] 4
Float 24 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half3 tmpvar_1;
  half3 tmpvar_2;
  half3 tmpvar_3;
  half3 lightDir_4;
  half4 tmpvar_5;
  tmpvar_5 = _mtl_i.xlv_TEXCOORD3;
  half3 tmpvar_6;
  tmpvar_6 = _mtl_u._WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_3 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_7;
  half tmpvar_8;
  float alpha_9;
  half4 tmpvar_10;
  tmpvar_10 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_5);
  if (((float)tmpvar_10.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_11;
  tmpvar_11 = (tmpvar_10.w * (half)1e+08);
  alpha_9 = float(tmpvar_11);
  float3 tmpvar_12;
  tmpvar_12 = ((float4)_mtl_u._Color * alpha_9).xyz;
  tmpvar_7 = half3(tmpvar_12);
  tmpvar_8 = half(alpha_9);
  tmpvar_1 = _mtl_u._LightColor0.xyz;
  tmpvar_2 = lightDir_4;
  half4 c_13;
  half4 c_14;
  half diff_15;
  half tmpvar_16;
  tmpvar_16 = max ((half)0.0, dot (tmpvar_3, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = tmpvar_8;
  c_13.w = c_14.w;
  c_13.xyz = c_14.xyz;
  _mtl_o._glesFragData_0 = c_13;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "SPOT" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 20 math, 4 textures, 1 branches
Keywords { "SPOT" }
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 68
MatrixHalf 24 [_LightMatrix0]
Vector 0 [_WorldSpaceLightPos0]
VectorHalf 16 [_LightColor0] 4
VectorHalf 56 [_Color] 4
Float 64 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4x4 _LightMatrix0;
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(0)]], sampler _mtlsmp__LightTexture0 [[sampler(0)]]
  ,   texture2d<half> _LightTextureB0 [[texture(1)]], sampler _mtlsmp__LightTextureB0 [[sampler(1)]]
  ,   texture2d<half> _MainTex [[texture(2)]], sampler _mtlsmp__MainTex [[sampler(2)]])
{
  xlatMtlShaderOutput _mtl_o;
  half3 tmpvar_1;
  half3 tmpvar_2;
  half atten_3;
  half4 lightCoord_4;
  half3 tmpvar_5;
  half3 lightDir_6;
  half4 tmpvar_7;
  tmpvar_7 = _mtl_i.xlv_TEXCOORD3;
  float3 tmpvar_8;
  tmpvar_8 = normalize((_mtl_u._WorldSpaceLightPos0.xyz - _mtl_i.xlv_TEXCOORD2));
  lightDir_6 = half3(tmpvar_8);
  tmpvar_5 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_9;
  half tmpvar_10;
  float alpha_11;
  half4 tmpvar_12;
  tmpvar_12 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_7);
  if (((float)tmpvar_12.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_13;
  tmpvar_13 = (tmpvar_12.w * (half)1e+08);
  alpha_11 = float(tmpvar_13);
  float3 tmpvar_14;
  tmpvar_14 = ((float4)_mtl_u._Color * alpha_11).xyz;
  tmpvar_9 = half3(tmpvar_14);
  tmpvar_10 = half(alpha_11);
  float4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _mtl_i.xlv_TEXCOORD2;
  float4 tmpvar_16;
  tmpvar_16 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_15));
  lightCoord_4 = half4(tmpvar_16);
  half4 tmpvar_17;
  half2 P_18;
  P_18 = ((lightCoord_4.xy / lightCoord_4.w) + (half)0.5);
  tmpvar_17 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(P_18));
  float3 LightCoord_19;
  LightCoord_19 = float3(lightCoord_4.xyz);
  float tmpvar_20;
  tmpvar_20 = dot (LightCoord_19, LightCoord_19);
  half4 tmpvar_21;
  tmpvar_21 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_20)));
  half tmpvar_22;
  tmpvar_22 = ((half(
    (lightCoord_4.z > (half)0.0)
  ) * tmpvar_17.w) * tmpvar_21.w);
  atten_3 = tmpvar_22;
  tmpvar_1 = _mtl_u._LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_3);
  half4 c_23;
  half4 c_24;
  half diff_25;
  half tmpvar_26;
  tmpvar_26 = max ((half)0.0, dot (tmpvar_5, tmpvar_2));
  diff_25 = tmpvar_26;
  c_24.xyz = ((tmpvar_9 * tmpvar_1) * diff_25);
  c_24.w = tmpvar_10;
  c_23.w = c_24.w;
  c_23.xyz = c_24.xyz;
  _mtl_o._glesFragData_0 = c_23;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "SPOT" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 15 math, 4 textures, 1 branches
Keywords { "POINT_COOKIE" }
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 68
MatrixHalf 24 [_LightMatrix0]
Vector 0 [_WorldSpaceLightPos0]
VectorHalf 16 [_LightColor0] 4
VectorHalf 56 [_Color] 4
Float 64 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4x4 _LightMatrix0;
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texturecube<half> _LightTexture0 [[texture(0)]], sampler _mtlsmp__LightTexture0 [[sampler(0)]]
  ,   texture2d<half> _LightTextureB0 [[texture(1)]], sampler _mtlsmp__LightTextureB0 [[sampler(1)]]
  ,   texture2d<half> _MainTex [[texture(2)]], sampler _mtlsmp__MainTex [[sampler(2)]])
{
  xlatMtlShaderOutput _mtl_o;
  half3 tmpvar_1;
  half3 tmpvar_2;
  half3 tmpvar_3;
  half3 lightDir_4;
  half4 tmpvar_5;
  tmpvar_5 = _mtl_i.xlv_TEXCOORD3;
  float3 tmpvar_6;
  tmpvar_6 = normalize((_mtl_u._WorldSpaceLightPos0.xyz - _mtl_i.xlv_TEXCOORD2));
  lightDir_4 = half3(tmpvar_6);
  tmpvar_3 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_7;
  half tmpvar_8;
  float alpha_9;
  half4 tmpvar_10;
  tmpvar_10 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_5);
  if (((float)tmpvar_10.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_11;
  tmpvar_11 = (tmpvar_10.w * (half)1e+08);
  alpha_9 = float(tmpvar_11);
  float3 tmpvar_12;
  tmpvar_12 = ((float4)_mtl_u._Color * alpha_9).xyz;
  tmpvar_7 = half3(tmpvar_12);
  tmpvar_8 = half(alpha_9);
  float4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _mtl_i.xlv_TEXCOORD2;
  float3 tmpvar_14;
  tmpvar_14 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_13)).xyz;
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_14);
  half tmpvar_16;
  tmpvar_16 = (_LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_15))).w * _LightTexture0.sample(_mtlsmp__LightTexture0, (float3)(tmpvar_14)).w);
  tmpvar_1 = _mtl_u._LightColor0.xyz;
  tmpvar_2 = lightDir_4;
  tmpvar_1 = (tmpvar_1 * tmpvar_16);
  half4 c_17;
  half4 c_18;
  half diff_19;
  half tmpvar_20;
  tmpvar_20 = max ((half)0.0, dot (tmpvar_3, tmpvar_2));
  diff_19 = tmpvar_20;
  c_18.xyz = ((tmpvar_7 * tmpvar_1) * diff_19);
  c_18.w = tmpvar_8;
  c_17.w = c_18.w;
  c_17.xyz = c_18.xyz;
  _mtl_o._glesFragData_0 = c_17;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT_COOKIE" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 11 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
ConstBuffer "$Globals" 60
MatrixHalf 16 [_LightMatrix0]
VectorHalf 0 [_WorldSpaceLightPos0] 4
VectorHalf 8 [_LightColor0] 4
VectorHalf 48 [_Color] 4
Float 56 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4x4 _LightMatrix0;
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(0)]], sampler _mtlsmp__LightTexture0 [[sampler(0)]]
  ,   texture2d<half> _MainTex [[texture(1)]], sampler _mtlsmp__MainTex [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half3 tmpvar_1;
  half3 tmpvar_2;
  half3 tmpvar_3;
  half3 lightDir_4;
  half4 tmpvar_5;
  tmpvar_5 = _mtl_i.xlv_TEXCOORD3;
  half3 tmpvar_6;
  tmpvar_6 = _mtl_u._WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_3 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_7;
  half tmpvar_8;
  float alpha_9;
  half4 tmpvar_10;
  tmpvar_10 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_5);
  if (((float)tmpvar_10.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_11;
  tmpvar_11 = (tmpvar_10.w * (half)1e+08);
  alpha_9 = float(tmpvar_11);
  float3 tmpvar_12;
  tmpvar_12 = ((float4)_mtl_u._Color * alpha_9).xyz;
  tmpvar_7 = half3(tmpvar_12);
  tmpvar_8 = half(alpha_9);
  float4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _mtl_i.xlv_TEXCOORD2;
  float2 tmpvar_14;
  tmpvar_14 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_13)).xy;
  half tmpvar_15;
  tmpvar_15 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(tmpvar_14)).w;
  tmpvar_1 = _mtl_u._LightColor0.xyz;
  tmpvar_2 = lightDir_4;
  tmpvar_1 = (tmpvar_1 * tmpvar_15);
  half4 c_16;
  half4 c_17;
  half diff_18;
  half tmpvar_19;
  tmpvar_19 = max ((half)0.0, dot (tmpvar_3, tmpvar_2));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_7 * tmpvar_1) * diff_18);
  c_17.w = tmpvar_8;
  c_16.w = c_17.w;
  c_16.xyz = c_17.xyz;
  _mtl_o._glesFragData_0 = c_16;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL_COOKIE" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "POINT" "PIXELSNAP_ON" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 14 math, 3 textures, 1 branches
Keywords { "POINT" "PIXELSNAP_ON" }
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
ConstBuffer "$Globals" 68
MatrixHalf 24 [_LightMatrix0]
Vector 0 [_WorldSpaceLightPos0]
VectorHalf 16 [_LightColor0] 4
VectorHalf 56 [_Color] 4
Float 64 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4x4 _LightMatrix0;
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(0)]], sampler _mtlsmp__LightTexture0 [[sampler(0)]]
  ,   texture2d<half> _MainTex [[texture(1)]], sampler _mtlsmp__MainTex [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half3 tmpvar_1;
  half3 tmpvar_2;
  half3 tmpvar_3;
  half3 lightDir_4;
  half4 tmpvar_5;
  tmpvar_5 = _mtl_i.xlv_TEXCOORD3;
  float3 tmpvar_6;
  tmpvar_6 = normalize((_mtl_u._WorldSpaceLightPos0.xyz - _mtl_i.xlv_TEXCOORD2));
  lightDir_4 = half3(tmpvar_6);
  tmpvar_3 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_7;
  half tmpvar_8;
  float alpha_9;
  half4 tmpvar_10;
  tmpvar_10 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_5);
  if (((float)tmpvar_10.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_11;
  tmpvar_11 = (tmpvar_10.w * (half)1e+08);
  alpha_9 = float(tmpvar_11);
  float3 tmpvar_12;
  tmpvar_12 = ((float4)_mtl_u._Color * alpha_9).xyz;
  tmpvar_7 = half3(tmpvar_12);
  tmpvar_8 = half(alpha_9);
  float4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _mtl_i.xlv_TEXCOORD2;
  float3 tmpvar_14;
  tmpvar_14 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_13)).xyz;
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_14);
  half tmpvar_16;
  tmpvar_16 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(float2(tmpvar_15))).w;
  tmpvar_1 = _mtl_u._LightColor0.xyz;
  tmpvar_2 = lightDir_4;
  tmpvar_1 = (tmpvar_1 * tmpvar_16);
  half4 c_17;
  half4 c_18;
  half diff_19;
  half tmpvar_20;
  tmpvar_20 = max ((half)0.0, dot (tmpvar_3, tmpvar_2));
  diff_19 = tmpvar_20;
  c_18.xyz = ((tmpvar_7 * tmpvar_1) * diff_19);
  c_18.w = tmpvar_8;
  c_17.w = c_18.w;
  c_17.xyz = c_18.xyz;
  _mtl_o._glesFragData_0 = c_17;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT" "PIXELSNAP_ON" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "PIXELSNAP_ON" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 8 math, 2 textures, 1 branches
Keywords { "DIRECTIONAL" "PIXELSNAP_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 28
VectorHalf 0 [_WorldSpaceLightPos0] 4
VectorHalf 8 [_LightColor0] 4
VectorHalf 16 [_Color] 4
Float 24 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half3 tmpvar_1;
  half3 tmpvar_2;
  half3 tmpvar_3;
  half3 lightDir_4;
  half4 tmpvar_5;
  tmpvar_5 = _mtl_i.xlv_TEXCOORD3;
  half3 tmpvar_6;
  tmpvar_6 = _mtl_u._WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_3 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_7;
  half tmpvar_8;
  float alpha_9;
  half4 tmpvar_10;
  tmpvar_10 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_5);
  if (((float)tmpvar_10.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_11;
  tmpvar_11 = (tmpvar_10.w * (half)1e+08);
  alpha_9 = float(tmpvar_11);
  float3 tmpvar_12;
  tmpvar_12 = ((float4)_mtl_u._Color * alpha_9).xyz;
  tmpvar_7 = half3(tmpvar_12);
  tmpvar_8 = half(alpha_9);
  tmpvar_1 = _mtl_u._LightColor0.xyz;
  tmpvar_2 = lightDir_4;
  half4 c_13;
  half4 c_14;
  half diff_15;
  half tmpvar_16;
  tmpvar_16 = max ((half)0.0, dot (tmpvar_3, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = tmpvar_8;
  c_13.w = c_14.w;
  c_13.xyz = c_14.xyz;
  _mtl_o._glesFragData_0 = c_13;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL" "PIXELSNAP_ON" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "SPOT" "PIXELSNAP_ON" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 20 math, 4 textures, 1 branches
Keywords { "SPOT" "PIXELSNAP_ON" }
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 68
MatrixHalf 24 [_LightMatrix0]
Vector 0 [_WorldSpaceLightPos0]
VectorHalf 16 [_LightColor0] 4
VectorHalf 56 [_Color] 4
Float 64 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4x4 _LightMatrix0;
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(0)]], sampler _mtlsmp__LightTexture0 [[sampler(0)]]
  ,   texture2d<half> _LightTextureB0 [[texture(1)]], sampler _mtlsmp__LightTextureB0 [[sampler(1)]]
  ,   texture2d<half> _MainTex [[texture(2)]], sampler _mtlsmp__MainTex [[sampler(2)]])
{
  xlatMtlShaderOutput _mtl_o;
  half3 tmpvar_1;
  half3 tmpvar_2;
  half atten_3;
  half4 lightCoord_4;
  half3 tmpvar_5;
  half3 lightDir_6;
  half4 tmpvar_7;
  tmpvar_7 = _mtl_i.xlv_TEXCOORD3;
  float3 tmpvar_8;
  tmpvar_8 = normalize((_mtl_u._WorldSpaceLightPos0.xyz - _mtl_i.xlv_TEXCOORD2));
  lightDir_6 = half3(tmpvar_8);
  tmpvar_5 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_9;
  half tmpvar_10;
  float alpha_11;
  half4 tmpvar_12;
  tmpvar_12 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_7);
  if (((float)tmpvar_12.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_13;
  tmpvar_13 = (tmpvar_12.w * (half)1e+08);
  alpha_11 = float(tmpvar_13);
  float3 tmpvar_14;
  tmpvar_14 = ((float4)_mtl_u._Color * alpha_11).xyz;
  tmpvar_9 = half3(tmpvar_14);
  tmpvar_10 = half(alpha_11);
  float4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _mtl_i.xlv_TEXCOORD2;
  float4 tmpvar_16;
  tmpvar_16 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_15));
  lightCoord_4 = half4(tmpvar_16);
  half4 tmpvar_17;
  half2 P_18;
  P_18 = ((lightCoord_4.xy / lightCoord_4.w) + (half)0.5);
  tmpvar_17 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(P_18));
  float3 LightCoord_19;
  LightCoord_19 = float3(lightCoord_4.xyz);
  float tmpvar_20;
  tmpvar_20 = dot (LightCoord_19, LightCoord_19);
  half4 tmpvar_21;
  tmpvar_21 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_20)));
  half tmpvar_22;
  tmpvar_22 = ((half(
    (lightCoord_4.z > (half)0.0)
  ) * tmpvar_17.w) * tmpvar_21.w);
  atten_3 = tmpvar_22;
  tmpvar_1 = _mtl_u._LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_3);
  half4 c_23;
  half4 c_24;
  half diff_25;
  half tmpvar_26;
  tmpvar_26 = max ((half)0.0, dot (tmpvar_5, tmpvar_2));
  diff_25 = tmpvar_26;
  c_24.xyz = ((tmpvar_9 * tmpvar_1) * diff_25);
  c_24.w = tmpvar_10;
  c_23.w = c_24.w;
  c_23.xyz = c_24.xyz;
  _mtl_o._glesFragData_0 = c_23;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "SPOT" "PIXELSNAP_ON" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "PIXELSNAP_ON" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 15 math, 4 textures, 1 branches
Keywords { "POINT_COOKIE" "PIXELSNAP_ON" }
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 68
MatrixHalf 24 [_LightMatrix0]
Vector 0 [_WorldSpaceLightPos0]
VectorHalf 16 [_LightColor0] 4
VectorHalf 56 [_Color] 4
Float 64 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4x4 _LightMatrix0;
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texturecube<half> _LightTexture0 [[texture(0)]], sampler _mtlsmp__LightTexture0 [[sampler(0)]]
  ,   texture2d<half> _LightTextureB0 [[texture(1)]], sampler _mtlsmp__LightTextureB0 [[sampler(1)]]
  ,   texture2d<half> _MainTex [[texture(2)]], sampler _mtlsmp__MainTex [[sampler(2)]])
{
  xlatMtlShaderOutput _mtl_o;
  half3 tmpvar_1;
  half3 tmpvar_2;
  half3 tmpvar_3;
  half3 lightDir_4;
  half4 tmpvar_5;
  tmpvar_5 = _mtl_i.xlv_TEXCOORD3;
  float3 tmpvar_6;
  tmpvar_6 = normalize((_mtl_u._WorldSpaceLightPos0.xyz - _mtl_i.xlv_TEXCOORD2));
  lightDir_4 = half3(tmpvar_6);
  tmpvar_3 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_7;
  half tmpvar_8;
  float alpha_9;
  half4 tmpvar_10;
  tmpvar_10 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_5);
  if (((float)tmpvar_10.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_11;
  tmpvar_11 = (tmpvar_10.w * (half)1e+08);
  alpha_9 = float(tmpvar_11);
  float3 tmpvar_12;
  tmpvar_12 = ((float4)_mtl_u._Color * alpha_9).xyz;
  tmpvar_7 = half3(tmpvar_12);
  tmpvar_8 = half(alpha_9);
  float4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _mtl_i.xlv_TEXCOORD2;
  float3 tmpvar_14;
  tmpvar_14 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_13)).xyz;
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_14);
  half tmpvar_16;
  tmpvar_16 = (_LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_15))).w * _LightTexture0.sample(_mtlsmp__LightTexture0, (float3)(tmpvar_14)).w);
  tmpvar_1 = _mtl_u._LightColor0.xyz;
  tmpvar_2 = lightDir_4;
  tmpvar_1 = (tmpvar_1 * tmpvar_16);
  half4 c_17;
  half4 c_18;
  half diff_19;
  half tmpvar_20;
  tmpvar_20 = max ((half)0.0, dot (tmpvar_3, tmpvar_2));
  diff_19 = tmpvar_20;
  c_18.xyz = ((tmpvar_7 * tmpvar_1) * diff_19);
  c_18.w = tmpvar_8;
  c_17.w = c_18.w;
  c_17.xyz = c_18.xyz;
  _mtl_o._glesFragData_0 = c_17;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "POINT_COOKIE" "PIXELSNAP_ON" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "PIXELSNAP_ON" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 11 math, 3 textures, 1 branches
Keywords { "DIRECTIONAL_COOKIE" "PIXELSNAP_ON" }
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
ConstBuffer "$Globals" 60
MatrixHalf 16 [_LightMatrix0]
VectorHalf 0 [_WorldSpaceLightPos0] 4
VectorHalf 8 [_LightColor0] 4
VectorHalf 48 [_Color] 4
Float 56 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _WorldSpaceLightPos0;
  half4 _LightColor0;
  half4x4 _LightMatrix0;
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _LightTexture0 [[texture(0)]], sampler _mtlsmp__LightTexture0 [[sampler(0)]]
  ,   texture2d<half> _MainTex [[texture(1)]], sampler _mtlsmp__MainTex [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half3 tmpvar_1;
  half3 tmpvar_2;
  half3 tmpvar_3;
  half3 lightDir_4;
  half4 tmpvar_5;
  tmpvar_5 = _mtl_i.xlv_TEXCOORD3;
  half3 tmpvar_6;
  tmpvar_6 = _mtl_u._WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_3 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_7;
  half tmpvar_8;
  float alpha_9;
  half4 tmpvar_10;
  tmpvar_10 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_5);
  if (((float)tmpvar_10.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_11;
  tmpvar_11 = (tmpvar_10.w * (half)1e+08);
  alpha_9 = float(tmpvar_11);
  float3 tmpvar_12;
  tmpvar_12 = ((float4)_mtl_u._Color * alpha_9).xyz;
  tmpvar_7 = half3(tmpvar_12);
  tmpvar_8 = half(alpha_9);
  float4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _mtl_i.xlv_TEXCOORD2;
  float2 tmpvar_14;
  tmpvar_14 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_13)).xy;
  half tmpvar_15;
  tmpvar_15 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(tmpvar_14)).w;
  tmpvar_1 = _mtl_u._LightColor0.xyz;
  tmpvar_2 = lightDir_4;
  tmpvar_1 = (tmpvar_1 * tmpvar_15);
  half4 c_16;
  half4 c_17;
  half diff_18;
  half tmpvar_19;
  tmpvar_19 = max ((half)0.0, dot (tmpvar_3, tmpvar_2));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_7 * tmpvar_1) * diff_18);
  c_17.w = tmpvar_8;
  c_16.w = c_17.w;
  c_16.xyz = c_17.xyz;
  _mtl_o._glesFragData_0 = c_16;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "DIRECTIONAL_COOKIE" "PIXELSNAP_ON" }
"// shader disassembly not supported on glcore"
}
}
 }


 // Stats for Vertex shader:
 //       metal : 13 avg math (10..17)
 //      opengl : 5 math, 2 texture, 1 branch
 // Stats for Fragment shader:
 //       metal : 5 math, 2 texture, 1 branch
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="true" }
  ZWrite Off
  Cull Off
  Blend One OneMinusSrcAlpha
  GpuProgramID 168775
Program "vp" {
SubProgram "opengl " {
// Stats: 5 math, 2 textures, 1 branches
"#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD3 = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 res_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_2.w < _AlphaCutoff)) {
    discard;
  };
  res_1.xyz = ((xlv_TEXCOORD1 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "metal " {
// Stats: 10 math
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 208
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
Matrix 128 [_World2Object]
Vector 192 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  half3 tmpvar_3;
  half4 tmpvar_4;
  tmpvar_4 = tmpvar_1;
  float4 v_5;
  v_5.x = _mtl_u._World2Object[0].x;
  v_5.y = _mtl_u._World2Object[1].x;
  v_5.z = _mtl_u._World2Object[2].x;
  v_5.w = _mtl_u._World2Object[3].x;
  float4 v_6;
  v_6.x = _mtl_u._World2Object[0].y;
  v_6.y = _mtl_u._World2Object[1].y;
  v_6.z = _mtl_u._World2Object[2].y;
  v_6.w = _mtl_u._World2Object[3].y;
  float4 v_7;
  v_7.x = _mtl_u._World2Object[0].z;
  v_7.y = _mtl_u._World2Object[1].z;
  v_7.z = _mtl_u._World2Object[2].z;
  v_7.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_8;
  tmpvar_8 = normalize(((
    (v_5.xyz * _mtl_i._glesNormal.x)
   + 
    (v_6.xyz * _mtl_i._glesNormal.y)
  ) + (v_7.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_8);
  tmpvar_3 = worldNormal_2;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  _mtl_o.xlv_TEXCOORD1 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_4;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
vec4 t0;
vec3 t1;
float t6;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t6 = dot(t0.xyz, t0.xyz);
    t6 = inversesqrt(t6);
    vs_TEXCOORD1.xyz = vec3(t6) * t0.xyz;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
bool tb0;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb0 = t0<_AlphaCutoff;
    if((int(tb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 5 math, 2 textures, 1 branches
Keywords { "PIXELSNAP_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ScreenParams;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 pos_1;
  pos_1.zw = gl_Vertex.zw;
  vec2 tmpvar_2;
  tmpvar_2 = (_ScreenParams.xy * 0.5);
  pos_1.xy = ((floor(
    (((gl_Vertex.xy / gl_Vertex.w) * tmpvar_2) + vec2(0.5, 0.5))
  ) / tmpvar_2) * gl_Vertex.w);
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  gl_Position = (gl_ModelViewProjectionMatrix * pos_1);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * pos_1).xyz;
  xlv_TEXCOORD3 = gl_Color;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 res_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_2.w < _AlphaCutoff)) {
    discard;
  };
  res_1.xyz = ((xlv_TEXCOORD1 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "metal " {
// Stats: 17 math
Keywords { "PIXELSNAP_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 224
Matrix 16 [glstate_matrix_mvp]
Matrix 80 [_Object2World]
Matrix 144 [_World2Object]
Vector 0 [_ScreenParams]
Vector 208 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderUniform {
  float4 _ScreenParams;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  half3 tmpvar_3;
  half4 tmpvar_4;
  float4 pos_5;
  pos_5.zw = _mtl_i._glesVertex.zw;
  float2 tmpvar_6;
  tmpvar_6 = (_mtl_u._ScreenParams.xy * 0.5);
  pos_5.xy = ((floor(
    (((_mtl_i._glesVertex.xy / _mtl_i._glesVertex.w) * tmpvar_6) + float2(0.5, 0.5))
  ) / tmpvar_6) * _mtl_i._glesVertex.w);
  tmpvar_4 = tmpvar_1;
  float4 v_7;
  v_7.x = _mtl_u._World2Object[0].x;
  v_7.y = _mtl_u._World2Object[1].x;
  v_7.z = _mtl_u._World2Object[2].x;
  v_7.w = _mtl_u._World2Object[3].x;
  float4 v_8;
  v_8.x = _mtl_u._World2Object[0].y;
  v_8.y = _mtl_u._World2Object[1].y;
  v_8.z = _mtl_u._World2Object[2].y;
  v_8.w = _mtl_u._World2Object[3].y;
  float4 v_9;
  v_9.x = _mtl_u._World2Object[0].z;
  v_9.y = _mtl_u._World2Object[1].z;
  v_9.z = _mtl_u._World2Object[2].z;
  v_9.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _mtl_i._glesNormal.x)
   + 
    (v_8.xyz * _mtl_i._glesNormal.y)
  ) + (v_9.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_10);
  tmpvar_3 = worldNormal_2;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * pos_5);
  _mtl_o.xlv_TEXCOORD0 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  _mtl_o.xlv_TEXCOORD1 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD2 = (_mtl_u._Object2World * pos_5).xyz;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_4;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
vec3 t0;
vec4 t1;
vec3 t2;
vec3 t3;
vec2 t6;
void main()
{
    t0.xy = in_POSITION0.xy / in_POSITION0.ww;
    t6.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    t0.xy = t6.xy * t0.xy;
    t0.xy = roundEven(t0.xy);
    t0.xy = t0.xy / t6.xy;
    t0.xy = t0.xy * in_POSITION0.ww;
    t1 = t0.yyyy * glstate_matrix_mvp[1];
    t1 = glstate_matrix_mvp[0] * t0.xxxx + t1;
    t1 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t1;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t1.x = in_NORMAL0.x * _World2Object[0].x;
    t1.y = in_NORMAL0.x * _World2Object[1].x;
    t1.z = in_NORMAL0.x * _World2Object[2].x;
    t2.x = in_NORMAL0.y * _World2Object[0].y;
    t2.y = in_NORMAL0.y * _World2Object[1].y;
    t2.z = in_NORMAL0.y * _World2Object[2].y;
    t1.xyz = t1.xyz + t2.xyz;
    t2.x = in_NORMAL0.z * _World2Object[0].z;
    t2.y = in_NORMAL0.z * _World2Object[1].z;
    t2.z = in_NORMAL0.z * _World2Object[2].z;
    t1.xyz = t1.xyz + t2.xyz;
    t6.x = dot(t1.xyz, t1.xyz);
    t6.x = inversesqrt(t6.x);
    vs_TEXCOORD1.xyz = t6.xxx * t1.xyz;
    t3.xyz = t0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * t0.xxx + t3.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform  sampler2D _MainTex;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
bool tb0;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD3.w;
    tb0 = t0<_AlphaCutoff;
    if((int(tb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    return;
}
#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 5 math, 2 textures, 1 branches
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 4
Float 0 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 res_1;
  half3 tmpvar_2;
  half4 tmpvar_3;
  tmpvar_3 = _mtl_i.xlv_TEXCOORD3;
  tmpvar_2 = _mtl_i.xlv_TEXCOORD1;
  half4 tmpvar_4;
  tmpvar_4 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_3);
  if (((float)tmpvar_4.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  res_1.xyz = ((tmpvar_2 * (half)0.5) + (half)0.5);
  res_1.w = half(0.0);
  _mtl_o._glesFragData_0 = res_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 5 math, 2 textures, 1 branches
Keywords { "PIXELSNAP_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 4
Float 0 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD3;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 res_1;
  half3 tmpvar_2;
  half4 tmpvar_3;
  tmpvar_3 = _mtl_i.xlv_TEXCOORD3;
  tmpvar_2 = _mtl_i.xlv_TEXCOORD1;
  half4 tmpvar_4;
  tmpvar_4 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_3);
  if (((float)tmpvar_4.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  res_1.xyz = ((tmpvar_2 * (half)0.5) + (half)0.5);
  res_1.w = half(0.0);
  _mtl_o._glesFragData_0 = res_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "PIXELSNAP_ON" }
"// shader disassembly not supported on glcore"
}
}
 }


 // Stats for Vertex shader:
 //       metal : 38 avg math (35..42), 1 branch
 //      opengl : 7 avg math (6..8), 3 texture, 1 branch
 // Stats for Fragment shader:
 //       metal : 7 avg math (6..8), 3 texture, 1 branch
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="true" }
  ZWrite Off
  Cull Off
  Blend One OneMinusSrcAlpha
  GpuProgramID 258841
Program "vp" {
SubProgram "opengl " {
// Stats: 8 math, 3 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"#version 120

#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_1 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_1.zw;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  vec4 v_8;
  v_8.x = _World2Object[0].x;
  v_8.y = _World2Object[1].x;
  v_8.z = _World2Object[2].x;
  v_8.w = _World2Object[3].x;
  vec4 v_9;
  v_9.x = _World2Object[0].y;
  v_9.y = _World2Object[1].y;
  v_9.z = _World2Object[2].y;
  v_9.w = _World2Object[3].y;
  vec4 v_10;
  v_10.x = _World2Object[0].z;
  v_10.y = _World2Object[1].z;
  v_10.z = _World2Object[2].z;
  v_10.w = _World2Object[3].z;
  vec3 tmpvar_11;
  tmpvar_11 = normalize(((
    (v_8.xyz * gl_Normal.x)
   + 
    (v_9.xyz * gl_Normal.y)
  ) + (v_10.xyz * gl_Normal.z)));
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_11;
  vec3 res_13;
  vec3 x_14;
  x_14.x = dot (unity_SHAr, tmpvar_12);
  x_14.y = dot (unity_SHAg, tmpvar_12);
  x_14.z = dot (unity_SHAb, tmpvar_12);
  vec3 x1_15;
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_11.xyzz * tmpvar_11.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((tmpvar_11.x * tmpvar_11.x) - (tmpvar_11.y * tmpvar_11.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_13 = max (((1.055 * 
      pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = gl_Color;
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = res_13;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
uniform sampler2D _LightBuffer;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 light_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD2);
  if ((tmpvar_2.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_3;
  tmpvar_3 = (tmpvar_2.w * 1e+08);
  light_1 = -(log2(texture2DProj (_LightBuffer, xlv_TEXCOORD3)));
  light_1.xyz = (light_1.xyz + xlv_TEXCOORD5);
  vec4 c_4;
  c_4.xyz = ((_Color * tmpvar_3).xyz * light_1.xyz);
  c_4.w = tmpvar_3;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "metal " {
// Stats: 35 math, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 304
Matrix 80 [glstate_matrix_mvp]
Matrix 144 [_Object2World]
Matrix 208 [_World2Object]
Vector 0 [_ProjectionParams]
VectorHalf 16 [unity_SHAr] 4
VectorHalf 24 [unity_SHAg] 4
VectorHalf 32 [unity_SHAb] 4
VectorHalf 40 [unity_SHBr] 4
VectorHalf 48 [unity_SHBg] 4
VectorHalf 56 [unity_SHBb] 4
VectorHalf 64 [unity_SHC] 4
VectorHalf 272 [unity_ColorSpaceLuminance] 4
Vector 288 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float4 _ProjectionParams;
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float4 tmpvar_2;
  float2 tmpvar_3;
  half4 tmpvar_4;
  float4 tmpvar_5;
  float3 tmpvar_6;
  tmpvar_4 = tmpvar_1;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  tmpvar_3 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_7;
  tmpvar_7 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float4 o_8;
  float4 tmpvar_9;
  tmpvar_9 = (tmpvar_2 * 0.5);
  float2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _mtl_u._ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_2.zw;
  tmpvar_5.zw = float2(0.0, 0.0);
  tmpvar_5.xy = float2(0.0, 0.0);
  float4 v_11;
  v_11.x = _mtl_u._World2Object[0].x;
  v_11.y = _mtl_u._World2Object[1].x;
  v_11.z = _mtl_u._World2Object[2].x;
  v_11.w = _mtl_u._World2Object[3].x;
  float4 v_12;
  v_12.x = _mtl_u._World2Object[0].y;
  v_12.y = _mtl_u._World2Object[1].y;
  v_12.z = _mtl_u._World2Object[2].y;
  v_12.w = _mtl_u._World2Object[3].y;
  float4 v_13;
  v_13.x = _mtl_u._World2Object[0].z;
  v_13.y = _mtl_u._World2Object[1].z;
  v_13.z = _mtl_u._World2Object[2].z;
  v_13.w = _mtl_u._World2Object[3].z;
  float4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normalize(((
    (v_11.xyz * _mtl_i._glesNormal.x)
   + 
    (v_12.xyz * _mtl_i._glesNormal.y)
  ) + (v_13.xyz * _mtl_i._glesNormal.z)));
  half4 normal_15;
  normal_15 = half4(tmpvar_14);
  half3 res_16;
  half3 x_17;
  x_17.x = dot (_mtl_u.unity_SHAr, normal_15);
  x_17.y = dot (_mtl_u.unity_SHAg, normal_15);
  x_17.z = dot (_mtl_u.unity_SHAb, normal_15);
  half3 x1_18;
  half4 tmpvar_19;
  tmpvar_19 = (normal_15.xyzz * normal_15.yzzx);
  x1_18.x = dot (_mtl_u.unity_SHBr, tmpvar_19);
  x1_18.y = dot (_mtl_u.unity_SHBg, tmpvar_19);
  x1_18.z = dot (_mtl_u.unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (_mtl_u.unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  bool tmpvar_20;
  tmpvar_20 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_20) {
    res_16 = max ((((half)1.055 * 
      pow (max (res_16, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  tmpvar_6 = float3(res_16);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD3 = o_8;
  _mtl_o.xlv_TEXCOORD4 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD5 = tmpvar_6;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec4 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec4 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
vec4 t0;
vec4 t1;
vec4 t2;
vec3 t3;
float t12;
bool tb12;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD2 = in_COLOR0;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = t0.zw;
    vs_TEXCOORD3.xy = t1.zz + t1.xw;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    t1.x = t0.y * t0.y;
    t1.x = t0.x * t0.x + (-t1.x);
    t2 = t0.yzzx * t0.xyzz;
    t3.x = dot(unity_SHBr, t2);
    t3.y = dot(unity_SHBg, t2);
    t3.z = dot(unity_SHBb, t2);
    t1.xyz = unity_SHC.xyz * t1.xxx + t3.xyz;
    t0.w = 1.0;
    t2.x = dot(unity_SHAr, t0);
    t2.y = dot(unity_SHAg, t0);
    t2.z = dot(unity_SHAb, t0);
    t0.xyz = t1.xyz + t2.xyz;
    t1.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    t1.xyz = log2(t1.xyz);
    t1.xyz = t1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t1.xyz = exp2(t1.xyz);
    t1.xyz = t1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t1.xyz = max(t1.xyz, vec3(0.0, 0.0, 0.0));
    tb12 = unity_ColorSpaceLuminance.w==0.0;
    vs_TEXCOORD5.xyz = (bool(tb12)) ? t1.xyz : t0.xyz;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
uniform  sampler2D _MainTex;
uniform  sampler2D _LightBuffer;
in  vec2 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
mediump vec3 t16_1;
lowp vec4 t10_1;
vec3 t2;
bool tb2;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD2.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    t10_1 = texture(_LightBuffer, t1.xy);
    t16_1.xyz = log2(t10_1.xyz);
    t1.xyz = (-t16_1.xyz) + vs_TEXCOORD5.xyz;
    SV_Target0.xyz = t2.xyz * t1.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 6 math, 3 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_1 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_1.zw;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  vec4 v_8;
  v_8.x = _World2Object[0].x;
  v_8.y = _World2Object[1].x;
  v_8.z = _World2Object[2].x;
  v_8.w = _World2Object[3].x;
  vec4 v_9;
  v_9.x = _World2Object[0].y;
  v_9.y = _World2Object[1].y;
  v_9.z = _World2Object[2].y;
  v_9.w = _World2Object[3].y;
  vec4 v_10;
  v_10.x = _World2Object[0].z;
  v_10.y = _World2Object[1].z;
  v_10.z = _World2Object[2].z;
  v_10.w = _World2Object[3].z;
  vec3 tmpvar_11;
  tmpvar_11 = normalize(((
    (v_8.xyz * gl_Normal.x)
   + 
    (v_9.xyz * gl_Normal.y)
  ) + (v_10.xyz * gl_Normal.z)));
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_11;
  vec3 res_13;
  vec3 x_14;
  x_14.x = dot (unity_SHAr, tmpvar_12);
  x_14.y = dot (unity_SHAg, tmpvar_12);
  x_14.z = dot (unity_SHAb, tmpvar_12);
  vec3 x1_15;
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_11.xyzz * tmpvar_11.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((tmpvar_11.x * tmpvar_11.x) - (tmpvar_11.y * tmpvar_11.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_13 = max (((1.055 * 
      pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = gl_Color;
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = res_13;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
uniform sampler2D _LightBuffer;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 light_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD2);
  if ((tmpvar_2.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_3;
  tmpvar_3 = (tmpvar_2.w * 1e+08);
  vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_LightBuffer, xlv_TEXCOORD3);
  light_1.w = tmpvar_4.w;
  light_1.xyz = (tmpvar_4.xyz + xlv_TEXCOORD5);
  vec4 c_5;
  c_5.xyz = ((_Color * tmpvar_3).xyz * light_1.xyz);
  c_5.w = tmpvar_3;
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "metal " {
// Stats: 35 math, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 304
Matrix 80 [glstate_matrix_mvp]
Matrix 144 [_Object2World]
Matrix 208 [_World2Object]
Vector 0 [_ProjectionParams]
VectorHalf 16 [unity_SHAr] 4
VectorHalf 24 [unity_SHAg] 4
VectorHalf 32 [unity_SHAb] 4
VectorHalf 40 [unity_SHBr] 4
VectorHalf 48 [unity_SHBg] 4
VectorHalf 56 [unity_SHBb] 4
VectorHalf 64 [unity_SHC] 4
VectorHalf 272 [unity_ColorSpaceLuminance] 4
Vector 288 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float4 _ProjectionParams;
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float4 tmpvar_2;
  float2 tmpvar_3;
  half4 tmpvar_4;
  float4 tmpvar_5;
  float3 tmpvar_6;
  tmpvar_4 = tmpvar_1;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  tmpvar_3 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_7;
  tmpvar_7 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float4 o_8;
  float4 tmpvar_9;
  tmpvar_9 = (tmpvar_2 * 0.5);
  float2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _mtl_u._ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_2.zw;
  tmpvar_5.zw = float2(0.0, 0.0);
  tmpvar_5.xy = float2(0.0, 0.0);
  float4 v_11;
  v_11.x = _mtl_u._World2Object[0].x;
  v_11.y = _mtl_u._World2Object[1].x;
  v_11.z = _mtl_u._World2Object[2].x;
  v_11.w = _mtl_u._World2Object[3].x;
  float4 v_12;
  v_12.x = _mtl_u._World2Object[0].y;
  v_12.y = _mtl_u._World2Object[1].y;
  v_12.z = _mtl_u._World2Object[2].y;
  v_12.w = _mtl_u._World2Object[3].y;
  float4 v_13;
  v_13.x = _mtl_u._World2Object[0].z;
  v_13.y = _mtl_u._World2Object[1].z;
  v_13.z = _mtl_u._World2Object[2].z;
  v_13.w = _mtl_u._World2Object[3].z;
  float4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normalize(((
    (v_11.xyz * _mtl_i._glesNormal.x)
   + 
    (v_12.xyz * _mtl_i._glesNormal.y)
  ) + (v_13.xyz * _mtl_i._glesNormal.z)));
  half4 normal_15;
  normal_15 = half4(tmpvar_14);
  half3 res_16;
  half3 x_17;
  x_17.x = dot (_mtl_u.unity_SHAr, normal_15);
  x_17.y = dot (_mtl_u.unity_SHAg, normal_15);
  x_17.z = dot (_mtl_u.unity_SHAb, normal_15);
  half3 x1_18;
  half4 tmpvar_19;
  tmpvar_19 = (normal_15.xyzz * normal_15.yzzx);
  x1_18.x = dot (_mtl_u.unity_SHBr, tmpvar_19);
  x1_18.y = dot (_mtl_u.unity_SHBg, tmpvar_19);
  x1_18.z = dot (_mtl_u.unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (_mtl_u.unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  bool tmpvar_20;
  tmpvar_20 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_20) {
    res_16 = max ((((half)1.055 * 
      pow (max (res_16, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  tmpvar_6 = float3(res_16);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD3 = o_8;
  _mtl_o.xlv_TEXCOORD4 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD5 = tmpvar_6;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec4 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec4 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
vec4 t0;
vec4 t1;
vec4 t2;
vec3 t3;
float t12;
bool tb12;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD2 = in_COLOR0;
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = t0.zw;
    vs_TEXCOORD3.xy = t1.zz + t1.xw;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    t1.x = t0.y * t0.y;
    t1.x = t0.x * t0.x + (-t1.x);
    t2 = t0.yzzx * t0.xyzz;
    t3.x = dot(unity_SHBr, t2);
    t3.y = dot(unity_SHBg, t2);
    t3.z = dot(unity_SHBb, t2);
    t1.xyz = unity_SHC.xyz * t1.xxx + t3.xyz;
    t0.w = 1.0;
    t2.x = dot(unity_SHAr, t0);
    t2.y = dot(unity_SHAg, t0);
    t2.z = dot(unity_SHAb, t0);
    t0.xyz = t1.xyz + t2.xyz;
    t1.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    t1.xyz = log2(t1.xyz);
    t1.xyz = t1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t1.xyz = exp2(t1.xyz);
    t1.xyz = t1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t1.xyz = max(t1.xyz, vec3(0.0, 0.0, 0.0));
    tb12 = unity_ColorSpaceLuminance.w==0.0;
    vs_TEXCOORD5.xyz = (bool(tb12)) ? t1.xyz : t0.xyz;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
uniform  sampler2D _MainTex;
uniform  sampler2D _LightBuffer;
in  vec2 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
lowp vec4 t10_1;
vec3 t2;
bool tb2;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD2.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    t10_1 = texture(_LightBuffer, t1.xy);
    t1.xyz = t10_1.xyz + vs_TEXCOORD5.xyz;
    SV_Target0.xyz = t2.xyz * t1.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 8 math, 3 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"#version 120

#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 _ScreenParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  vec4 tmpvar_3;
  vec4 pos_4;
  pos_4.zw = gl_Vertex.zw;
  vec2 tmpvar_5;
  tmpvar_5 = (_ScreenParams.xy * 0.5);
  pos_4.xy = ((floor(
    (((gl_Vertex.xy / gl_Vertex.w) * tmpvar_5) + vec2(0.5, 0.5))
  ) / tmpvar_5) * gl_Vertex.w);
  tmpvar_1 = (gl_ModelViewProjectionMatrix * pos_4);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * pos_4).xyz;
  vec4 o_7;
  vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_1 * 0.5);
  vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_1.zw;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_13;
  vec3 res_15;
  vec3 x_16;
  x_16.x = dot (unity_SHAr, tmpvar_14);
  x_16.y = dot (unity_SHAg, tmpvar_14);
  x_16.z = dot (unity_SHAb, tmpvar_14);
  vec3 x1_17;
  vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_13.xyzz * tmpvar_13.yzzx);
  x1_17.x = dot (unity_SHBr, tmpvar_18);
  x1_17.y = dot (unity_SHBg, tmpvar_18);
  x1_17.z = dot (unity_SHBb, tmpvar_18);
  res_15 = (x_16 + (x1_17 + (unity_SHC.xyz * 
    ((tmpvar_13.x * tmpvar_13.x) - (tmpvar_13.y * tmpvar_13.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_15 = max (((1.055 * 
      pow (max (res_15, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = gl_Color;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = res_15;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
uniform sampler2D _LightBuffer;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 light_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD2);
  if ((tmpvar_2.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_3;
  tmpvar_3 = (tmpvar_2.w * 1e+08);
  light_1 = -(log2(texture2DProj (_LightBuffer, xlv_TEXCOORD3)));
  light_1.xyz = (light_1.xyz + xlv_TEXCOORD5);
  vec4 c_4;
  c_4.xyz = ((_Color * tmpvar_3).xyz * light_1.xyz);
  c_4.w = tmpvar_3;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "metal " {
// Stats: 42 math, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 320
Matrix 96 [glstate_matrix_mvp]
Matrix 160 [_Object2World]
Matrix 224 [_World2Object]
Vector 0 [_ProjectionParams]
Vector 16 [_ScreenParams]
VectorHalf 32 [unity_SHAr] 4
VectorHalf 40 [unity_SHAg] 4
VectorHalf 48 [unity_SHAb] 4
VectorHalf 56 [unity_SHBr] 4
VectorHalf 64 [unity_SHBg] 4
VectorHalf 72 [unity_SHBb] 4
VectorHalf 80 [unity_SHC] 4
VectorHalf 288 [unity_ColorSpaceLuminance] 4
Vector 304 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float4 _ProjectionParams;
  float4 _ScreenParams;
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float4 tmpvar_2;
  float2 tmpvar_3;
  half4 tmpvar_4;
  float4 tmpvar_5;
  float3 tmpvar_6;
  float4 pos_7;
  pos_7.zw = _mtl_i._glesVertex.zw;
  float2 tmpvar_8;
  tmpvar_8 = (_mtl_u._ScreenParams.xy * 0.5);
  pos_7.xy = ((floor(
    (((_mtl_i._glesVertex.xy / _mtl_i._glesVertex.w) * tmpvar_8) + float2(0.5, 0.5))
  ) / tmpvar_8) * _mtl_i._glesVertex.w);
  tmpvar_4 = tmpvar_1;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * pos_7);
  tmpvar_3 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_9;
  tmpvar_9 = (_mtl_u._Object2World * pos_7).xyz;
  float4 o_10;
  float4 tmpvar_11;
  tmpvar_11 = (tmpvar_2 * 0.5);
  float2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _mtl_u._ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_2.zw;
  tmpvar_5.zw = float2(0.0, 0.0);
  tmpvar_5.xy = float2(0.0, 0.0);
  float4 v_13;
  v_13.x = _mtl_u._World2Object[0].x;
  v_13.y = _mtl_u._World2Object[1].x;
  v_13.z = _mtl_u._World2Object[2].x;
  v_13.w = _mtl_u._World2Object[3].x;
  float4 v_14;
  v_14.x = _mtl_u._World2Object[0].y;
  v_14.y = _mtl_u._World2Object[1].y;
  v_14.z = _mtl_u._World2Object[2].y;
  v_14.w = _mtl_u._World2Object[3].y;
  float4 v_15;
  v_15.x = _mtl_u._World2Object[0].z;
  v_15.y = _mtl_u._World2Object[1].z;
  v_15.z = _mtl_u._World2Object[2].z;
  v_15.w = _mtl_u._World2Object[3].z;
  float4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = normalize(((
    (v_13.xyz * _mtl_i._glesNormal.x)
   + 
    (v_14.xyz * _mtl_i._glesNormal.y)
  ) + (v_15.xyz * _mtl_i._glesNormal.z)));
  half4 normal_17;
  normal_17 = half4(tmpvar_16);
  half3 res_18;
  half3 x_19;
  x_19.x = dot (_mtl_u.unity_SHAr, normal_17);
  x_19.y = dot (_mtl_u.unity_SHAg, normal_17);
  x_19.z = dot (_mtl_u.unity_SHAb, normal_17);
  half3 x1_20;
  half4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (_mtl_u.unity_SHBr, tmpvar_21);
  x1_20.y = dot (_mtl_u.unity_SHBg, tmpvar_21);
  x1_20.z = dot (_mtl_u.unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (_mtl_u.unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  bool tmpvar_22;
  tmpvar_22 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_22) {
    res_18 = max ((((half)1.055 * 
      pow (max (res_18, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  tmpvar_6 = float3(res_18);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_9;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD3 = o_10;
  _mtl_o.xlv_TEXCOORD4 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD5 = tmpvar_6;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec4 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec4 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
vec4 t0;
vec4 t1;
vec4 t2;
vec3 t3;
vec3 t4;
vec2 t8;
float t12;
bool tb12;
void main()
{
    t0.xy = in_POSITION0.xy / in_POSITION0.ww;
    t8.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    t0.xy = t8.xy * t0.xy;
    t0.xy = roundEven(t0.xy);
    t0.xy = t0.xy / t8.xy;
    t0.xy = t0.xy * in_POSITION0.ww;
    t1 = t0.yyyy * glstate_matrix_mvp[1];
    t1 = glstate_matrix_mvp[0] * t0.xxxx + t1;
    t1 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t1;
    t1 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t1;
    gl_Position = t1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t4.xyz = t0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * t0.xxx + t4.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD1.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD2 = in_COLOR0;
    t0.x = t1.y * _ProjectionParams.x;
    t0.w = t0.x * 0.5;
    t0.xz = t1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = t1.zw;
    vs_TEXCOORD3.xy = t0.zz + t0.xw;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    t1.x = t0.y * t0.y;
    t1.x = t0.x * t0.x + (-t1.x);
    t2 = t0.yzzx * t0.xyzz;
    t3.x = dot(unity_SHBr, t2);
    t3.y = dot(unity_SHBg, t2);
    t3.z = dot(unity_SHBb, t2);
    t1.xyz = unity_SHC.xyz * t1.xxx + t3.xyz;
    t0.w = 1.0;
    t2.x = dot(unity_SHAr, t0);
    t2.y = dot(unity_SHAg, t0);
    t2.z = dot(unity_SHAb, t0);
    t0.xyz = t1.xyz + t2.xyz;
    t1.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    t1.xyz = log2(t1.xyz);
    t1.xyz = t1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t1.xyz = exp2(t1.xyz);
    t1.xyz = t1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t1.xyz = max(t1.xyz, vec3(0.0, 0.0, 0.0));
    tb12 = unity_ColorSpaceLuminance.w==0.0;
    vs_TEXCOORD5.xyz = (bool(tb12)) ? t1.xyz : t0.xyz;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
uniform  sampler2D _MainTex;
uniform  sampler2D _LightBuffer;
in  vec2 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
mediump vec3 t16_1;
lowp vec4 t10_1;
vec3 t2;
bool tb2;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD2.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    t10_1 = texture(_LightBuffer, t1.xy);
    t16_1.xyz = log2(t10_1.xyz);
    t1.xyz = (-t16_1.xyz) + vs_TEXCOORD5.xyz;
    SV_Target0.xyz = t2.xyz * t1.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 6 math, 3 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" "PIXELSNAP_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 _ScreenParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  vec4 tmpvar_3;
  vec4 pos_4;
  pos_4.zw = gl_Vertex.zw;
  vec2 tmpvar_5;
  tmpvar_5 = (_ScreenParams.xy * 0.5);
  pos_4.xy = ((floor(
    (((gl_Vertex.xy / gl_Vertex.w) * tmpvar_5) + vec2(0.5, 0.5))
  ) / tmpvar_5) * gl_Vertex.w);
  tmpvar_1 = (gl_ModelViewProjectionMatrix * pos_4);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * pos_4).xyz;
  vec4 o_7;
  vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_1 * 0.5);
  vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_1.zw;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_13;
  vec3 res_15;
  vec3 x_16;
  x_16.x = dot (unity_SHAr, tmpvar_14);
  x_16.y = dot (unity_SHAg, tmpvar_14);
  x_16.z = dot (unity_SHAb, tmpvar_14);
  vec3 x1_17;
  vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_13.xyzz * tmpvar_13.yzzx);
  x1_17.x = dot (unity_SHBr, tmpvar_18);
  x1_17.y = dot (unity_SHBg, tmpvar_18);
  x1_17.z = dot (unity_SHBb, tmpvar_18);
  res_15 = (x_16 + (x1_17 + (unity_SHC.xyz * 
    ((tmpvar_13.x * tmpvar_13.x) - (tmpvar_13.y * tmpvar_13.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_15 = max (((1.055 * 
      pow (max (res_15, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = gl_Color;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = res_15;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
uniform sampler2D _LightBuffer;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 light_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD2);
  if ((tmpvar_2.w < _AlphaCutoff)) {
    discard;
  };
  float tmpvar_3;
  tmpvar_3 = (tmpvar_2.w * 1e+08);
  vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_LightBuffer, xlv_TEXCOORD3);
  light_1.w = tmpvar_4.w;
  light_1.xyz = (tmpvar_4.xyz + xlv_TEXCOORD5);
  vec4 c_5;
  c_5.xyz = ((_Color * tmpvar_3).xyz * light_1.xyz);
  c_5.w = tmpvar_3;
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "metal " {
// Stats: 42 math, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" "PIXELSNAP_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 320
Matrix 96 [glstate_matrix_mvp]
Matrix 160 [_Object2World]
Matrix 224 [_World2Object]
Vector 0 [_ProjectionParams]
Vector 16 [_ScreenParams]
VectorHalf 32 [unity_SHAr] 4
VectorHalf 40 [unity_SHAg] 4
VectorHalf 48 [unity_SHAb] 4
VectorHalf 56 [unity_SHBr] 4
VectorHalf 64 [unity_SHBg] 4
VectorHalf 72 [unity_SHBb] 4
VectorHalf 80 [unity_SHC] 4
VectorHalf 288 [unity_ColorSpaceLuminance] 4
Vector 304 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  float3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float4 _ProjectionParams;
  float4 _ScreenParams;
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  float4 tmpvar_2;
  float2 tmpvar_3;
  half4 tmpvar_4;
  float4 tmpvar_5;
  float3 tmpvar_6;
  float4 pos_7;
  pos_7.zw = _mtl_i._glesVertex.zw;
  float2 tmpvar_8;
  tmpvar_8 = (_mtl_u._ScreenParams.xy * 0.5);
  pos_7.xy = ((floor(
    (((_mtl_i._glesVertex.xy / _mtl_i._glesVertex.w) * tmpvar_8) + float2(0.5, 0.5))
  ) / tmpvar_8) * _mtl_i._glesVertex.w);
  tmpvar_4 = tmpvar_1;
  tmpvar_2 = (_mtl_u.glstate_matrix_mvp * pos_7);
  tmpvar_3 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_9;
  tmpvar_9 = (_mtl_u._Object2World * pos_7).xyz;
  float4 o_10;
  float4 tmpvar_11;
  tmpvar_11 = (tmpvar_2 * 0.5);
  float2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _mtl_u._ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_2.zw;
  tmpvar_5.zw = float2(0.0, 0.0);
  tmpvar_5.xy = float2(0.0, 0.0);
  float4 v_13;
  v_13.x = _mtl_u._World2Object[0].x;
  v_13.y = _mtl_u._World2Object[1].x;
  v_13.z = _mtl_u._World2Object[2].x;
  v_13.w = _mtl_u._World2Object[3].x;
  float4 v_14;
  v_14.x = _mtl_u._World2Object[0].y;
  v_14.y = _mtl_u._World2Object[1].y;
  v_14.z = _mtl_u._World2Object[2].y;
  v_14.w = _mtl_u._World2Object[3].y;
  float4 v_15;
  v_15.x = _mtl_u._World2Object[0].z;
  v_15.y = _mtl_u._World2Object[1].z;
  v_15.z = _mtl_u._World2Object[2].z;
  v_15.w = _mtl_u._World2Object[3].z;
  float4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = normalize(((
    (v_13.xyz * _mtl_i._glesNormal.x)
   + 
    (v_14.xyz * _mtl_i._glesNormal.y)
  ) + (v_15.xyz * _mtl_i._glesNormal.z)));
  half4 normal_17;
  normal_17 = half4(tmpvar_16);
  half3 res_18;
  half3 x_19;
  x_19.x = dot (_mtl_u.unity_SHAr, normal_17);
  x_19.y = dot (_mtl_u.unity_SHAg, normal_17);
  x_19.z = dot (_mtl_u.unity_SHAb, normal_17);
  half3 x1_20;
  half4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (_mtl_u.unity_SHBr, tmpvar_21);
  x1_20.y = dot (_mtl_u.unity_SHBg, tmpvar_21);
  x1_20.z = dot (_mtl_u.unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (_mtl_u.unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  bool tmpvar_22;
  tmpvar_22 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_22) {
    res_18 = max ((((half)1.055 * 
      pow (max (res_18, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  tmpvar_6 = float3(res_18);
  _mtl_o.gl_Position = tmpvar_2;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_9;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD3 = o_10;
  _mtl_o.xlv_TEXCOORD4 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD5 = tmpvar_6;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec4 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec4 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
vec4 t0;
vec4 t1;
vec4 t2;
vec3 t3;
vec3 t4;
vec2 t8;
float t12;
bool tb12;
void main()
{
    t0.xy = in_POSITION0.xy / in_POSITION0.ww;
    t8.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    t0.xy = t8.xy * t0.xy;
    t0.xy = roundEven(t0.xy);
    t0.xy = t0.xy / t8.xy;
    t0.xy = t0.xy * in_POSITION0.ww;
    t1 = t0.yyyy * glstate_matrix_mvp[1];
    t1 = glstate_matrix_mvp[0] * t0.xxxx + t1;
    t1 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t1;
    t1 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t1;
    gl_Position = t1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t4.xyz = t0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * t0.xxx + t4.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD1.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD2 = in_COLOR0;
    t0.x = t1.y * _ProjectionParams.x;
    t0.w = t0.x * 0.5;
    t0.xz = t1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = t1.zw;
    vs_TEXCOORD3.xy = t0.zz + t0.xw;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    t1.x = t0.y * t0.y;
    t1.x = t0.x * t0.x + (-t1.x);
    t2 = t0.yzzx * t0.xyzz;
    t3.x = dot(unity_SHBr, t2);
    t3.y = dot(unity_SHBg, t2);
    t3.z = dot(unity_SHBb, t2);
    t1.xyz = unity_SHC.xyz * t1.xxx + t3.xyz;
    t0.w = 1.0;
    t2.x = dot(unity_SHAr, t0);
    t2.y = dot(unity_SHAg, t0);
    t2.z = dot(unity_SHAb, t0);
    t0.xyz = t1.xyz + t2.xyz;
    t1.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    t1.xyz = log2(t1.xyz);
    t1.xyz = t1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t1.xyz = exp2(t1.xyz);
    t1.xyz = t1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t1.xyz = max(t1.xyz, vec3(0.0, 0.0, 0.0));
    tb12 = unity_ColorSpaceLuminance.w==0.0;
    vs_TEXCOORD5.xyz = (bool(tb12)) ? t1.xyz : t0.xyz;
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
uniform  sampler2D _MainTex;
uniform  sampler2D _LightBuffer;
in  vec2 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD2;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
float t0;
lowp vec4 t10_0;
vec3 t1;
lowp vec4 t10_1;
vec3 t2;
bool tb2;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0 = t10_0.w * vs_TEXCOORD2.w;
    tb2 = t0<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0 = t0 * 100000000.0;
    t2.xyz = vec3(t0) * _Color.xyz;
    t1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    t10_1 = texture(_LightBuffer, t1.xy);
    t1.xyz = t10_1.xyz + vs_TEXCOORD5.xyz;
    SV_Target0.xyz = t2.xyz * t1.xyz;
    SV_Target0.w = t0;
    return;
}
#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 8 math, 3 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 12
VectorHalf 0 [_Color] 4
Float 8 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half4 xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]]
  ,   texture2d<half> _LightBuffer [[texture(1)]], sampler _mtlsmp__LightBuffer [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 c_2;
  half4 light_3;
  half4 tmpvar_4;
  tmpvar_4 = _mtl_i.xlv_TEXCOORD2;
  half3 tmpvar_5;
  half tmpvar_6;
  float alpha_7;
  half4 tmpvar_8;
  tmpvar_8 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_4);
  if (((float)tmpvar_8.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_9;
  tmpvar_9 = (tmpvar_8.w * (half)1e+08);
  alpha_7 = float(tmpvar_9);
  float3 tmpvar_10;
  tmpvar_10 = ((float4)_mtl_u._Color * alpha_7).xyz;
  tmpvar_5 = half3(tmpvar_10);
  tmpvar_6 = half(alpha_7);
  half4 tmpvar_11;
  tmpvar_11 = _LightBuffer.sample(_mtlsmp__LightBuffer, ((float2)(_mtl_i.xlv_TEXCOORD3).xy / (float)(_mtl_i.xlv_TEXCOORD3).w));
  light_3 = tmpvar_11;
  light_3 = -(log2(light_3));
  light_3.xyz = half3(((float3)light_3.xyz + _mtl_i.xlv_TEXCOORD5));
  half4 c_12;
  c_12.xyz = (tmpvar_5 * light_3.xyz);
  c_12.w = tmpvar_6;
  c_2 = c_12;
  tmpvar_1 = c_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 6 math, 3 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 12
VectorHalf 0 [_Color] 4
Float 8 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half4 xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]]
  ,   texture2d<half> _LightBuffer [[texture(1)]], sampler _mtlsmp__LightBuffer [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 c_2;
  half4 light_3;
  half4 tmpvar_4;
  tmpvar_4 = _mtl_i.xlv_TEXCOORD2;
  half3 tmpvar_5;
  half tmpvar_6;
  float alpha_7;
  half4 tmpvar_8;
  tmpvar_8 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_4);
  if (((float)tmpvar_8.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_9;
  tmpvar_9 = (tmpvar_8.w * (half)1e+08);
  alpha_7 = float(tmpvar_9);
  float3 tmpvar_10;
  tmpvar_10 = ((float4)_mtl_u._Color * alpha_7).xyz;
  tmpvar_5 = half3(tmpvar_10);
  tmpvar_6 = half(alpha_7);
  half4 tmpvar_11;
  tmpvar_11 = _LightBuffer.sample(_mtlsmp__LightBuffer, ((float2)(_mtl_i.xlv_TEXCOORD3).xy / (float)(_mtl_i.xlv_TEXCOORD3).w));
  light_3 = tmpvar_11;
  light_3.xyz = half3(((float3)light_3.xyz + _mtl_i.xlv_TEXCOORD5));
  half4 c_12;
  c_12.xyz = (tmpvar_5 * light_3.xyz);
  c_12.w = tmpvar_6;
  c_2 = c_12;
  tmpvar_1 = c_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 8 math, 3 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 12
VectorHalf 0 [_Color] 4
Float 8 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half4 xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]]
  ,   texture2d<half> _LightBuffer [[texture(1)]], sampler _mtlsmp__LightBuffer [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 c_2;
  half4 light_3;
  half4 tmpvar_4;
  tmpvar_4 = _mtl_i.xlv_TEXCOORD2;
  half3 tmpvar_5;
  half tmpvar_6;
  float alpha_7;
  half4 tmpvar_8;
  tmpvar_8 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_4);
  if (((float)tmpvar_8.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_9;
  tmpvar_9 = (tmpvar_8.w * (half)1e+08);
  alpha_7 = float(tmpvar_9);
  float3 tmpvar_10;
  tmpvar_10 = ((float4)_mtl_u._Color * alpha_7).xyz;
  tmpvar_5 = half3(tmpvar_10);
  tmpvar_6 = half(alpha_7);
  half4 tmpvar_11;
  tmpvar_11 = _LightBuffer.sample(_mtlsmp__LightBuffer, ((float2)(_mtl_i.xlv_TEXCOORD3).xy / (float)(_mtl_i.xlv_TEXCOORD3).w));
  light_3 = tmpvar_11;
  light_3 = -(log2(light_3));
  light_3.xyz = half3(((float3)light_3.xyz + _mtl_i.xlv_TEXCOORD5));
  half4 c_12;
  c_12.xyz = (tmpvar_5 * light_3.xyz);
  c_12.w = tmpvar_6;
  c_2 = c_12;
  tmpvar_1 = c_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" "PIXELSNAP_ON" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 6 math, 3 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" "PIXELSNAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 12
VectorHalf 0 [_Color] 4
Float 8 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half4 xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]]
  ,   texture2d<half> _LightBuffer [[texture(1)]], sampler _mtlsmp__LightBuffer [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 c_2;
  half4 light_3;
  half4 tmpvar_4;
  tmpvar_4 = _mtl_i.xlv_TEXCOORD2;
  half3 tmpvar_5;
  half tmpvar_6;
  float alpha_7;
  half4 tmpvar_8;
  tmpvar_8 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_4);
  if (((float)tmpvar_8.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_9;
  tmpvar_9 = (tmpvar_8.w * (half)1e+08);
  alpha_7 = float(tmpvar_9);
  float3 tmpvar_10;
  tmpvar_10 = ((float4)_mtl_u._Color * alpha_7).xyz;
  tmpvar_5 = half3(tmpvar_10);
  tmpvar_6 = half(alpha_7);
  half4 tmpvar_11;
  tmpvar_11 = _LightBuffer.sample(_mtlsmp__LightBuffer, ((float2)(_mtl_i.xlv_TEXCOORD3).xy / (float)(_mtl_i.xlv_TEXCOORD3).w));
  light_3 = tmpvar_11;
  light_3.xyz = half3(((float3)light_3.xyz + _mtl_i.xlv_TEXCOORD5));
  half4 c_12;
  c_12.xyz = (tmpvar_5 * light_3.xyz);
  c_12.w = tmpvar_6;
  c_2 = c_12;
  tmpvar_1 = c_2;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" "PIXELSNAP_ON" }
"// shader disassembly not supported on glcore"
}
}
 }


 // Stats for Vertex shader:
 //       metal : 37 avg math (34..41), 1 branch
 //      opengl : 12 avg math (11..13), 2 texture, 1 branch
 // Stats for Fragment shader:
 //       metal : 14 avg math (13..15), 2 texture, 1 branch
 Pass {
  Name "DEFERRED"
  Tags { "LIGHTMODE"="Deferred" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="true" }
  ZWrite Off
  Cull Off
  Blend One OneMinusSrcAlpha
  GpuProgramID 291517
Program "vp" {
SubProgram "opengl " {
// Stats: 13 math, 2 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"#version 120

#ifdef VERTEX
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * gl_Vertex).xyz;
  vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * gl_Normal.x)
   + 
    (v_7.xyz * gl_Normal.y)
  ) + (v_8.xyz * gl_Normal.z)));
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_10;
  ambient_10 = tmpvar_4;
  vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_9;
  vec3 res_12;
  vec3 x_13;
  x_13.x = dot (unity_SHAr, tmpvar_11);
  x_13.y = dot (unity_SHAg, tmpvar_11);
  x_13.z = dot (unity_SHAb, tmpvar_11);
  vec3 x1_14;
  vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_9.xyzz * tmpvar_9.yzzx);
  x1_14.x = dot (unity_SHBr, tmpvar_15);
  x1_14.y = dot (unity_SHBg, tmpvar_15);
  x1_14.z = dot (unity_SHBb, tmpvar_15);
  res_12 = (x_13 + (x1_14 + (unity_SHC.xyz * 
    ((tmpvar_9.x * tmpvar_9.x) - (tmpvar_9.y * tmpvar_9.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_12 = max (((1.055 * 
      pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_10 = max (vec3(0.0, 0.0, 0.0), res_12);
  tmpvar_4 = ambient_10;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = gl_Color;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ambient_10;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 outEmission_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_2.w < _AlphaCutoff)) {
    discard;
  };
  vec3 tmpvar_3;
  tmpvar_3 = (_Color * (tmpvar_2.w * 1e+08)).xyz;
  vec4 emission_4;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = ((xlv_TEXCOORD1 * 0.5) + 0.5);
  emission_4.w = 1.0;
  emission_4.xyz = (tmpvar_3 * xlv_TEXCOORD5);
  outEmission_1.w = emission_4.w;
  outEmission_1.xyz = exp2(-(emission_4.xyz));
  gl_FragData[0] = tmpvar_5;
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
  gl_FragData[2] = tmpvar_6;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "metal " {
// Stats: 34 math, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 288
Matrix 64 [glstate_matrix_mvp]
Matrix 128 [_Object2World]
Matrix 192 [_World2Object]
VectorHalf 0 [unity_SHAr] 4
VectorHalf 8 [unity_SHAg] 4
VectorHalf 16 [unity_SHAb] 4
VectorHalf 24 [unity_SHBr] 4
VectorHalf 32 [unity_SHBg] 4
VectorHalf 40 [unity_SHBb] 4
VectorHalf 48 [unity_SHC] 4
VectorHalf 256 [unity_ColorSpaceLuminance] 4
Vector 272 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD4;
  half3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  float4 tmpvar_3;
  float2 tmpvar_4;
  half3 tmpvar_5;
  half4 tmpvar_6;
  float4 tmpvar_7;
  half3 tmpvar_8;
  tmpvar_6 = tmpvar_1;
  tmpvar_3 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  tmpvar_4 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_9;
  tmpvar_9 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float4 v_10;
  v_10.x = _mtl_u._World2Object[0].x;
  v_10.y = _mtl_u._World2Object[1].x;
  v_10.z = _mtl_u._World2Object[2].x;
  v_10.w = _mtl_u._World2Object[3].x;
  float4 v_11;
  v_11.x = _mtl_u._World2Object[0].y;
  v_11.y = _mtl_u._World2Object[1].y;
  v_11.z = _mtl_u._World2Object[2].y;
  v_11.w = _mtl_u._World2Object[3].y;
  float4 v_12;
  v_12.x = _mtl_u._World2Object[0].z;
  v_12.y = _mtl_u._World2Object[1].z;
  v_12.z = _mtl_u._World2Object[2].z;
  v_12.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * _mtl_i._glesNormal.x)
   + 
    (v_11.xyz * _mtl_i._glesNormal.y)
  ) + (v_12.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_13);
  tmpvar_5 = worldNormal_2;
  tmpvar_7.zw = float2(0.0, 0.0);
  tmpvar_7.xy = float2(0.0, 0.0);
  tmpvar_8 = half3(float3(0.0, 0.0, 0.0));
  half3 normal_14;
  normal_14 = worldNormal_2;
  half3 ambient_15;
  ambient_15 = tmpvar_8;
  half4 tmpvar_16;
  tmpvar_16.w = half(1.0);
  tmpvar_16.xyz = normal_14;
  half3 res_17;
  half3 x_18;
  x_18.x = dot (_mtl_u.unity_SHAr, tmpvar_16);
  x_18.y = dot (_mtl_u.unity_SHAg, tmpvar_16);
  x_18.z = dot (_mtl_u.unity_SHAb, tmpvar_16);
  half3 x1_19;
  half4 tmpvar_20;
  tmpvar_20 = (normal_14.xyzz * normal_14.yzzx);
  x1_19.x = dot (_mtl_u.unity_SHBr, tmpvar_20);
  x1_19.y = dot (_mtl_u.unity_SHBg, tmpvar_20);
  x1_19.z = dot (_mtl_u.unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (_mtl_u.unity_SHC.xyz * 
    ((normal_14.x * normal_14.x) - (normal_14.y * normal_14.y))
  )));
  bool tmpvar_21;
  tmpvar_21 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_21) {
    res_17 = max ((((half)1.055 * 
      pow (max (res_17, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  ambient_15 = max ((half3)float3(0.0, 0.0, 0.0), res_17);
  tmpvar_8 = ambient_15;
  _mtl_o.gl_Position = tmpvar_3;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_9;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD5 = ambient_15;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec4 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
vec4 t0;
vec3 t1;
vec4 t2;
vec3 t3;
float t12;
bool tb12;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    vs_TEXCOORD1.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    t1.x = t0.y * t0.y;
    t1.x = t0.x * t0.x + (-t1.x);
    t2 = t0.yzzx * t0.xyzz;
    t3.x = dot(unity_SHBr, t2);
    t3.y = dot(unity_SHBg, t2);
    t3.z = dot(unity_SHBb, t2);
    t1.xyz = unity_SHC.xyz * t1.xxx + t3.xyz;
    t0.w = 1.0;
    t2.x = dot(unity_SHAr, t0);
    t2.y = dot(unity_SHAg, t0);
    t2.z = dot(unity_SHAb, t0);
    t0.xyz = t1.xyz + t2.xyz;
    t1.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    t1.xyz = log2(t1.xyz);
    t1.xyz = t1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t1.xyz = exp2(t1.xyz);
    t1.xyz = t1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t1.xyz = max(t1.xyz, vec3(0.0, 0.0, 0.0));
    tb12 = unity_ColorSpaceLuminance.w==0.0;
    t0.xyz = (bool(tb12)) ? t1.xyz : t0.xyz;
    vs_TEXCOORD5.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
uniform  sampler2D _MainTex;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
layout(location = 1) out vec4 SV_Target1;
layout(location = 2) out vec4 SV_Target2;
layout(location = 3) out vec4 SV_Target3;
vec3 t0;
lowp vec4 t10_0;
vec3 t1;
bool tb2;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0.x = t10_0.w * vs_TEXCOORD3.w;
    tb2 = t0.x<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0.x = t0.x * 100000000.0;
    t0.xyz = t0.xxx * _Color.xyz;
    t1.xyz = t0.xyz * vs_TEXCOORD5.xyz;
    SV_Target3.xyz = exp2((-t1.xyz));
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 11 math, 2 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * gl_Vertex).xyz;
  vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * gl_Normal.x)
   + 
    (v_7.xyz * gl_Normal.y)
  ) + (v_8.xyz * gl_Normal.z)));
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_10;
  ambient_10 = tmpvar_4;
  vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_9;
  vec3 res_12;
  vec3 x_13;
  x_13.x = dot (unity_SHAr, tmpvar_11);
  x_13.y = dot (unity_SHAg, tmpvar_11);
  x_13.z = dot (unity_SHAb, tmpvar_11);
  vec3 x1_14;
  vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_9.xyzz * tmpvar_9.yzzx);
  x1_14.x = dot (unity_SHBr, tmpvar_15);
  x1_14.y = dot (unity_SHBg, tmpvar_15);
  x1_14.z = dot (unity_SHBb, tmpvar_15);
  res_12 = (x_13 + (x1_14 + (unity_SHC.xyz * 
    ((tmpvar_9.x * tmpvar_9.x) - (tmpvar_9.y * tmpvar_9.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_12 = max (((1.055 * 
      pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_10 = max (vec3(0.0, 0.0, 0.0), res_12);
  tmpvar_4 = ambient_10;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = gl_Color;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ambient_10;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  vec3 tmpvar_2;
  tmpvar_2 = (_Color * (tmpvar_1.w * 1e+08)).xyz;
  vec4 emission_3;
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_2;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * 0.5) + 0.5);
  emission_3.w = 1.0;
  emission_3.xyz = (tmpvar_2 * xlv_TEXCOORD5);
  gl_FragData[0] = tmpvar_4;
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
  gl_FragData[2] = tmpvar_5;
  gl_FragData[3] = emission_3;
}


#endif
"
}
SubProgram "metal " {
// Stats: 34 math, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 288
Matrix 64 [glstate_matrix_mvp]
Matrix 128 [_Object2World]
Matrix 192 [_World2Object]
VectorHalf 0 [unity_SHAr] 4
VectorHalf 8 [unity_SHAg] 4
VectorHalf 16 [unity_SHAb] 4
VectorHalf 24 [unity_SHBr] 4
VectorHalf 32 [unity_SHBg] 4
VectorHalf 40 [unity_SHBb] 4
VectorHalf 48 [unity_SHC] 4
VectorHalf 256 [unity_ColorSpaceLuminance] 4
Vector 272 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD4;
  half3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  float4 tmpvar_3;
  float2 tmpvar_4;
  half3 tmpvar_5;
  half4 tmpvar_6;
  float4 tmpvar_7;
  half3 tmpvar_8;
  tmpvar_6 = tmpvar_1;
  tmpvar_3 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  tmpvar_4 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_9;
  tmpvar_9 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  float4 v_10;
  v_10.x = _mtl_u._World2Object[0].x;
  v_10.y = _mtl_u._World2Object[1].x;
  v_10.z = _mtl_u._World2Object[2].x;
  v_10.w = _mtl_u._World2Object[3].x;
  float4 v_11;
  v_11.x = _mtl_u._World2Object[0].y;
  v_11.y = _mtl_u._World2Object[1].y;
  v_11.z = _mtl_u._World2Object[2].y;
  v_11.w = _mtl_u._World2Object[3].y;
  float4 v_12;
  v_12.x = _mtl_u._World2Object[0].z;
  v_12.y = _mtl_u._World2Object[1].z;
  v_12.z = _mtl_u._World2Object[2].z;
  v_12.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * _mtl_i._glesNormal.x)
   + 
    (v_11.xyz * _mtl_i._glesNormal.y)
  ) + (v_12.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_13);
  tmpvar_5 = worldNormal_2;
  tmpvar_7.zw = float2(0.0, 0.0);
  tmpvar_7.xy = float2(0.0, 0.0);
  tmpvar_8 = half3(float3(0.0, 0.0, 0.0));
  half3 normal_14;
  normal_14 = worldNormal_2;
  half3 ambient_15;
  ambient_15 = tmpvar_8;
  half4 tmpvar_16;
  tmpvar_16.w = half(1.0);
  tmpvar_16.xyz = normal_14;
  half3 res_17;
  half3 x_18;
  x_18.x = dot (_mtl_u.unity_SHAr, tmpvar_16);
  x_18.y = dot (_mtl_u.unity_SHAg, tmpvar_16);
  x_18.z = dot (_mtl_u.unity_SHAb, tmpvar_16);
  half3 x1_19;
  half4 tmpvar_20;
  tmpvar_20 = (normal_14.xyzz * normal_14.yzzx);
  x1_19.x = dot (_mtl_u.unity_SHBr, tmpvar_20);
  x1_19.y = dot (_mtl_u.unity_SHBg, tmpvar_20);
  x1_19.z = dot (_mtl_u.unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (_mtl_u.unity_SHC.xyz * 
    ((normal_14.x * normal_14.x) - (normal_14.y * normal_14.y))
  )));
  bool tmpvar_21;
  tmpvar_21 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_21) {
    res_17 = max ((((half)1.055 * 
      pow (max (res_17, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  ambient_15 = max ((half3)float3(0.0, 0.0, 0.0), res_17);
  tmpvar_8 = ambient_15;
  _mtl_o.gl_Position = tmpvar_3;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_9;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD5 = ambient_15;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec4 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
vec4 t0;
vec3 t1;
vec4 t2;
vec3 t3;
float t12;
bool tb12;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t0.x = in_NORMAL0.x * _World2Object[0].x;
    t0.y = in_NORMAL0.x * _World2Object[1].x;
    t0.z = in_NORMAL0.x * _World2Object[2].x;
    t1.x = in_NORMAL0.y * _World2Object[0].y;
    t1.y = in_NORMAL0.y * _World2Object[1].y;
    t1.z = in_NORMAL0.y * _World2Object[2].y;
    t0.xyz = t0.xyz + t1.xyz;
    t1.x = in_NORMAL0.z * _World2Object[0].z;
    t1.y = in_NORMAL0.z * _World2Object[1].z;
    t1.z = in_NORMAL0.z * _World2Object[2].z;
    t0.xyz = t0.xyz + t1.xyz;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    vs_TEXCOORD1.xyz = t0.xyz;
    t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
    t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    t1.x = t0.y * t0.y;
    t1.x = t0.x * t0.x + (-t1.x);
    t2 = t0.yzzx * t0.xyzz;
    t3.x = dot(unity_SHBr, t2);
    t3.y = dot(unity_SHBg, t2);
    t3.z = dot(unity_SHBb, t2);
    t1.xyz = unity_SHC.xyz * t1.xxx + t3.xyz;
    t0.w = 1.0;
    t2.x = dot(unity_SHAr, t0);
    t2.y = dot(unity_SHAg, t0);
    t2.z = dot(unity_SHAb, t0);
    t0.xyz = t1.xyz + t2.xyz;
    t1.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    t1.xyz = log2(t1.xyz);
    t1.xyz = t1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t1.xyz = exp2(t1.xyz);
    t1.xyz = t1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t1.xyz = max(t1.xyz, vec3(0.0, 0.0, 0.0));
    tb12 = unity_ColorSpaceLuminance.w==0.0;
    t0.xyz = (bool(tb12)) ? t1.xyz : t0.xyz;
    vs_TEXCOORD5.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
uniform  sampler2D _MainTex;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
layout(location = 1) out vec4 SV_Target1;
layout(location = 2) out vec4 SV_Target2;
layout(location = 3) out vec4 SV_Target3;
vec3 t0;
lowp vec4 t10_0;
bool tb1;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0.x = t10_0.w * vs_TEXCOORD3.w;
    tb1 = t0.x<_AlphaCutoff;
    if((int(tb1) * int(0xffffffffu))!=0){discard;}
    t0.x = t0.x * 100000000.0;
    t0.xyz = t0.xxx * _Color.xyz;
    SV_Target3.xyz = t0.xyz * vs_TEXCOORD5.xyz;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 13 math, 2 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"#version 120

#ifdef VERTEX
uniform vec4 _ScreenParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  vec4 pos_5;
  pos_5.zw = gl_Vertex.zw;
  vec2 tmpvar_6;
  tmpvar_6 = (_ScreenParams.xy * 0.5);
  pos_5.xy = ((floor(
    (((gl_Vertex.xy / gl_Vertex.w) * tmpvar_6) + vec2(0.5, 0.5))
  ) / tmpvar_6) * gl_Vertex.w);
  tmpvar_1 = (gl_ModelViewProjectionMatrix * pos_5);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * pos_5).xyz;
  vec4 v_8;
  v_8.x = _World2Object[0].x;
  v_8.y = _World2Object[1].x;
  v_8.z = _World2Object[2].x;
  v_8.w = _World2Object[3].x;
  vec4 v_9;
  v_9.x = _World2Object[0].y;
  v_9.y = _World2Object[1].y;
  v_9.z = _World2Object[2].y;
  v_9.w = _World2Object[3].y;
  vec4 v_10;
  v_10.x = _World2Object[0].z;
  v_10.y = _World2Object[1].z;
  v_10.z = _World2Object[2].z;
  v_10.w = _World2Object[3].z;
  vec3 tmpvar_11;
  tmpvar_11 = normalize(((
    (v_8.xyz * gl_Normal.x)
   + 
    (v_9.xyz * gl_Normal.y)
  ) + (v_10.xyz * gl_Normal.z)));
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_12;
  ambient_12 = tmpvar_4;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_11;
  vec3 res_14;
  vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_13);
  x_15.y = dot (unity_SHAg, tmpvar_13);
  x_15.z = dot (unity_SHAb, tmpvar_13);
  vec3 x1_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_11.xyzz * tmpvar_11.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((tmpvar_11.x * tmpvar_11.x) - (tmpvar_11.y * tmpvar_11.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_14 = max (((1.055 * 
      pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_12 = max (vec3(0.0, 0.0, 0.0), res_14);
  tmpvar_4 = ambient_12;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = gl_Color;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ambient_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 outEmission_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_2.w < _AlphaCutoff)) {
    discard;
  };
  vec3 tmpvar_3;
  tmpvar_3 = (_Color * (tmpvar_2.w * 1e+08)).xyz;
  vec4 emission_4;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = ((xlv_TEXCOORD1 * 0.5) + 0.5);
  emission_4.w = 1.0;
  emission_4.xyz = (tmpvar_3 * xlv_TEXCOORD5);
  outEmission_1.w = emission_4.w;
  outEmission_1.xyz = exp2(-(emission_4.xyz));
  gl_FragData[0] = tmpvar_5;
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
  gl_FragData[2] = tmpvar_6;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "metal " {
// Stats: 41 math, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 304
Matrix 80 [glstate_matrix_mvp]
Matrix 144 [_Object2World]
Matrix 208 [_World2Object]
Vector 0 [_ScreenParams]
VectorHalf 16 [unity_SHAr] 4
VectorHalf 24 [unity_SHAg] 4
VectorHalf 32 [unity_SHAb] 4
VectorHalf 40 [unity_SHBr] 4
VectorHalf 48 [unity_SHBg] 4
VectorHalf 56 [unity_SHBb] 4
VectorHalf 64 [unity_SHC] 4
VectorHalf 272 [unity_ColorSpaceLuminance] 4
Vector 288 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD4;
  half3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float4 _ScreenParams;
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  float4 tmpvar_3;
  float2 tmpvar_4;
  half3 tmpvar_5;
  half4 tmpvar_6;
  float4 tmpvar_7;
  half3 tmpvar_8;
  float4 pos_9;
  pos_9.zw = _mtl_i._glesVertex.zw;
  float2 tmpvar_10;
  tmpvar_10 = (_mtl_u._ScreenParams.xy * 0.5);
  pos_9.xy = ((floor(
    (((_mtl_i._glesVertex.xy / _mtl_i._glesVertex.w) * tmpvar_10) + float2(0.5, 0.5))
  ) / tmpvar_10) * _mtl_i._glesVertex.w);
  tmpvar_6 = tmpvar_1;
  tmpvar_3 = (_mtl_u.glstate_matrix_mvp * pos_9);
  tmpvar_4 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_11;
  tmpvar_11 = (_mtl_u._Object2World * pos_9).xyz;
  float4 v_12;
  v_12.x = _mtl_u._World2Object[0].x;
  v_12.y = _mtl_u._World2Object[1].x;
  v_12.z = _mtl_u._World2Object[2].x;
  v_12.w = _mtl_u._World2Object[3].x;
  float4 v_13;
  v_13.x = _mtl_u._World2Object[0].y;
  v_13.y = _mtl_u._World2Object[1].y;
  v_13.z = _mtl_u._World2Object[2].y;
  v_13.w = _mtl_u._World2Object[3].y;
  float4 v_14;
  v_14.x = _mtl_u._World2Object[0].z;
  v_14.y = _mtl_u._World2Object[1].z;
  v_14.z = _mtl_u._World2Object[2].z;
  v_14.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * _mtl_i._glesNormal.x)
   + 
    (v_13.xyz * _mtl_i._glesNormal.y)
  ) + (v_14.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_15);
  tmpvar_5 = worldNormal_2;
  tmpvar_7.zw = float2(0.0, 0.0);
  tmpvar_7.xy = float2(0.0, 0.0);
  tmpvar_8 = half3(float3(0.0, 0.0, 0.0));
  half3 normal_16;
  normal_16 = worldNormal_2;
  half3 ambient_17;
  ambient_17 = tmpvar_8;
  half4 tmpvar_18;
  tmpvar_18.w = half(1.0);
  tmpvar_18.xyz = normal_16;
  half3 res_19;
  half3 x_20;
  x_20.x = dot (_mtl_u.unity_SHAr, tmpvar_18);
  x_20.y = dot (_mtl_u.unity_SHAg, tmpvar_18);
  x_20.z = dot (_mtl_u.unity_SHAb, tmpvar_18);
  half3 x1_21;
  half4 tmpvar_22;
  tmpvar_22 = (normal_16.xyzz * normal_16.yzzx);
  x1_21.x = dot (_mtl_u.unity_SHBr, tmpvar_22);
  x1_21.y = dot (_mtl_u.unity_SHBg, tmpvar_22);
  x1_21.z = dot (_mtl_u.unity_SHBb, tmpvar_22);
  res_19 = (x_20 + (x1_21 + (_mtl_u.unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  bool tmpvar_23;
  tmpvar_23 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_23) {
    res_19 = max ((((half)1.055 * 
      pow (max (res_19, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  ambient_17 = max ((half3)float3(0.0, 0.0, 0.0), res_19);
  tmpvar_8 = ambient_17;
  _mtl_o.gl_Position = tmpvar_3;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_11;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD5 = ambient_17;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec4 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
vec3 t0;
vec4 t1;
vec4 t2;
vec3 t3;
vec3 t4;
vec2 t8;
bool tb12;
void main()
{
    t0.xy = in_POSITION0.xy / in_POSITION0.ww;
    t8.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    t0.xy = t8.xy * t0.xy;
    t0.xy = roundEven(t0.xy);
    t0.xy = t0.xy / t8.xy;
    t0.xy = t0.xy * in_POSITION0.ww;
    t1 = t0.yyyy * glstate_matrix_mvp[1];
    t1 = glstate_matrix_mvp[0] * t0.xxxx + t1;
    t1 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t1;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t1.x = in_NORMAL0.x * _World2Object[0].x;
    t1.y = in_NORMAL0.x * _World2Object[1].x;
    t1.z = in_NORMAL0.x * _World2Object[2].x;
    t2.x = in_NORMAL0.y * _World2Object[0].y;
    t2.y = in_NORMAL0.y * _World2Object[1].y;
    t2.z = in_NORMAL0.y * _World2Object[2].y;
    t1.xyz = t1.xyz + t2.xyz;
    t2.x = in_NORMAL0.z * _World2Object[0].z;
    t2.y = in_NORMAL0.z * _World2Object[1].z;
    t2.z = in_NORMAL0.z * _World2Object[2].z;
    t1.xyz = t1.xyz + t2.xyz;
    t8.x = dot(t1.xyz, t1.xyz);
    t8.x = inversesqrt(t8.x);
    t1.xyz = t8.xxx * t1.xyz;
    vs_TEXCOORD1.xyz = t1.xyz;
    t4.xyz = t0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * t0.xxx + t4.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    t0.x = t1.y * t1.y;
    t0.x = t1.x * t1.x + (-t0.x);
    t2 = t1.yzzx * t1.xyzz;
    t3.x = dot(unity_SHBr, t2);
    t3.y = dot(unity_SHBg, t2);
    t3.z = dot(unity_SHBb, t2);
    t0.xyz = unity_SHC.xyz * t0.xxx + t3.xyz;
    t1.w = 1.0;
    t2.x = dot(unity_SHAr, t1);
    t2.y = dot(unity_SHAg, t1);
    t2.z = dot(unity_SHAb, t1);
    t0.xyz = t0.xyz + t2.xyz;
    t1.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    t1.xyz = log2(t1.xyz);
    t1.xyz = t1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t1.xyz = exp2(t1.xyz);
    t1.xyz = t1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t1.xyz = max(t1.xyz, vec3(0.0, 0.0, 0.0));
    tb12 = unity_ColorSpaceLuminance.w==0.0;
    t0.xyz = (bool(tb12)) ? t1.xyz : t0.xyz;
    vs_TEXCOORD5.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
uniform  sampler2D _MainTex;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
layout(location = 1) out vec4 SV_Target1;
layout(location = 2) out vec4 SV_Target2;
layout(location = 3) out vec4 SV_Target3;
vec3 t0;
lowp vec4 t10_0;
vec3 t1;
bool tb2;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0.x = t10_0.w * vs_TEXCOORD3.w;
    tb2 = t0.x<_AlphaCutoff;
    if((int(tb2) * int(0xffffffffu))!=0){discard;}
    t0.x = t0.x * 100000000.0;
    t0.xyz = t0.xxx * _Color.xyz;
    t1.xyz = t0.xyz * vs_TEXCOORD5.xyz;
    SV_Target3.xyz = exp2((-t1.xyz));
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}
#endif
"
}
SubProgram "opengl " {
// Stats: 11 math, 2 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" "PIXELSNAP_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ScreenParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec2 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  vec4 pos_5;
  pos_5.zw = gl_Vertex.zw;
  vec2 tmpvar_6;
  tmpvar_6 = (_ScreenParams.xy * 0.5);
  pos_5.xy = ((floor(
    (((gl_Vertex.xy / gl_Vertex.w) * tmpvar_6) + vec2(0.5, 0.5))
  ) / tmpvar_6) * gl_Vertex.w);
  tmpvar_1 = (gl_ModelViewProjectionMatrix * pos_5);
  tmpvar_2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * pos_5).xyz;
  vec4 v_8;
  v_8.x = _World2Object[0].x;
  v_8.y = _World2Object[1].x;
  v_8.z = _World2Object[2].x;
  v_8.w = _World2Object[3].x;
  vec4 v_9;
  v_9.x = _World2Object[0].y;
  v_9.y = _World2Object[1].y;
  v_9.z = _World2Object[2].y;
  v_9.w = _World2Object[3].y;
  vec4 v_10;
  v_10.x = _World2Object[0].z;
  v_10.y = _World2Object[1].z;
  v_10.z = _World2Object[2].z;
  v_10.w = _World2Object[3].z;
  vec3 tmpvar_11;
  tmpvar_11 = normalize(((
    (v_8.xyz * gl_Normal.x)
   + 
    (v_9.xyz * gl_Normal.y)
  ) + (v_10.xyz * gl_Normal.z)));
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vec2(0.0, 0.0);
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_12;
  ambient_12 = tmpvar_4;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_11;
  vec3 res_14;
  vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_13);
  x_15.y = dot (unity_SHAg, tmpvar_13);
  x_15.z = dot (unity_SHAb, tmpvar_13);
  vec3 x1_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_11.xyzz * tmpvar_11.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((tmpvar_11.x * tmpvar_11.x) - (tmpvar_11.y * tmpvar_11.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_14 = max (((1.055 * 
      pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_12 = max (vec3(0.0, 0.0, 0.0), res_14);
  tmpvar_4 = ambient_12;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = gl_Color;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ambient_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _AlphaCutoff;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD3);
  if ((tmpvar_1.w < _AlphaCutoff)) {
    discard;
  };
  vec3 tmpvar_2;
  tmpvar_2 = (_Color * (tmpvar_1.w * 1e+08)).xyz;
  vec4 emission_3;
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_2;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * 0.5) + 0.5);
  emission_3.w = 1.0;
  emission_3.xyz = (tmpvar_2 * xlv_TEXCOORD5);
  gl_FragData[0] = tmpvar_4;
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
  gl_FragData[2] = tmpvar_5;
  gl_FragData[3] = emission_3;
}


#endif
"
}
SubProgram "metal " {
// Stats: 41 math, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" "PIXELSNAP_ON" }
Bind "vertex" ATTR0
Bind "color" ATTR1
Bind "normal" ATTR2
Bind "texcoord" ATTR3
ConstBuffer "$Globals" 304
Matrix 80 [glstate_matrix_mvp]
Matrix 144 [_Object2World]
Matrix 208 [_World2Object]
Vector 0 [_ScreenParams]
VectorHalf 16 [unity_SHAr] 4
VectorHalf 24 [unity_SHAg] 4
VectorHalf 32 [unity_SHAb] 4
VectorHalf 40 [unity_SHBr] 4
VectorHalf 48 [unity_SHBg] 4
VectorHalf 56 [unity_SHBb] 4
VectorHalf 64 [unity_SHC] 4
VectorHalf 272 [unity_ColorSpaceLuminance] 4
Vector 288 [_MainTex_ST]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float4 _glesColor [[attribute(1)]];
  float3 _glesNormal [[attribute(2)]];
  float4 _glesMultiTexCoord0 [[attribute(3)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  float3 xlv_TEXCOORD2;
  half4 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD4;
  half3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float4 _ScreenParams;
  half4 unity_SHAr;
  half4 unity_SHAg;
  half4 unity_SHAb;
  half4 unity_SHBr;
  half4 unity_SHBg;
  half4 unity_SHBb;
  half4 unity_SHC;
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _World2Object;
  half4 unity_ColorSpaceLuminance;
  float4 _MainTex_ST;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  tmpvar_1 = half4(_mtl_i._glesColor);
  half3 worldNormal_2;
  float4 tmpvar_3;
  float2 tmpvar_4;
  half3 tmpvar_5;
  half4 tmpvar_6;
  float4 tmpvar_7;
  half3 tmpvar_8;
  float4 pos_9;
  pos_9.zw = _mtl_i._glesVertex.zw;
  float2 tmpvar_10;
  tmpvar_10 = (_mtl_u._ScreenParams.xy * 0.5);
  pos_9.xy = ((floor(
    (((_mtl_i._glesVertex.xy / _mtl_i._glesVertex.w) * tmpvar_10) + float2(0.5, 0.5))
  ) / tmpvar_10) * _mtl_i._glesVertex.w);
  tmpvar_6 = tmpvar_1;
  tmpvar_3 = (_mtl_u.glstate_matrix_mvp * pos_9);
  tmpvar_4 = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
  float3 tmpvar_11;
  tmpvar_11 = (_mtl_u._Object2World * pos_9).xyz;
  float4 v_12;
  v_12.x = _mtl_u._World2Object[0].x;
  v_12.y = _mtl_u._World2Object[1].x;
  v_12.z = _mtl_u._World2Object[2].x;
  v_12.w = _mtl_u._World2Object[3].x;
  float4 v_13;
  v_13.x = _mtl_u._World2Object[0].y;
  v_13.y = _mtl_u._World2Object[1].y;
  v_13.z = _mtl_u._World2Object[2].y;
  v_13.w = _mtl_u._World2Object[3].y;
  float4 v_14;
  v_14.x = _mtl_u._World2Object[0].z;
  v_14.y = _mtl_u._World2Object[1].z;
  v_14.z = _mtl_u._World2Object[2].z;
  v_14.w = _mtl_u._World2Object[3].z;
  float3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * _mtl_i._glesNormal.x)
   + 
    (v_13.xyz * _mtl_i._glesNormal.y)
  ) + (v_14.xyz * _mtl_i._glesNormal.z)));
  worldNormal_2 = half3(tmpvar_15);
  tmpvar_5 = worldNormal_2;
  tmpvar_7.zw = float2(0.0, 0.0);
  tmpvar_7.xy = float2(0.0, 0.0);
  tmpvar_8 = half3(float3(0.0, 0.0, 0.0));
  half3 normal_16;
  normal_16 = worldNormal_2;
  half3 ambient_17;
  ambient_17 = tmpvar_8;
  half4 tmpvar_18;
  tmpvar_18.w = half(1.0);
  tmpvar_18.xyz = normal_16;
  half3 res_19;
  half3 x_20;
  x_20.x = dot (_mtl_u.unity_SHAr, tmpvar_18);
  x_20.y = dot (_mtl_u.unity_SHAg, tmpvar_18);
  x_20.z = dot (_mtl_u.unity_SHAb, tmpvar_18);
  half3 x1_21;
  half4 tmpvar_22;
  tmpvar_22 = (normal_16.xyzz * normal_16.yzzx);
  x1_21.x = dot (_mtl_u.unity_SHBr, tmpvar_22);
  x1_21.y = dot (_mtl_u.unity_SHBg, tmpvar_22);
  x1_21.z = dot (_mtl_u.unity_SHBb, tmpvar_22);
  res_19 = (x_20 + (x1_21 + (_mtl_u.unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  bool tmpvar_23;
  tmpvar_23 = (_mtl_u.unity_ColorSpaceLuminance.w == (half)0.0);
  if (tmpvar_23) {
    res_19 = max ((((half)1.055 * 
      pow (max (res_19, (half3)float3(0.0, 0.0, 0.0)), (half3)float3(0.4166667, 0.4166667, 0.4166667))
    ) - (half)0.055), (half3)float3(0.0, 0.0, 0.0));
  };
  ambient_17 = max ((half3)float3(0.0, 0.0, 0.0), res_19);
  tmpvar_8 = ambient_17;
  _mtl_o.gl_Position = tmpvar_3;
  _mtl_o.xlv_TEXCOORD0 = tmpvar_4;
  _mtl_o.xlv_TEXCOORD1 = tmpvar_5;
  _mtl_o.xlv_TEXCOORD2 = tmpvar_11;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_6;
  _mtl_o.xlv_TEXCOORD4 = tmpvar_7;
  _mtl_o.xlv_TEXCOORD5 = ambient_17;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
in  vec4 in_COLOR0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec4 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
vec3 t0;
vec4 t1;
vec4 t2;
vec3 t3;
vec3 t4;
vec2 t8;
bool tb12;
void main()
{
    t0.xy = in_POSITION0.xy / in_POSITION0.ww;
    t8.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    t0.xy = t8.xy * t0.xy;
    t0.xy = roundEven(t0.xy);
    t0.xy = t0.xy / t8.xy;
    t0.xy = t0.xy * in_POSITION0.ww;
    t1 = t0.yyyy * glstate_matrix_mvp[1];
    t1 = glstate_matrix_mvp[0] * t0.xxxx + t1;
    t1 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t1;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    t1.x = in_NORMAL0.x * _World2Object[0].x;
    t1.y = in_NORMAL0.x * _World2Object[1].x;
    t1.z = in_NORMAL0.x * _World2Object[2].x;
    t2.x = in_NORMAL0.y * _World2Object[0].y;
    t2.y = in_NORMAL0.y * _World2Object[1].y;
    t2.z = in_NORMAL0.y * _World2Object[2].y;
    t1.xyz = t1.xyz + t2.xyz;
    t2.x = in_NORMAL0.z * _World2Object[0].z;
    t2.y = in_NORMAL0.z * _World2Object[1].z;
    t2.z = in_NORMAL0.z * _World2Object[2].z;
    t1.xyz = t1.xyz + t2.xyz;
    t8.x = dot(t1.xyz, t1.xyz);
    t8.x = inversesqrt(t8.x);
    t1.xyz = t8.xxx * t1.xyz;
    vs_TEXCOORD1.xyz = t1.xyz;
    t4.xyz = t0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * t0.xxx + t4.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD2.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    t0.x = t1.y * t1.y;
    t0.x = t1.x * t1.x + (-t0.x);
    t2 = t1.yzzx * t1.xyzz;
    t3.x = dot(unity_SHBr, t2);
    t3.y = dot(unity_SHBg, t2);
    t3.z = dot(unity_SHBb, t2);
    t0.xyz = unity_SHC.xyz * t0.xxx + t3.xyz;
    t1.w = 1.0;
    t2.x = dot(unity_SHAr, t1);
    t2.y = dot(unity_SHAg, t1);
    t2.z = dot(unity_SHAb, t1);
    t0.xyz = t0.xyz + t2.xyz;
    t1.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    t1.xyz = log2(t1.xyz);
    t1.xyz = t1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    t1.xyz = exp2(t1.xyz);
    t1.xyz = t1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    t1.xyz = max(t1.xyz, vec3(0.0, 0.0, 0.0));
    tb12 = unity_ColorSpaceLuminance.w==0.0;
    t0.xyz = (bool(tb12)) ? t1.xyz : t0.xyz;
    vs_TEXCOORD5.xyz = max(t0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}
#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4x4 unity_CameraProjection;
uniform 	mat4x4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4x4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4x4 glstate_matrix_mvp;
uniform 	mat4x4 glstate_matrix_modelview0;
uniform 	mat4x4 glstate_matrix_invtrans_modelview0;
uniform 	mat4x4 _Object2World;
uniform 	mat4x4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4x4 glstate_matrix_transpose_modelview0;
uniform 	mat4x4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4x4 unity_MatrixV;
uniform 	mat4x4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	vec4 _LightColor0;
uniform 	vec4 _SpecColor;
uniform 	vec4 _Color;
uniform 	float _AlphaCutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 unity_Ambient;
uniform  sampler2D _MainTex;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
layout(location = 1) out vec4 SV_Target1;
layout(location = 2) out vec4 SV_Target2;
layout(location = 3) out vec4 SV_Target3;
vec3 t0;
lowp vec4 t10_0;
bool tb1;
void main()
{
    t10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    t0.x = t10_0.w * vs_TEXCOORD3.w;
    tb1 = t0.x<_AlphaCutoff;
    if((int(tb1) * int(0xffffffffu))!=0){discard;}
    t0.x = t0.x * 100000000.0;
    t0.xyz = t0.xxx * _Color.xyz;
    SV_Target3.xyz = t0.xyz * vs_TEXCOORD5.xyz;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}
#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 15 math, 2 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 12
VectorHalf 0 [_Color] 4
Float 8 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
  half4 _glesFragData_1 [[color(1)]];
  half4 _glesFragData_2 [[color(2)]];
  half4 _glesFragData_3 [[color(3)]];
};
struct xlatMtlShaderUniform {
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 outEmission_1;
  half3 tmpvar_2;
  half4 tmpvar_3;
  tmpvar_3 = _mtl_i.xlv_TEXCOORD3;
  tmpvar_2 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_4;
  float alpha_5;
  half4 tmpvar_6;
  tmpvar_6 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_3);
  if (((float)tmpvar_6.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_7;
  tmpvar_7 = (tmpvar_6.w * (half)1e+08);
  alpha_5 = float(tmpvar_7);
  float3 tmpvar_8;
  tmpvar_8 = ((float4)_mtl_u._Color * alpha_5).xyz;
  tmpvar_4 = half3(tmpvar_8);
  half4 outDiffuseOcclusion_9;
  half4 outNormal_10;
  half4 emission_11;
  half4 tmpvar_12;
  tmpvar_12.w = half(1.0);
  tmpvar_12.xyz = tmpvar_4;
  outDiffuseOcclusion_9 = tmpvar_12;
  half4 tmpvar_13;
  tmpvar_13.w = half(1.0);
  tmpvar_13.xyz = ((tmpvar_2 * (half)0.5) + (half)0.5);
  outNormal_10 = tmpvar_13;
  half4 tmpvar_14;
  tmpvar_14.w = half(1.0);
  tmpvar_14.xyz = half3(float3(0.0, 0.0, 0.0));
  emission_11 = tmpvar_14;
  emission_11.xyz = (emission_11.xyz + (tmpvar_4 * _mtl_i.xlv_TEXCOORD5));
  outEmission_1.w = emission_11.w;
  outEmission_1.xyz = exp2(-(emission_11.xyz));
  _mtl_o._glesFragData_0 = outDiffuseOcclusion_9;
  _mtl_o._glesFragData_1 = half4(float4(0.0, 0.0, 0.0, 0.0));
  _mtl_o._glesFragData_2 = outNormal_10;
  _mtl_o._glesFragData_3 = outEmission_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 13 math, 2 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 12
VectorHalf 0 [_Color] 4
Float 8 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
  half4 _glesFragData_1 [[color(1)]];
  half4 _glesFragData_2 [[color(2)]];
  half4 _glesFragData_3 [[color(3)]];
};
struct xlatMtlShaderUniform {
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half3 tmpvar_1;
  half4 tmpvar_2;
  tmpvar_2 = _mtl_i.xlv_TEXCOORD3;
  tmpvar_1 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_3;
  float alpha_4;
  half4 tmpvar_5;
  tmpvar_5 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_2);
  if (((float)tmpvar_5.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_6;
  tmpvar_6 = (tmpvar_5.w * (half)1e+08);
  alpha_4 = float(tmpvar_6);
  float3 tmpvar_7;
  tmpvar_7 = ((float4)_mtl_u._Color * alpha_4).xyz;
  tmpvar_3 = half3(tmpvar_7);
  half4 outDiffuseOcclusion_8;
  half4 outNormal_9;
  half4 emission_10;
  half4 tmpvar_11;
  tmpvar_11.w = half(1.0);
  tmpvar_11.xyz = tmpvar_3;
  outDiffuseOcclusion_8 = tmpvar_11;
  half4 tmpvar_12;
  tmpvar_12.w = half(1.0);
  tmpvar_12.xyz = ((tmpvar_1 * (half)0.5) + (half)0.5);
  outNormal_9 = tmpvar_12;
  half4 tmpvar_13;
  tmpvar_13.w = half(1.0);
  tmpvar_13.xyz = half3(float3(0.0, 0.0, 0.0));
  emission_10 = tmpvar_13;
  emission_10.xyz = (emission_10.xyz + (tmpvar_3 * _mtl_i.xlv_TEXCOORD5));
  _mtl_o._glesFragData_0 = outDiffuseOcclusion_8;
  _mtl_o._glesFragData_1 = half4(float4(0.0, 0.0, 0.0, 0.0));
  _mtl_o._glesFragData_2 = outNormal_9;
  _mtl_o._glesFragData_3 = emission_10;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 15 math, 2 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 12
VectorHalf 0 [_Color] 4
Float 8 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
  half4 _glesFragData_1 [[color(1)]];
  half4 _glesFragData_2 [[color(2)]];
  half4 _glesFragData_3 [[color(3)]];
};
struct xlatMtlShaderUniform {
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 outEmission_1;
  half3 tmpvar_2;
  half4 tmpvar_3;
  tmpvar_3 = _mtl_i.xlv_TEXCOORD3;
  tmpvar_2 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_4;
  float alpha_5;
  half4 tmpvar_6;
  tmpvar_6 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_3);
  if (((float)tmpvar_6.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_7;
  tmpvar_7 = (tmpvar_6.w * (half)1e+08);
  alpha_5 = float(tmpvar_7);
  float3 tmpvar_8;
  tmpvar_8 = ((float4)_mtl_u._Color * alpha_5).xyz;
  tmpvar_4 = half3(tmpvar_8);
  half4 outDiffuseOcclusion_9;
  half4 outNormal_10;
  half4 emission_11;
  half4 tmpvar_12;
  tmpvar_12.w = half(1.0);
  tmpvar_12.xyz = tmpvar_4;
  outDiffuseOcclusion_9 = tmpvar_12;
  half4 tmpvar_13;
  tmpvar_13.w = half(1.0);
  tmpvar_13.xyz = ((tmpvar_2 * (half)0.5) + (half)0.5);
  outNormal_10 = tmpvar_13;
  half4 tmpvar_14;
  tmpvar_14.w = half(1.0);
  tmpvar_14.xyz = half3(float3(0.0, 0.0, 0.0));
  emission_11 = tmpvar_14;
  emission_11.xyz = (emission_11.xyz + (tmpvar_4 * _mtl_i.xlv_TEXCOORD5));
  outEmission_1.w = emission_11.w;
  outEmission_1.xyz = exp2(-(emission_11.xyz));
  _mtl_o._glesFragData_0 = outDiffuseOcclusion_9;
  _mtl_o._glesFragData_1 = half4(float4(0.0, 0.0, 0.0, 0.0));
  _mtl_o._glesFragData_2 = outNormal_10;
  _mtl_o._glesFragData_3 = outEmission_1;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "PIXELSNAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"// shader disassembly not supported on glcore"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" "PIXELSNAP_ON" }
"// shader disassembly not supported on opengl"
}
SubProgram "metal " {
// Stats: 13 math, 2 textures, 1 branches
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" "PIXELSNAP_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 12
VectorHalf 0 [_Color] 4
Float 8 [_AlphaCutoff]
"#include <metal_stdlib>
#pragma clang diagnostic ignored "-Wparentheses-equality"
using namespace metal;
struct xlatMtlShaderInput {
  float2 xlv_TEXCOORD0;
  half3 xlv_TEXCOORD1;
  half4 xlv_TEXCOORD3;
  half3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
  half4 _glesFragData_1 [[color(1)]];
  half4 _glesFragData_2 [[color(2)]];
  half4 _glesFragData_3 [[color(3)]];
};
struct xlatMtlShaderUniform {
  half4 _Color;
  float _AlphaCutoff;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half3 tmpvar_1;
  half4 tmpvar_2;
  tmpvar_2 = _mtl_i.xlv_TEXCOORD3;
  tmpvar_1 = _mtl_i.xlv_TEXCOORD1;
  half3 tmpvar_3;
  float alpha_4;
  half4 tmpvar_5;
  tmpvar_5 = (_MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0)) * tmpvar_2);
  if (((float)tmpvar_5.w < _mtl_u._AlphaCutoff)) {
    discard_fragment();
  };
  half tmpvar_6;
  tmpvar_6 = (tmpvar_5.w * (half)1e+08);
  alpha_4 = float(tmpvar_6);
  float3 tmpvar_7;
  tmpvar_7 = ((float4)_mtl_u._Color * alpha_4).xyz;
  tmpvar_3 = half3(tmpvar_7);
  half4 outDiffuseOcclusion_8;
  half4 outNormal_9;
  half4 emission_10;
  half4 tmpvar_11;
  tmpvar_11.w = half(1.0);
  tmpvar_11.xyz = tmpvar_3;
  outDiffuseOcclusion_8 = tmpvar_11;
  half4 tmpvar_12;
  tmpvar_12.w = half(1.0);
  tmpvar_12.xyz = ((tmpvar_1 * (half)0.5) + (half)0.5);
  outNormal_9 = tmpvar_12;
  half4 tmpvar_13;
  tmpvar_13.w = half(1.0);
  tmpvar_13.xyz = half3(float3(0.0, 0.0, 0.0));
  emission_10 = tmpvar_13;
  emission_10.xyz = (emission_10.xyz + (tmpvar_3 * _mtl_i.xlv_TEXCOORD5));
  _mtl_o._glesFragData_0 = outDiffuseOcclusion_8;
  _mtl_o._glesFragData_1 = half4(float4(0.0, 0.0, 0.0, 0.0));
  _mtl_o._glesFragData_2 = outNormal_9;
  _mtl_o._glesFragData_3 = emission_10;
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" "PIXELSNAP_ON" }
"// shader disassembly not supported on glcore"
}
}
 }
}
Fallback "Transparent/VertexLit"
}