#include <stdio.h>

static int maxLength = 1000;
static int arrayA[1000];
static int arrayB[1000];

void getArrayA(int sizeA){
    for (int i = 0; i < sizeA; ++i) {
        int value;
        printf("Enter %d value: ", i + 1);
        scanf("%d", &value);
        arrayA[i] = value;
    }
}

void getArrayB(int sizeA){
    for (int i = 0; i < sizeA; ++i) {
        arrayB[i] = arrayA[i] * arrayA[i];
    }
}

void outResult(int sizeA){
    printf("Array B: ");
    for (int i = 0; i < sizeA; ++i) {
        printf("%d ",arrayB[i]);
    }
}

int main() {
    int sizeA;
    printf("Enter length: ");
    scanf("%d", &sizeA);
    if (sizeA > maxLength){
        printf("You entered an invalid number.");
        return 0;
    }
    getArrayA(sizeA);
    getArrayB(sizeA);
    outResult(sizeA);

    return 0;
}
