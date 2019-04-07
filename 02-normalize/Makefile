DB=enceladus
BUILD=${CURDIR}/build.sql
SCRIPTS=${CURDIR}/scripts
CSV='${CURDIR}/../data/master_plan.csv'
MASTER=$(SCRIPTS)/import.sql
NORMALIZE = $(SCRIPTS)/normalize.sql 
CLEANUP = $(SCRIPTS)/cleanup.sql 

all: normalize
	@echo "Done with all"

cleanup:
	psql $(DB) -f $(CLEANUP)

master: cleanup
	psql $(DB) -f $(MASTER)

import: master
	psql $(DB) -c "COPY import.master_plan FROM $(CSV) WITH DELIMITER ',' HEADER CSV;"

normalize: import
	psql $(DB) -f $(NORMALIZE)

clean:
	dropdb --if-exists $(DB)
	createdb $(DB)
