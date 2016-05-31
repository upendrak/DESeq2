FROM r-base:latest
MAINTAINER Upendra Devisetty <upendra@cyverse.org>
LABEL Description "This Dockerfile is for DESeq2"

# Run updates
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install wget -y
RUN apt-get install r-base-dev -y
RUN apt-get install libxml2 -y
RUN apt-get install libxml2-dev -y

RUN Rscript -e 'source("http://bioconductor.org/biocLite.R"); biocLite("DESeq2");'
RUN Rscript -e 'install.packages("getopt");'
RUN Rscript -e 'install.packages("gplots");'

RUN wget https://raw.githubusercontent.com/upendrak/DESeq2/master/run_DESeq2.R
RUN chmod +x /run_DESeq2.R && cp /run_DESeq2.R /usr/bin

ENTRYPOINT ["run_DESeq2.R"]
CMD ["-h"]

