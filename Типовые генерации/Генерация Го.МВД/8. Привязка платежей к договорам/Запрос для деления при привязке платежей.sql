select T.DATE_FIELD1, count(*) --, p.id_doc
from T_TEMP_TABLE T
inner join D_DT_DOCUMENT D on D.ID_DOC = T.INT_FIELD4
inner join F_DT_PAYMENTS P on P.ID_PAYMENT = T.INT_FIELD2
where T.INT_FIELD1 = 999 and
      T.INT_FIELD4 is not null and
      P.ID_DOC is null and
      P.CF_DIVISION = 1497
--    and  T.DATE_FIELD1 in (
/*
DATE_FIELD1    COUNT
04.05.2016    522
05.05.2016    520
06.05.2016    504
10.05.2016    749
11.05.2016    495
12.05.2016    498
13.05.2016    543
16.05.2016    984
17.05.2016    507
18.05.2016    563
19.05.2016    500
20.05.2016    536
23.05.2016    792
24.05.2016    580
25.05.2016    545
26.05.2016    470
27.05.2016    522
30.05.2016    835
/**/
--                    )

group by T.DATE_FIELD1  