#include <stdio.h>

void inverse(int* p, int n) {
	for (int i = 0; i < n / 2; i++) {
		int temp = *(p + i);
		*(p + i) = *(p + n - i - 1);
		*(p + n - i - 1) = temp;
	}
}

int main() {
	int p[] = {1,2,3,4,5,14,15,16,17,18,19,20};
	int n = 5;
	inverse(p, n);
	for (int i = 0; i < sizeof(p) / sizeof(int); i++) {
		printf("%d ", *(p + i));
	}
	return 0;
}