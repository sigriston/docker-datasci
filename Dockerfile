FROM ubuntu:14.04

MAINTAINER Thiago Sigrist <sigrist@gmail.com>

# Ensure noninteractive debconf
ENV DEBIAN_FRONTEND noninteractive

# Install add-apt-repository
RUN apt-get install -y -q software-properties-common

# Add gpg key to R packages repo
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Add R packages repo
RUN echo 'deb http://cran.rstudio.com/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list

# Add Julia PPA
RUN add-apt-repository -y ppa:staticfloat/juliareleases

# Update APT so we can start installing things
RUN apt-get update

# Install English language pack
RUN apt-get -y install language-pack-en

# Set locale to en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8

# Install R
RUN apt-get -y install r-base r-base-dev libcurl4-openssl-dev

# Install curl
RUN apt-get -y install curl

# Install python
RUN apt-get -y install python python-dev

# Install pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python

# Install cython
RUN pip install Cython

# Install numexpr and bottleneck
RUN pip install numexpr bottleneck

# Install SciPy, statsmodels and xlrd
RUN pip install scipy statsmodels xlrd

# Install freetype
RUN apt-get -y install libfreetype6 libfreetype6-dev

# Install matplotlib
RUN pip install matplotlib

# Install hdf5
RUN apt-get -y install libhdf5-dev

# Install PyTables
RUN pip install tables

# Install pandas
RUN pip install pandas

# Install ipython notebook
RUN pip install 'ipython[all]'

# Install libzmq3
RUN apt-get -y install libzmq3-dev

# Install R devtools
RUN R -e "install.packages('devtools', repos='http://cran.rstudio.com/')"

# Install rzmq
RUN R -e "options(repos=structure(c(CRAN='http://cran.rstudio.com/')));devtools::install_github('armstrtw/rzmq')"

# Install IRdisplay
RUN R -e "options(repos=structure(c(CRAN='http://cran.rstudio.com/')));devtools::install_github('takluyver/IRdisplay')"

# Install IRkernel
RUN R -e "options(repos=structure(c(CRAN='http://cran.rstudio.com/')));devtools::install_github('takluyver/IRkernel')"

# IRkernel::installspec()
RUN R -e "IRkernel::installspec()"

# Install Julia
RUN apt-get install -y julia

# Install IJulia
RUN julia -e 'Pkg.add("IJulia")'

# Install PyPlot
RUN julia -e 'Pkg.add("PyPlot")'

# Install Gadfly
RUN julia -e 'Pkg.add("Gadfly")'

# expose http
EXPOSE 80

CMD cd /root/notebooks; ipython notebook --ip=0.0.0.0 --port=80 --no-browser
