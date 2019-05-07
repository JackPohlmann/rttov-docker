# RTTOV Docker image

Builds RTTOV Docker image with python wrapper and hdf5 functionality.

## Instructions

Note that all the instructions assume that the user is a member of the docker group.
If not, any command beginning with docker must be prepended with the `sudo` command.
It is recommended that any primary docker user is added to the docker goup with:

```
$ usermod -a -G docker <user>
```

### Recommended:

1. Navigate to the directory and run the `setup_rttov` script to download RTTOV12 before building.

  - Alternatively, download RTTOV from the [NWP SAF website](https://www.nwpsaf.eu/site/software/rttov/) and manually unzip the file into a subdirectory. The default `RTTOV_INSTALL_DIR` variable is `rttov12`, however this can be changed within the Dockerfile to match whatever the desired subdirectory is.

2. Download any necessary RTTOV coefficients from the NWP SAF website and save them in the necessary locations as outlined in the RTTOV user guide.

3. Generate the docker image by running `docker build --tag=rttov .` from within the directroy.

### Simple installation:

- Immediately generate the docker image by running `docker build --tag=rttov .` from within the directroy.
This will skip adding any supplemental RTTOV coefficient files. 

### After

Once built, the image can be tested with:

```
$ docker run --rm -it rttov bash
root@<docker-id>: cd /usr/local/rttov12/rttov_test
root@<docker-id>: ./test_rttov12.sh ARCH=gfortran
```

and the image can be exited by simply typing `exit`.

## Notes

This is a "raw" docker image: it does not run any application nor does it have a default directory.
The foremost purpose of this image is to use it as a base image for external applications.
