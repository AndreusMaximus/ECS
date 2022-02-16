#include <TSH_0_1_RISC.h>

void write(float InPut[], int InPut_addr, int Param)
{
    
    int addr = tile0_comm1;
    addr = addr + InPut_addr;
    float *share_to_2 = addr;

    int i = 0; 
    
    for ( i = 0; i < Param; i++ )
    {
       *(share_to_2 + i)= InPut[i];
    }
    

}