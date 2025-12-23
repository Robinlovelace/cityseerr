# Package startup ---------------------------------------------------------

.onLoad <- function(libname, pkgname) {
  # Load extendr dynamic library
  library.dynam("cityseerr", pkgname, libname)
}

.onUnload <- function(libpath) {
  library.dynam.unload("cityseerr", libpath)
}
