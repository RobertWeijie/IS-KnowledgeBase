#include <stdio.h>
#define EPS 1e-8

int main() {
    double x, y;
    while (scanf("%lf%lf", &x, &y) == 2) {
        if (x > y) {
            printf("woshibukezhanshengde\n");
            
        } else if (x == y) {
            printf("nakezhenchun\n");
            //break;
        } 
    
        else {
            printf("wohenbaoqian\n");
        }
        //break;
    }
    
    return 0;
}