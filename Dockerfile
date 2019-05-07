# Use Python3 base
FROM python:3

# Copy RTTOV from local system
COPY . /tmp

# Environment variables
# Determines which HDF5 to build
ENV HDF5_MINOR_REL      hdf5-1.10.5 
ENV HDF5_SRC_URL   	http://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10                  
# RTTOV variables
# Somewhat hardcoded but helps
ENV RTTOV_INSTALL_DIR	rttov12
ENV RTTOV_MINOR_REL	rttov123
ENV RTTOV_SRC_URL 	http://nwpsaf.eu/downloads/james

# Install GFortran
RUN apt-get update && apt-get -y install gfortran

# Install hdf5; skips check!
# Checks should be inserted after `make` with `make check`
RUN cd /tmp                                                                        ; \ 
    echo "Getting: ${HDF5_SRC_URL}/${HDF5_MINOR_REL}/src/${HDF5_MINOR_REL}.tar.gz"                ; \ 
    wget ${HDF5_SRC_URL}/${HDF5_MINOR_REL}/src/${HDF5_MINOR_REL}.tar.gz                           ; \ 
    tar -xvf ${HDF5_MINOR_REL}.tar.gz --directory /usr/local/src                      ; \
    rm ${HDF5_MINOR_REL}.tar.gz                                                       ; \
    cd /usr/local/src/${HDF5_MINOR_REL}                                            ; \
    ./configure --enable-fortran --prefix=/usr/local/hdf5                          ; \
    make                                                                           ; \
    make install                                                                   ; \
    make check-install                                                             ; \
    for f in /usr/local/hdf5/bin/* ; do ln -s $f /usr/local/bin ; done 

# PIP installs
RUN pip install numpy && pip install --no-binary=h5py h5py

# Build RTTOV
RUN cd /tmp && ./build_rttov
