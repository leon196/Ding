Shader "Custom/GlitchColorDirection" {
	Properties {
	}
	SubShader {
   		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
   		Pass {
		    Cull off
	    	Blend SrcAlpha OneMinusSrcAlpha     
		    ZWrite Off
			LOD 200
			
			CGPROGRAM
		    #pragma vertex vert
		    #pragma fragment frag   
	    	#include "UnityCG.cginc"   
	    	#include "../Utils/Utils.cginc"   
	    	#include "../Utils/ClassicNoise2D.cginc"   

		    struct v2f {

		        float4 pos : SV_POSITION;
		        float2 uv : TEXCOORD0;
                float4 screenUV : TEXCOORD1;
		    };   

			sampler2D _SamplerVideo;

			sampler2D _SamplerRenderTarget;
	    	float4 _SamplerVideo_ST; 

			float _TimeElapsed;
	    	float _RoundEffect;
	    	float _RoundVideo;
	    	float _RatioBufferTreshold;

			v2f vert (appdata_full v)
			{
		        v2f o;

		        o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
		        o.uv = TRANSFORM_TEX (v.texcoord, _SamplerVideo);
		        o.screenUV = ComputeScreenPos(o.pos);
		        return o;
		    }

		    half4 frag (v2f i) : COLOR
		    {
		    	float2 uv = i.screenUV.xy / i.screenUV.w;

		    	float seed = luminance(tex2D(_SamplerRenderTarget, uv).rgb);
		    	// float random = cnoise(float2(seed, 0.0));
		    	float angle = seed * PI2;
		    	float2 offset = float2(cos(angle), sin(angle)) * 0.003;

			    half4 video = tex2D(_SamplerVideo, uv);
			    half4 renderTarget = tex2D(_SamplerRenderTarget, uv + offset);

    			half4 color = lerp(renderTarget, video, step(_RatioBufferTreshold, distance(video.rgb, renderTarget.rgb)));

		        return color;
		    }
			ENDCG
		} 
	}
	FallBack "Unlit/Transparent"
}
