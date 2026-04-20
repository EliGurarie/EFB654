require(raster)
require(sf)
require(terra)

ny_nlcd <- rast("c:/Users/egurarie/research/MesocarnivoreMS/bigdata/NewYorkLandCover/nlcd2016_ny.tif")

syr_bbox <- cbind(c(-76.28, -76.02), c(42.96, 43.14)) |>
  vect(type = "points", crs = "EPSG:4326") |>
  project(crs(ny_nlcd)) 

ext(syr_bbox)
syracuse_nlcd <- terra::crop(ny_nlcd, ext(syr_bbox))

writeRaster(syracuse_nlcd, "syracuse_nlcd.tif", datatype = "INT1U", overwrite = TRUE)
