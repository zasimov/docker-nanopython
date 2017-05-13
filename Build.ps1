docker build -t nanopython:3.6.1 -f .\Dockerfile.python36 .
docker tag nanopython:3.6.1 nanopython:3.6
docker tag nanopython:36 nanopython:3