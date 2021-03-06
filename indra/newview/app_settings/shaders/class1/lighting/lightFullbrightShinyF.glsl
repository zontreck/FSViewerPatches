/** 
 * @file class1\lighting\lightFullbrightShinyF.glsl
 *
 * $LicenseInfo:firstyear=2007&license=viewerlgpl$
 * Second Life Viewer Source Code
 * Copyright (C) 2007, Linden Research, Inc.
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation;
 * version 2.1 of the License only.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 * 
 * Linden Research, Inc., 945 Battery Street, San Francisco, CA  94111  USA
 * $/LicenseInfo$
 */

#ifdef DEFINE_GL_FRAGCOLOR
out vec4 frag_color;
#else
#define frag_color gl_FragColor
#endif

VARYING vec4 vertex_color;
VARYING vec2 vary_texcoord0;
VARYING vec3 vary_texcoord1;

uniform samplerCube environmentMap;

// render_hud_attachments() -> HUD objects set LLShaderMgr::NO_ATMO; used in LLDrawPoolAlpha::beginRenderPass()
uniform int no_atmo;

vec3 fullbrightShinyAtmosTransport(vec3 light);
vec3 fullbrightScaleSoftClip(vec3 light);

// See:
//   class1\deferred\fullbrightShinyF.glsl
//   class1\lighting\lightFullbrightShinyF.glsl
void fullbright_shiny_lighting()
{
	vec4 color = diffuseLookup(vary_texcoord0.xy);
	color.rgb *= vertex_color.rgb;

	// SL-9632 HUDs are affected by Atmosphere
	if (no_atmo == 0)
	{
		vec3 envColor = textureCube(environmentMap, vary_texcoord1.xyz).rgb;
		color.rgb = mix(color.rgb, envColor.rgb, vertex_color.a*0.75); // MAGIC NUMBER SL-12574; ALM: Off, Quality > Low

		color.rgb = fullbrightShinyAtmosTransport(color.rgb);
		color.rgb = fullbrightScaleSoftClip(color.rgb);
	}
/*
	// NOTE: HUD objects will be full bright. Uncomment if you want "some" environment lighting effecting these HUD objects.
	else
	{
		vec3 envColor = textureCube(environmentMap, vary_texcoord1.xyz).rgb;
		color.rgb = mix(color.rgb, envColor.rgb, vertex_color.a*0.75); // MAGIC NUMBER SL-12574; ALM: Off, Quality > Low
	}
*/

	color.a = 1.0;

	frag_color = color;
}

