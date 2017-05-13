Docker image with Python to be used under Windows
=================================================

Here are scripts to build a Docker image containing Python 3.6.1 (based on microsoft/nanoserver).

Files
-----
  - Pack-Python.ps1 - downloads Python Installer, **installs Python to local system** and packs it to zip file
  - Install-Python.ps1 - will be injected to Docker image, unpacks Python inside (during build phase)
  - Buils.ps1 - builds the Docker image

How to build a Docker image containing Python
---------------------------------------------

    ./Pack-Python.ps1 3.6.1
    docker build -t <your tag> -f Dockerfile.python36 .
    
or

    ./Build.ps1

Yes, I know...
--------------

Yes, I know that python:3-windowsservercore exists. However, it is based on
windowsservercore. microsoft/nanoserver is preferred for my cases (as it's
thinner then windowsservercore).

nanopython36 image is ~1.16GB size vs ~4GB for python:3-windowsservercore.

How to get nanopython
---------------------

    docker pull zasimov/nanopython:3

Thanks for your attention!
