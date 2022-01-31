set time on
set timing on
DROP TABLE sampledata;
CREATE TABLE sampledata (
  sampleid NUMBER,
  samplestring  CHAR(400),
  sampledate DATE,
  CONSTRAINT sampledata_pk PRIMARY KEY (sampleid)
); 

INSERT /*+ APPEND */ INTO sampledata
SELECT level AS sampleid,
       DBMS_RANDOM.string('L',TRUNC(DBMS_RANDOM.value(1,100))) AS samplestring,
       TRUNC(SYSDATE + DBMS_RANDOM.value(0,366)) AS sampledate
FROM   dual
CONNECT BY level <= 1000000;
COMMIT;


set colsep ,
set headsep off
set pagesize 0
set trimspool on
set linesize 500
set feedback off
set heading off

spool /tmp/gathered_data.csv


SELECT * FROM sampledata
order by sampleid 
fetch first 100 rows only;

spool off
