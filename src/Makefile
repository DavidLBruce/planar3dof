# Makefile
#
# Makefile for the sim src directory.
#
################################################################################

SUBDIRS =  ../bin


all : 
	@for subDir in $(SUBDIRS) ; do \
		( cd $$subDir && $(MAKE) $@  ) ; \
    test=$$? ; \
		if [ $$test != 0 ] ; then exit $$test ; fi \
	done


clean :
	@for subDir in $(SUBDIRS) ; do \
		( cd $$subDir && $(MAKE) $@  ) ; \
    test=$$? ; \
		if [ $$test != 0 ] ; then exit $$test ; fi \
	done


