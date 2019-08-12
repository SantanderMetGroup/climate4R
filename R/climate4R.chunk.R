

#     climate4R.chunk.R Apply climate4R function to each loaded set of latitudes.
#
#     Copyright (C) 2017 Santander Meteorology Group (http://www.meteo.unican.es)
#
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
# 
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
# 
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <http://www.gnu.org/licenses/>.

#' @title Apply climate4R function to each loaded set (chunk) of latitudes.
#' @description Function tailored to operations performed over large data (e.g. for the entire world). 
#' The function uses a loop where in each iteration a chunk of latitudes is loaded and a climate4R 
#' function is applied to it. 
#'
#' @param n.chunks number of latitude chunks over which iterate
#' @param C4R.FUN.args list of arguments being the name of the C4R function (character)
#' the first. The rest of the arguments are those passed to the selected C4R function. 
#' This list is passed to function \link{\code{do.call}} internally. For the parameters 
#' (of a particular C4R function) where data (grids) need to be provided, here, a list of 2 
#' arguments are passed (instead of a grid): \code{list(dataset = "", var = "")}.
#' @param loadGridData.args list of collocation arguments passed to function loadGridData.
#' @param output.path Optional. Path where the results of each iteration will be saved (*.rda). 
#' Useful when the amount of data after the C4R function application is large, i.e. similar
#' to the pre-processed data (e.g. when the \link{\code{biasCorrection}} function is applied.)
#' @details Note that the appropriate libraries need to be loaded before applying this function. Packages
#' \code{loadeR} and \code{transformeR} are always needed. Depending on the C4R function that 
#' is applied the will also be needed to load the corresponding package/s.
#' etc.)
#' @return If \code{output.path} is NULL a grid containing all latitudes is returned. If \code{output.path}
#' is provided *.rda objects for each latitude chunk are saved in the specified path.
#' @family climate4R
#' 
#'
#' @author M. Iturbide
#' @export
#' @examples {
#' source("R/climate4R.chunk.R")
#' library(loadeR)
#' library(transformeR)
#' library(climate4R.climdex)
#' 
#' loginUDG(username = "", password = "")
#' 
#' z <- climate4R.chunk(n.chunks = 10,
#'                      C4R.FUN.args = list(FUN = "climdexGrid",
#'                                          index.code = "CWD",
#'                                          pr = list(dataset = "WATCH_WFDEI", var = "pr")),
#'                     loadGridData.args = list(years = 1981:2000,
#'                                              lonLim = c(-10, 10),
#'                                              latLim = c(36, 45)),
#'                     output.path = NULL)
#' library(visualizeR)
#' spatialPlot(climatology(z))
#'}

