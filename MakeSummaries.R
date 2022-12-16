##### Header #####
#
# Author:       Matthew H. Grinnell
# Affiliation:  Pacific Biological Station, Fisheries and Oceans Canada (DFO)
# Group:        Offshore Assessment, Aquatic Resources, Research, and Assessment
# Address:      3190 Hammond Bay Road, Nanaimo, BC, Canada, V9T 6N7
# Contact:      e-mail: matt.grinnell@dfo-mpo.gc.ca | tel: 250.756.7055
# Project:      Herring
# Code name:    MakeSummaries.R
# Version:      1.0
# Date started: Dec 21, 2016
# Date edited:  Feb 12, 2018
#
# Overview:
# Make summary reports (i.e., PDF) for each region: data summaries, or model
# summaries.
#
# Requirements:
# Everything that is also required in the respective *.rnw file.
#
# Notes:
# This is just a convenience (i.e., I'm lazy) script to make multiple summary
# reports: make a copy of the report knitr file named by the region and year,
# compile the PDF, and then remove the temporary files.

##### Housekeeping #####

# General options
rm(list = ls()) # Clear the workspace
sTimeC <- Sys.time() # Start the timer
graphics.off() # Turn graphics off

# Install missing packages and load required packages (if required)
UsePackages <- function(pkgs, locn = "https://cran.rstudio.com/") {
  # Reverse the list
  rPkgs <- rev(pkgs)
  # Identify missing (i.e., not yet installed) packages
  newPkgs <- rPkgs[!(rPkgs %in% installed.packages()[, "Package"])]
  # Install missing packages if required
  if (length(newPkgs)) install.packages(newPkgs, repos = locn)
  # Loop over all packages
  for (i in 1:length(rPkgs)) {
    # Load required packages using 'library'
    eval(parse(text = paste("suppressPackageStartupMessages(library(", rPkgs[i],
      "))",
      sep = ""
    )))
  } # End i loop over package names
} # End UsePackages function

# Make packages available
UsePackages(pkgs = c("knitr"))

##### Controls #####

# Report file name
reportFN <- "DataSummary"

# Report extension
reportExt <- "rnw"

# Region names: data summaries
if (reportFN == "DataSummary") {
  regionNames <- c("HG", "PRD", "CC", "SoG", "WCVI", "A27", "A2W", "A10")
}

# Region names: model summaries
if (reportFN == "ModelSummary") {
  regionNames <- c("HG", "PRD", "CC", "SoG", "WCVI")
}

##### Main #####

# Function to make summary reports
MakeReports <- function(regs) {
  # Progress message
  cat("Compiling ", length(regs), " ", reportFN, "(s): ", sep = "")
  # Loop over regions
  for (i in 1:length(regs)) {
    # Get the ith region name
    regName <- regs[i]
    # Update progress message
    cat(regName, ", ", sep = "")
    # Load the R image
    load(file = file.path(
      "..", "DataSummaries", regName,
      paste("Image", regName, "RData", sep = ".")
    ))
    # Get the last year
    # TODO: For model summaries, this should come from the model output
    lastYr <- max(yrRange)
    # Create the 'year' folder if it doesn't exist
    if (!as.character(lastYr) %in% list.files("Summaries")) {
      dir.create(path = file.path("Summaries", as.character(lastYr)))
    }
    # Output file name: report, region, and year (i.e., last year of data)
    outFN <- paste(reportFN, regName, lastYr, sep = ".")
    # Copy the report to specify the region and date (year)
    file.copy(
      from = paste(reportFN, reportExt, sep = "."),
      to = paste(outFN, reportExt, sep = ".")
    )
    # Compile the pdf
    knit2pdf(input = paste(outFN, reportExt, sep = "."), quiet = TRUE)
    # Make a copy in the [year] sub-folder
    file.copy(
      from = paste(outFN, "pdf", sep = "."),
      to = file.path("Summaries", lastYr, paste(outFN, "pdf", sep = ".")),
      overwrite = TRUE
    )
    # Get the intermediary file names
    tempFNs <- list.files(pattern = outFN)
    # Clean up the directory
    file.remove(tempFNs)
  } # End i loop over regions
  # Update progress
  cat("done\n")
} # End MakeReports function

# Make the reports
MakeReports(regs = regionNames)

##### End #####

# Print end of file message and elapsed time
cat("End of file MakeSummaries.R: ", sep = "")
print(Sys.time() - sTimeC)
