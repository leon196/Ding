Shader "Hidden/TimeDisplacement" {
	Properties 	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader 	{
		Cull Off ZWrite Off ZTest Always
		Pass 		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "../../Utils/Utils.cginc"
			
			struct appdata {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v) {
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			sampler2D _TimeTexture;
			sampler2D _DifferenceTexture;
			sampler2D _ParticleTexture;
			float _ReaktorOutput;
			float _FadeOutRatio;

			fixed4 frag (v2f i) : SV_Target {
				float2 uv = i.uv;
				fixed4 color = tex2D(_TimeTexture, uv);
				return color;
			}
			ENDCG
		}
	}
}