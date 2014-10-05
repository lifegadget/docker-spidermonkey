This is just a placeholder for now ... basic dependencies from the build documentation are included but there is a compilation error that we didn't bother to troubleshoot yet as the Ubuntu/Debian prebuilt binary is being used in our Couchbase docker image (the only one currently which needs the JS/JSON support provided by spidermonkey). This binary can be installed into a docker image with:

    # SpiderMonkey, jsawk, and resty
    RUN apt-get install -y libmozjs-24-bin \
    	&& ln -s /usr/bin/js24 /usr/local/bin/js \
    	&& echo "export JS=/usr/local/bin/js" > /etc/jsawkrc \
    	&& wget -O/usr/local/bin/jsawk http://github.com/micha/jsawk/raw/master/jsawk \
    	&& wget -O/usr/local/bin/resty http://github.com/micha/resty/raw/master/resty \
    	&& chmod +x /usr/local/bin/jsawk /usr/local/bin/resty \
    	&& { \
    		echo ""; \
    		echo "source /usr/local/bin/resty"; \
    		echo ""; \
    	} >> /etc/bash.bashrc

This is probably good enough and is the reason that this repo is on-hold. We have not deleted it yet because there may be some interest still in having a quickly deployable and footprint-minimized image based on the already small **wheezy** base image of Debian. 

If anyone wants to use this as a starting point by all means do so ... it is a reasonable starting point. If you're able to work around the compilation error that currently plagues this starting point then please drop us a PR and we'll incorporate it in.
