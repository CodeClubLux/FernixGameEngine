#version 440 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoords;
layout (location = 3) in vec3 aTangent;
layout (location = 4) in vec3 aBitangent;

out vec2 TexCoords;
out vec3 Normal;
out vec3 FragPos;
out mat3 TBN;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform mat3 normalModel;

struct Material {
	sampler2D diffuse;
	sampler2D metallic;
	sampler2D roughness;
	sampler2D ao;
	sampler2D normalMap;
};

uniform vec3 viewPos;
uniform Material material;

uniform vec2 transformUVs;

void main()
{
    gl_Position = projection * view * model * vec4(aPos, 1.0);
    TexCoords = vec2(aTexCoords.x, aTexCoords.y) * transformUVs;
	Normal = normalModel * aNormal;
	FragPos = vec3(model * vec4(aPos, 1.0));

	vec3 T = normalize(vec3(model * vec4(aTangent,   0.0)));
	vec3 B = normalize(vec3(model * vec4(aBitangent, 0.0)));
	vec3 N = normalize(vec3(model * vec4(aNormal,    0.0)));
	TBN = mat3(T, B, N);
}