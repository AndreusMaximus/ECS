lct_spec = legacy_code('initialize')
def.SourceFiles = {'FSH_0_2_RISC.c'};
def.HeaderFiles = {'FSH_0_2_RISC.h'};
def.SFunctionName = 'FSH_0_2_RISC_Block';
def.OutputFcnSpec = 'void read(single y1[p1],int32 u1,int32 p1)';
legacy_code('sfcn_cmex_generate', def);
legacy_code('compile', def);
legacy_code('slblock_generate', def);
legacy_code('sfcn_tlc_generate',def);