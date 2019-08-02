#include <stdio.h>
#include <string.h>
#include <openssl/sha.h>

int main (int argc, char** argv) {
	(void) argc;
	(void) argv;
	const unsigned char s[20] = {
		6, 58, 187, 61, 137, 205, 233, 254, 5, 209,
		157, 228, 198, 52, 22, 63, 40, 184, 58, 165
	};
	unsigned char* d = SHA256(s, 20, 0);

	printf("Congratulations! You got this binary to run!\n");
	printf("The key is:\n\n");

	for (int i = 0; i < SHA256_DIGEST_LENGTH; ++i) {
		printf("%02x", d[i]);
	}
	printf("\n");
	return 0;
}
