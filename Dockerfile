# Use Python3 base
FROM python:3

# Copy RTTOV from local system
COPY . /tmp

# ------ Environment variables ------ #

# Determines which HDF5 to build
ENV HDF5_MINOR_REL      hdf5-1.10.5 
ENV HDF5_SRC_URL   	http://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10                  

# RTTOV variables
ENV RTTOV_INSTALL_DIR	rttov12
ENV RTTOV_MINOR_REL	rttov123
ENV RTTOV_SRC_URL 	http://nwpsaf.eu/downloads/james

# Library path
ENV LD_LIBRARY_PATH	/usr/local/hdf5/lib

# Build the image
RUN apt-get update && apt-get -y install gfortran libhdf5-serial-dev python-dev; \
	cd /tmp && ./build_hdf5; \
	pip install --no-binary=h5py h5py numpy; \
	cd /tmp && ./build_rttov; \
	rm -r /tmp/*
