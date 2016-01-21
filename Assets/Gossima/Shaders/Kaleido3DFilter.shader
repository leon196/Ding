Shader "Hidden/Kaleido3DFilter" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader {
		Cull Off ZWrite Off ZTest Always
		Pass {
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			#include "UnityCG.cginc"
			
			sampler2D _MainTex;
			sampler2D _Kaleido3DTexture;

			fixed4 frag (v2f_img i) : SV_Target {
				return tex2D(_Kaleido3DTexture, i.uv);
			}
			ENDCG
		}
	}
}
