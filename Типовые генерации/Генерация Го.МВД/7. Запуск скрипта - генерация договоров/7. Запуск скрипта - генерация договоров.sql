--http://portal.vuso.ua/issues/127289
--Генерация Го.МВД. Описание алгоритма

/*
Скрипт состоит из повторяющихся для каждого генерируемого договора двух операторов
вызова процедуры I_UP_ADD_CUSTOM, которая выполняет всю работу по генерации договора
оператора update, который заполняет во временной таблице ID сгенерированного договора
Через каждые 5 пар операторов генерации вставляется commit. Так что даже если в процессе генерации что-то упадёт, пропадёт не вся работа, а лишь её часть.

Скрипт работает достаточно долго: генерация одного договора занимает 10..15 секунд. Но! Скрипт замечательно распараллеливается. Нужно просто разбить файл на части и запустить в нескольких экземплярах IBExpert. Мне удавалось генерировать в восемь потоков, при этом производительность сервера практически не снижалась.

Примечание: так как генерация зачастую ведётся в закрытом периоде, а также чтобы не нагружать стандартный обмен с 1С, сгенерированные договоры по умолчанию не помечаются на выгрузку в 1С.

*/

--Контроль прироста
select count(*)
--select count(*), /*вчерашний*/0 + count(*)
from D_DT_DOCUMENT T
where cast(T.STATE_CHANGE_DATE as date) = current_date --Сегодня
and T.ID_REGISTRATION_DEPARTMENT = 1497 --только ГО.МВД
and t.ID_DOC_SOURCE = 3 --Генерация
and T.ID_DOC > 3354838 --Для скорости работы



--Контроль ID (t.int_field4) по временной таблице
select
  t.int_field1 as id_temp,
  t.int_field2 as id_payment,
  t.int_field3 as id_tariff_member,
  t.int_field4 as id_doc,
  t.int_field5 as id_operation,
  t.date_field1 as doc_date,
  t.date_field2 as inure_date,
  t.date_filed3 as end_date,
  t.str_field1 as doc_number,
  t.str_field2 as customer,
  t.str_field3 as ins_type,
  t.str_field4 as arch_num,
  t.curr_field1 as ins_sum,
  t.curr_field2 as tariff,
  t.curr_filed3 as ins_pay
from t_temp_table t
where t.int_field1 in (999)
and t.int_field4 is not null