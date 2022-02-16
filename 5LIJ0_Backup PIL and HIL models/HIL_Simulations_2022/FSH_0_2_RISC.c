#include <FSH_0_2_RISC.h>

void read(float OutPut[],int InPut_addr,int Param)
{

    
    int addr = tile0_comm2;
    addr = addr + InPut_addr;
    float *share_to_0 = addr;
    
    int i = 0;
    for ( i = 0; i < Param; i++ )
    {
        OutPut[i] = *(share_to_0 + i);
    }
    
}