climate4R.chunk <- function(n.chunks = 10,
                            C4R.FUN.args = list(FUN = NULL),
                            loadGridData.args = list(),
                            output.path = NULL) {
  
  if (!is.null(output.path)) { # This option is kept for daily outputs, i.e. big arrays (e.g. bias correction)
    suppressWarnings(dir.create(output.path))
    message("[", Sys.time(), "] Rdata will be saved in ", output.path)
  }
  #PREPARE DATA FOR loadGridData
  ind.data <- which(unlist(lapply(C4R.FUN.args, function(w) "dataset" %in% names(w))))
  data <- C4R.FUN.args[ind.data]
  datasets <- lapply(data, '[[',"dataset")
  vars <- lapply(data, '[[',"var")
  df.datasets <- read.csv(file.path(find.package("loadeR"), "datasets.txt"), stringsAsFactors = FALSE)[ ,1:4]
  origVarNames <- unlist(lapply(1:length(datasets), function(d) {
    df.sub <- df.datasets[which(df.datasets$name == datasets[[d]]), 4]
    df.voc <- tryCatch({read.csv(file.path(find.package("loadeR"), "dictionaries", df.sub))}, error = function(err){NA})
    tryCatch({as.character(df.voc$short_name[df.voc$identifier == vars[[d]]])}, error = function(err){NA})
  }))
  origVarNames[which(is.na(origVarNames))] <- unlist(vars[which(is.na(origVarNames))])
  ## PREPARE LATITUDE CHUNKS FOR loadGridData
  di <- suppressMessages(lapply(1:length(datasets), function(d) {
    ddi <- dataInventory(datasets[[d]])
    if (origVarNames[d] %in% names(ddi)) {
      ddi[[origVarNames[d]]]
    } else {
      stop("Requested variable is not in dataset")
    }
  }))
  names(di) <- names(datasets)
  lats <- lapply(di, function(d) d[["Dimensions"]][["lat"]][["Values"]])
  if(is.null(loadGridData.args[["latLim"]])) loadGridData.args[["latLim"]] <- range(lats)
  lats.y <- lapply(1:length(lats), function(y) lats[[y]][which.min(abs(lats[[y]] - loadGridData.args[["latLim"]][1]))[1]:(which.min(abs(lats[[y]] - loadGridData.args[["latLim"]][2]))[1] + 1)])
  nmax.chunks <- min(unlist(lapply(lats.y, length)))
  if (n.chunks > ceiling(nmax.chunks/2)) {
    warning("n.chunks (", n.chunks, ") is too many. n.chunks set to ", ceiling(nmax.chunks/2))
    n.chunks <- ceiling(nmax.chunks/2)
  }
  n.lats.y <- lapply(lats.y, length)
  n.lat.chunk <- lapply(n.lats.y, function(y) ceiling(y/n.chunks))
  aux.ind <- lapply(n.lat.chunk, function(ch) rep(1:(n.chunks - 1), each = ch))
  ind <- lapply(1:length(aux.ind), function(i) c(aux.ind[[i]], rep((max(aux.ind[[i]]) + 1), each = n.lats.y[[i]] - length(aux.ind[[i]]))))
  lat.list <- lapply(1:length(ind), function(ch) split(lats.y[[ch]], f = ind[[ch]]))
  lat.range.chunk <- lapply(lat.list, function(ch) lapply(ch, range))
  # lat.range.chunk.x <- lapply(lat.range.chunk, function(ch) lapply(ch, function(x) x + c(-3, 3)))
  lGD.args.aux <- loadGridData.args
  loadGridData.args <- NULL
  ## PREPARE ARG LIST for loadGridData FOR EACH CHUNK  
  lGD.args.aux <- lapply(data, function(d) c(d, lGD.args.aux))
  lGD.args.chunk <- lapply(lat.range.chunk[[1]], function(ch) { # [[1]] considers the latitudes of the first dataset (need to think about this for future code modifications, e.g. for applying biasCorrection).
    lapply(lGD.args.aux, function(d) {
      d[["latLim"]] <- ch
      d
    })
  })
  #LOOP FOR LOADING AND APPLYING THE C4R FUNCTION 
  ind.FUN <- which(names(C4R.FUN.args) == "FUN")
  if (length(ind.FUN) != 1) stop("FUN argument required in C4R.FUN.args")
  message("[", Sys.time(), "] y contains ", n.lats.y[[1]], " latitudes. ", C4R.FUN.args[[ind.FUN]],  " will be applied in ", n.chunks, " chunks of about ", n.lat.chunk[[1]], " latitudes.")
  out.ch <- lapply(1:length(lGD.args.chunk), function(i) {
    chunk.i <- lapply(lGD.args.chunk[[i]], function(d) do.call("loadGridData", d))
    C4R.FUN.args[ind.data] <- chunk.i
    C4R.chunk.output <- do.call(C4R.FUN.args[[ind.FUN]], C4R.FUN.args[-ind.FUN])
    if (!is.null(output.path)) {
      ni <- as.character(i)
      ndigits <-  nchar(length(lGD.args.chunk))
      if (nchar(i) < ndigits) ni <- paste0(paste0(rep("0", (ndigits - nchar(i))), collapse = ""), ni)
      save(C4R.chunk.output, 
           file = paste0(output.path, "/", paste(unlist(C4R.FUN.args[-ind.data]), collapse = "_"), "_chunk", ni, ".rda"))
      paste0(output.path, "/", paste(unlist(C4R.FUN.args[-ind.data]), collapse = "_"), "_chunk_", ni, ".rda")
    } else {
      C4R.chunk.output
    }
  })
  # RETURN
  if (!is.null(output.path)) {
    out <- unlist(out.ch)
  } else {
    out <- do.call("bindGrid", list(out.ch, dimension = "lat"))
  }
  return(out)
}

