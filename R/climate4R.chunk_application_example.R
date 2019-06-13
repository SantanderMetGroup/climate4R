source("R/climate4R.chunk.R")
library(loadeR)
library(transformeR)
library(climate4R.indices)

dataset <- UDG.datasets("EWEMBI")$name
loginUDG("miturbide", "lukinvela9&9")
# indexShow()

#Codes of the Indices we want to calculate:
codes <- c("dt_st_rnagsn",  "nm_flst_rnagsn", "dt_fnst_rnagsn", "dt_ed_rnagsn", 
         "dl_agsn", "dc_agsn", "rn_agsn", "avrn_agsn", "dc_rnlg_agsn", "tm_agsn",
         "dc_txh_agsn", "dc_tnh_agsn")

code <- codes[12]

fao <- climate4R.chunk(n.chunks = 120,
                     C4R.FUN.args = list(FUN = "indexGrid",
                                         index.code = code,
                                         pr = list(dataset = dataset, var = "pr"),
                                         tn = list(dataset = dataset, var = "tasmin"),
                                         tx = list(dataset = dataset, var = "tasmax")),
                     loadGridData.args = list(lonLim = c(-180, 180),
                                              latLim = c(-90, 90)))
save(fao, file = paste0("/oceano/gmeteo/WORK/maialen/WORKm/LOCAL/PNACC/data_fao_index_2019/fao_index_", code, ".rda"))
