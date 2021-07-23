from prody import *
from pylab import *
import numpy as np
from os.path import basename
import fnmatch
import os


for file in os.listdir('.'):
    if fnmatch.fnmatch(file, '*ns_ss_fep.fep'):
        pdb = file
        file_name_wh_ex = str(os.path.splitext(pdb)[0])
        structure_1 = parsePDB(str(pdb))
        structure_2 = parsePDB(str(file_name_wh_ex+"_wb_ionized.pdb"))
        betas = structure_1.select("resname H2A")
        betas = betas.getBetas()
        selection_str_2 = structure_2.select("resname H2A")
        selection_str_2_betas = selection_str_2.setBetas(betas)
        writePDB(str(file_name_wh_ex+"_wb_ionized.fep"), structure_2, autoext=False)
        os.rename(str(file_name_wh_ex+"_wb_ionized.fep.pdb"), str(file_name_wh_ex+"_wb_ionized.fep"))
