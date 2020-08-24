#     climate4R.chunk.C3S_428.R Apply climate4R function to each loaded set of latitudes.
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


climate4R.chunk <- function(n.chunks = 10,
                            chunk.horizontally = FALSE,
                            C4R.FUN.args = list(FUN = NULL),
                            loadGridData.args = list(),
                            output.path = NULL,
                            filename = NULL,
                            parallel = FALSE,
                            max.ncores = 16,
                            ncores = NULL) {
  parallel.pars <- parallelCheck(parallel, max.ncores, ncores)
  lapply_fun <- selectPar.pplyFun(parallel.pars, .pplyFUN = "lapply")
  if (parallel.pars$hasparallel) on.exit(parallel::stopCluster(parallel.pars$cl))
  if (!is.null(output.path)) { # This option is kept for daily outputs, i.e. big arrays (e.g. bias correction)
    suppressWarnings(dir.create(output.path))
    message("[", Sys.time(), "] NetCDF-s will be saved in ", output.path)
  }
  #PREPARE DATA FOR loadGridData
  ind.data <- which(unlist(lapply(C4R.FUN.args, function(w) "dataset" %in% names(w))))
  data <- C4R.FUN.args[ind.data]
  datasets <- lapply(data, '[[',"dataset")
  load.fun <- lapply(datasets, function(dat) {
    if (length(suppressMessages(UDG.datasets(dat))) > 0) dat <- suppressMessages(UDG.datasets(dat, full.info = TRUE)[[1]][["url"]])
    gds <- tryCatch({openDataset(dat)}, error = function(err) {NA})
    nc <- tryCatch({gds$getNetcdfDataset()}, error = function(err) {NA})
    grep.result <- tryCatch({grep("timeSeries",nc$getGlobalAttributes()$toString())}, error = function(err) {NULL})
    gds$close()
    gds <- nc <- NULL
    if (length(grep.result) == 0) {
      "loadGridData"
    } else {
      "loadStationData"
    }
  })
  vars <- lapply(data, '[[', "var")
  lf <- list.files(file.path(find.package("climate4R.UDG")), pattern = "datasets.*.txt", full.names = TRUE)
  df.datasets <- lapply(lf, function(x) read.csv(x, stringsAsFactors = FALSE))
  df.datasets <- do.call("rbind", df.datasets)  
  origVarNames <- unlist(lapply(1:length(datasets), function(d) {
    df.sub <- df.datasets[which(df.datasets$name == datasets[[d]]), 4]
    df.voc <- tryCatch({read.csv(file.path(find.package("climate4R.UDG"), "dictionaries", df.sub))},
                       error = function(err) {NA})
    tryCatch({as.character(df.voc$short_name[df.voc$identifier == vars[[d]]])},
             error = function(err) {NA})
  }))
  df.datasets <- NULL
  origVarNames[which(is.na(origVarNames))] <- unlist(vars[which(is.na(origVarNames))])
  
  ## PREPARE CHUNKS FOR loadGridData ----------------------------------
  di <- suppressMessages(lapply(1:length(datasets), function(d) {
    ddi <- dataInventory(datasets[[d]])
    if (origVarNames[d] %in% names(ddi)) {
      return(ddi[[origVarNames[d]]])
      ddi <- NULL
    } else {
      stop("Requested variable is not in dataset")
    }
  }))
  names(di) <- names(datasets) ### 172 Mb
  lnames <- c("y", "latitude", "Latitude", "lat", "Lat")
  lonnames <- c("x", "longitude", "Longitude", "lon", "Lon")
  lats <- lapply(di, function(d) {
    il <- 0
    l <- NULL
    while (is.null(l)) {
      il <- il + 1
      l <- unique(sort(d[["Dimensions"]][[lnames[il]]][["Values"]]))
      if (il > length(lnames)) stop("Problem reading latitudes")
    }
    l
  })
  if (is.null(loadGridData.args[["latLim"]])) loadGridData.args[["latLim"]] <- range(lats)
  lats.y <- lapply(1:length(lats), function(y) lats[[y]][which.min(abs(lats[[y]] - loadGridData.args[["latLim"]][1]))[1]:(min(c(length(lats[[y]]),which.min(abs(lats[[y]] - loadGridData.args[["latLim"]][2]))[1] + 1)))])
  nmax.lat.chunks <- unlist(lapply(lats.y, length))[1]
  if (chunk.horizontally) {
    n.chunks.per.axis <- ceiling(sqrt(n.chunks))
  } else {
    n.chunks.per.axis <- n.chunks
  }
  if (n.chunks.per.axis > nmax.lat.chunks) {
    warning("Defined n.chunks (", n.chunks, ") > total number of latitudes. Set to ", nmax.lat.chunks)
    n.chunks.per.axis <- nmax.lat.chunks
  }
  #Prepare lat chunking
  n.lats.y <- lapply(lats.y, length)
  n.lat.per.chunk <- lapply(n.lats.y, function(y) ceiling(y/n.chunks.per.axis))
  ind <- lapply(1:length(n.lat.per.chunk), function(ch) rep(1:(n.chunks.per.axis), each = n.lat.per.chunk[[ch]], length.out = n.lats.y[[ch]]))
  lat.list <- lapply(1:length(ind), function(ch) split(lats.y[[ch]], f = ind[[ch]]))
  lat.range.chunk <- lapply(lat.list, function(ch) 
    lapply(ch, function(r){
      ran <- range(r)
      if ((ran[2] - ran[1]) == 0) ran <- ran[1]
      ran
    })) ### 172 Mb
  lons <- lapply(di, function(d) {
    il <- 0
    l <- NULL
    while (is.null(l)) {
      il <- il + 1
      l <- unique(sort(d[["Dimensions"]][[lonnames[il]]][["Values"]]))
      if (il > length(lonnames)) stop("Problem reading longitudes")
    }
    l
  })
  if (chunk.horizontally) {
    if (is.null(loadGridData.args[["lonLim"]])) loadGridData.args[["lonLim"]] <- range(lons)
    lons.y <- lapply(1:length(lons), function(y) lons[[y]][which.min(abs(lons[[y]] - loadGridData.args[["lonLim"]][1]))[1]:(min(c(length(lons[[y]]),which.min(abs(lons[[y]] - loadGridData.args[["lonLim"]][2]))[1] + 1)))])
    nmax.lon.chunks <- unlist(lapply(lons.y, length))[1]
    if (n.chunks.per.axis > nmax.lon.chunks) {
      warning("Defined n.chunks (", n.chunks, ") > total number of longitudes. Set to ", nmax.lon.chunks)
      n.chunks.per.axis <- nmax.lon.chunks
    }
    #Prepare lon chunking
    n.lons.y <- lapply(lons.y, length)
    n.lon.per.chunk <- lapply(n.lons.y, function(y) ceiling(y/n.chunks.per.axis))
    ind <- lapply(1:length(n.lon.per.chunk), function(ch) rep(1:(n.chunks.per.axis), each = n.lon.per.chunk[[ch]], length.out = n.lons.y[[ch]]))
    lon.list <- lapply(1:length(ind), function(ch) split(lons.y[[ch]], f = ind[[ch]]))
    lon.range.chunk <- lapply(lon.list, function(ch) lapply(ch, function(r) {
      ran <- range(r)
      if ((ran[2] - ran[1]) == 0) ran <- ran[1]
      ran
    })) ### 172 Mb
  } else {
    n.lons.y <- length(lons[[1]])
    n.lon.per.chunk <- length(lons[[1]])
    lon.range.chunk <- list(list(NULL))
  }
  # Additional collocation arguments
  lGD.args.aux <- loadGridData.args
  loadGridData.args <- NULL
  ## PREPARE ARG LIST for loadGridData FOR EACH CHUNK  
  lGD.args.aux <- lapply(data, function(d) c(d, lGD.args.aux))
  lGD.args.chunk <- lapply(lat.range.chunk[[1]], function(ch) { # [[1]] considers the latitudes of the first dataset (need to think about this for future code modifications, e.g. for applying biasCorrection).
    lapply(lon.range.chunk[[1]], function(lonch){
      lapply(lGD.args.aux, function(d) {
        d[["latLim"]] <- ch
        d[["lonLim"]] <- lonch
        d
      })
    })
  })
  lGD.args.chunk <- unlist(lGD.args.chunk, recursive = FALSE)
  #LOOP FOR LOADING AND APPLYING THE C4R FUNCTION ### 172 Mb
  ind.FUN <- which(names(C4R.FUN.args) == "FUN")
  if (length(ind.FUN) != 1) stop("FUN argument required in C4R.FUN.args")
  message("[", Sys.time(), "] y contains ", n.lats.y[[1]], " latitudes, and ",  n.lons.y[[1]], " longitudes.",  C4R.FUN.args[[ind.FUN]],  " will be applied in ", length(lGD.args.chunk), " chunks of about ", n.lat.per.chunk[[1]], " latitudes and ", n.lon.per.chunk[[1]], " longitudes.")
  # mem_used <- vector("numeric", length = (length(lGD.args.chunk)*2))
  # object.size(lGD.args.chunk)
  # l <- lapply(1:length(lGD.args.chunk), function(i) { 
  ## MEMORY INTENSIVE PART -----------------------------------------------------
  out.ch <- lapply_fun(1:length(lGD.args.chunk), function(i) {
    C4R.args <- C4R.FUN.args
    # print(object.size(lGD.args.chunk), units = "Mb")
    # chunk.i <- vector(mode = "list", length = length(lGD.args.chunk[[i]]))
    # names(chunk.i) <- names(lGD.args.chunk[[i]])
    
    # object.size(chunk.i) %>% print(units = "Mb")
    
    chunk.args <- lGD.args.chunk[[i]]
    lGD.args.chunk[[i]] <- NA
    # for (d in 1:length(chunk.args)) {
    #   chunk.i[[d]] <- do.call(load.fun[[d]], chunk.args[[d]])
    # }
    # object.size(chunk.i) %>% print(units = "Mb")
    chunk.i <- lapply(1:length(chunk.args), function(d) do.call(load.fun[[d]], chunk.args[[d]])) ### 263 Mb
    if (!any(unlist(lapply(chunk.i, is.null)))) { # Ignore areas without stations
      names(chunk.i) <- names(chunk.args)
      mess <- utils:::format.object_size(object.size(chunk.i), "auto")
      # message("Chunk ", i, " / max object size: ", do.call("max", lapply(chunk.i, object.size)))
      message("Chunk ", i, " / total loaded size: ", mess)
      gc(verbose = FALSE)
      # mem_used[i] <- pryr::mem_used() # Memory profiling
      if (is.null(filename)) {
        if ("y" %in% names(chunk.i) & "x" %in% names(chunk.i)) {
          if (is.null(chunk.i[["newdata"]])) {
            filename <- strsplit(attr(chunk.i[["x"]], "dataset"), "/")
          } else {
            filename <- strsplit(attr(chunk.i[["newdata"]], "dataset"), "/")
          }
          # gsub(" ", "-", paste(names(C4R.FUN.args[-ind.data]), C4R.FUN.args[-ind.data], collapse = "_"))
          filename <- gsub(".nc.*", "_bc", filename[[1]][length(filename[[1]])])
        } else {
          filename <- strsplit(attr(chunk.i[[1]], "dataset"), "/")
          filename <- gsub(".nc.*", "", filename[[1]][length(filename[[1]])])
        }
      }
      C4R.args[ind.data] <- chunk.i
      chunk.i <- NULL
      gc(verbose = FALSE)
      C4R.chunk.output <- do.call(C4R.args[[ind.FUN]], C4R.args[-ind.FUN])
      C4R.args <- NULL
      gc(verbose = FALSE) ## 223 Mb (top desfasado en 1.5 Gb)
      
      
      if (!is.null(output.path)) {
        write.fun <- "grid2nc"
        if (attr(C4R.chunk.output[["xyCoords"]], "resX") == 0) write.fun <- "stations2nc"
        ni <- as.numeric(unlist(strsplit(names(lGD.args.chunk)[i], "\\.")))
        ni <- paste(sprintf("%03d", ni), collapse = "_")
        do.call(write.fun, list(data = C4R.chunk.output, NetCDFOutFile = paste0(output.path, "/", filename, "_chunk", ni, ".nc")))
        C4R.chunk.output <- NULL
        gc(verbose = FALSE)
        paste0(output.path, "/", filename, "_chunk", ni, ".nc")
      } else {
        gc(verbose = FALSE)
        C4R.chunk.output
      }
    }
    # return(mem_used)
  })#)### 180 Mb (1.125 Gb)
  lGD.args.chunk <- NULL
  gc(verbose = FALSE)
  # RETURN
  if (!is.null(output.path)) {
    out <- unlist(out.ch)
  } else if (is.null(output.path) & isFALSE(chunk.horizontally)) {
    out <- tryCatch({do.call("bindGrid", list(out.ch, dimension = "lat"))}, error = function(err) {unlist(out.ch, recursive = FALSE)})
  } else {
    stop("chunk.horizontally is not implemented for output.path = NULL yet.")
  }
  return(out)
}

